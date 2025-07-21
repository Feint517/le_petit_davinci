import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:le_petit_davinci/features/studio/models/artwork_model.dart';
import 'package:le_petit_davinci/services/storage_service.dart';

class StudioController extends GetxController {
  final StorageService _storageService = Get.find<StorageService>();

  // Drawing state
  final RxList<DrawingPath> drawingPaths = <DrawingPath>[].obs;
  final RxList<DrawingPath> redoPaths = <DrawingPath>[].obs;
  final Rx<Color> selectedColor = Colors.blue.obs;
  final RxDouble brushSize = 5.0.obs;
  final Rx<DrawingTool> selectedTool = DrawingTool.brush.obs;
  final RxBool isDrawing = false.obs;

  // Artwork management
  final RxList<ArtworkModel> artworks = <ArtworkModel>[].obs;
  final RxBool isLoading = false.obs;
  final RxString currentArtworkId = ''.obs;
  final RxString currentArtworkTitle = 'Mon dessin'.obs;

  // Templates
  final RxList<TemplateModel> templates = <TemplateModel>[].obs;
  final Rx<TemplateModel?> selectedTemplate = Rx<TemplateModel?>(null);

  // Canvas
  final GlobalKey canvasKey = GlobalKey();

  // Available colors for child-friendly palette
  final List<Color> availableColors = [
    Colors.red,
    Colors.blue,
    Colors.green,
    Colors.yellow,
    Colors.orange,
    Colors.purple,
    Colors.pink,
    Colors.brown,
    Colors.black,
    Colors.grey,
  ];

  // Available brush sizes
  final List<double> availableSizes = [2.0, 5.0, 10.0, 15.0];

  @override
  void onInit() {
    super.onInit();
    loadArtworks();
    initializeTemplates();
  }

  // Drawing functions
  void startDrawing(Offset point) {
    isDrawing.value = true;
    redoPaths.clear(); // Clear redo history when starting new drawing

    final newPath = DrawingPath(
      points: [point],
      color:
          selectedTool.value == DrawingTool.eraser
              ? Colors.transparent
              : selectedColor.value,
      strokeWidth: brushSize.value,
      tool: selectedTool.value,
    );

    drawingPaths.add(newPath);
  }

  void updateDrawing(Offset point) {
    if (isDrawing.value && drawingPaths.isNotEmpty) {
      final currentPath = drawingPaths.last;
      final updatedPoints = List<Offset>.from(currentPath.points)..add(point);

      drawingPaths[drawingPaths.length - 1] = DrawingPath(
        points: updatedPoints,
        color: currentPath.color,
        strokeWidth: currentPath.strokeWidth,
        tool: currentPath.tool,
      );
      drawingPaths.refresh();
    }
  }

  void endDrawing() {
    isDrawing.value = false;
  }

  void undo() {
    if (drawingPaths.isNotEmpty) {
      final lastPath = drawingPaths.removeLast();
      redoPaths.add(lastPath);
    }
  }

  void redo() {
    if (redoPaths.isNotEmpty) {
      final pathToRedo = redoPaths.removeLast();
      drawingPaths.add(pathToRedo);
    }
  }

  void clearCanvas() {
    drawingPaths.clear();
    redoPaths.clear();
  }

  void selectColor(Color color) {
    selectedColor.value = color;
    if (selectedTool.value == DrawingTool.eraser) {
      selectedTool.value = DrawingTool.brush;
    }
  }

  void selectBrushSize(double size) {
    brushSize.value = size;
  }

  void selectTool(DrawingTool tool) {
    selectedTool.value = tool;
  }

  void selectTemplate(TemplateModel? template) {
    selectedTemplate.value = template;
    clearCanvas(); // Clear existing drawing when selecting template
  }

  // Save artwork
  Future<void> saveArtwork({String? title}) async {
    try {
      isLoading.value = true;

      final artworkTitle = title ?? currentArtworkTitle.value;
      final artworkId =
          currentArtworkId.value.isEmpty
              ? _generateArtworkId()
              : currentArtworkId.value;

      // Capture canvas as image
      final image = await _captureCanvas();
      if (image == null) {
        Get.snackbar('Erreur', 'Impossible de sauvegarder le dessin');
        return;
      }

      // Save image to file
      final imagePath = await _saveImageToFile(image, artworkId);

      // Create artwork model
      final artwork = ArtworkModel(
        id: artworkId,
        title: artworkTitle,
        createdAt: DateTime.now(),
        lastModified: DateTime.now(),
        imagePath: imagePath,
        templateId: selectedTemplate.value?.id,
        type:
            selectedTemplate.value != null
                ? ArtworkType.template
                : ArtworkType.freeDrawing,
        metadata: {
          'pathsCount': drawingPaths.length,
          'colorsUsed': _getUsedColors(),
        },
      );

      // Save to local storage
      await _saveArtworkToStorage(artwork);

      // Update local list
      final existingIndex = artworks.indexWhere((a) => a.id == artworkId);
      if (existingIndex != -1) {
        artworks[existingIndex] = artwork;
      } else {
        artworks.insert(0, artwork);
      }

      currentArtworkId.value = artworkId;
      currentArtworkTitle.value = artworkTitle;

      Get.snackbar(
        'Succès',
        'Dessin sauvegardé!',
        backgroundColor: Colors.green.withOpacity(0.8),
        colorText: Colors.white,
      );
    } catch (e) {
      Get.snackbar('Erreur', 'Impossible de sauvegarder: $e');
    } finally {
      isLoading.value = false;
    }
  }

  // Share artwork with parents
  Future<void> shareWithParent(String artworkId) async {
    try {
      final artwork = artworks.firstWhere((a) => a.id == artworkId);
      final updatedArtwork = artwork.copyWith(isSharedWithParent: true);

      await _saveArtworkToStorage(updatedArtwork);

      final index = artworks.indexWhere((a) => a.id == artworkId);
      artworks[index] = updatedArtwork;

      Get.snackbar(
        'Partagé!',
        'Ton dessin a été envoyé à papa et maman!',
        backgroundColor: Colors.blue.withOpacity(0.8),
        colorText: Colors.white,
      );

      // TODO: Integrate with parent dashboard notification system
    } catch (e) {
      Get.snackbar('Erreur', 'Impossible de partager le dessin');
    }
  }

  // Export artwork
  Future<void> exportArtwork(String artworkId) async {
    try {
      final artwork = artworks.firstWhere((a) => a.id == artworkId);
      final file = File(artwork.imagePath);

      await Share.shareXFiles([
        XFile(file.path),
      ], text: 'Mon dessin: ${artwork.title}');
    } catch (e) {
      Get.snackbar('Erreur', 'Impossible d\'exporter le dessin');
    }
  }

  // Load artworks from storage
  Future<void> loadArtworks() async {
    try {
      isLoading.value = true;

      final artworksList = _storageService.getList('artworks') ?? [];
      artworks.value =
          artworksList
              .map(
                (json) =>
                    ArtworkModel.fromJson(Map<String, dynamic>.from(json)),
              )
              .toList()
            ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
    } catch (e) {
      print('Error loading artworks: $e');
    } finally {
      isLoading.value = false;
    }
  }

  // Delete artwork
  Future<void> deleteArtwork(String artworkId) async {
    try {
      // Remove from list
      artworks.removeWhere((a) => a.id == artworkId);

      // Delete from storage
      await _deleteArtworkFromStorage(artworkId);

      Get.snackbar(
        'Supprimé',
        'Dessin supprimé',
        backgroundColor: Colors.orange.withOpacity(0.8),
        colorText: Colors.white,
      );
    } catch (e) {
      Get.snackbar('Erreur', 'Impossible de supprimer le dessin');
    }
  }

  // Start new artwork
  void startNewArtwork() {
    clearCanvas();
    currentArtworkId.value = '';
    currentArtworkTitle.value = 'Mon dessin';
    selectedTemplate.value = null;
  }

  // Load existing artwork for editing
  Future<void> loadArtworkForEditing(String artworkId) async {
    try {
      final artwork = artworks.firstWhere((a) => a.id == artworkId);
      currentArtworkId.value = artwork.id;
      currentArtworkTitle.value = artwork.title;

      // Note: In a full implementation, you'd need to store and restore
      // the actual drawing paths, not just the final image
      // For now, we'll start with a blank canvas
      clearCanvas();
    } catch (e) {
      Get.snackbar('Erreur', 'Impossible de charger le dessin');
    }
  }

  // Initialize default templates
  void initializeTemplates() {
    templates.value = [
      TemplateModel(
        id: 'animal_cat',
        name: 'Chat',
        previewImagePath: 'assets/templates/cat_preview.png',
        templateImagePath: 'assets/templates/cat_template.png',
        category: TemplateCategory.animals,
        difficulty: 1,
        colors: ['orange', 'black', 'white'],
        educationalPrompt: 'Colorie le chat avec de belles couleurs!',
      ),
      TemplateModel(
        id: 'shape_circle',
        name: 'Cercle',
        previewImagePath: 'assets/templates/circle_preview.png',
        templateImagePath: 'assets/templates/circle_template.png',
        category: TemplateCategory.shapes,
        difficulty: 1,
        educationalPrompt: 'Trace un beau cercle!',
      ),
      TemplateModel(
        id: 'letter_a',
        name: 'Lettre A',
        previewImagePath: 'assets/templates/letter_a_preview.png',
        templateImagePath: 'assets/templates/letter_a_template.png',
        category: TemplateCategory.letters,
        difficulty: 1,
        educationalPrompt: 'Trace la lettre A comme dans "Ami"!',
      ),
    ];
  }

  // Helper methods
  String _generateArtworkId() {
    return 'artwork_${DateTime.now().millisecondsSinceEpoch}_${Random().nextInt(1000)}';
  }

  Future<ui.Image?> _captureCanvas() async {
    try {
      final RenderRepaintBoundary boundary =
          canvasKey.currentContext?.findRenderObject() as RenderRepaintBoundary;
      return await boundary.toImage(pixelRatio: 2.0);
    } catch (e) {
      print('Error capturing canvas: $e');
      return null;
    }
  }

  Future<String> _saveImageToFile(ui.Image image, String artworkId) async {
    final directory = await getApplicationDocumentsDirectory();
    final artworksDir = Directory('${directory.path}/artworks');

    if (!await artworksDir.exists()) {
      await artworksDir.create(recursive: true);
    }

    final file = File('${artworksDir.path}/$artworkId.png');
    final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    final buffer = byteData!.buffer.asUint8List();

    await file.writeAsBytes(buffer);
    return file.path;
  }

  Future<void> _saveArtworkToStorage(ArtworkModel artwork) async {
    final artworksList = _storageService.getList('artworks') ?? [];

    // Remove existing artwork with same ID
    artworksList.removeWhere((json) => json['id'] == artwork.id);

    // Add new artwork
    artworksList.insert(0, artwork.toJson());

    await _storageService.setList('artworks', artworksList);
  }

  Future<void> _deleteArtworkFromStorage(String artworkId) async {
    final artworksList = _storageService.getList('artworks') ?? [];
    artworksList.removeWhere((json) => json['id'] == artworkId);
    await _storageService.setList('artworks', artworksList);

    // Also delete image file
    try {
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/artworks/$artworkId.png');
      if (await file.exists()) {
        await file.delete();
      }
    } catch (e) {
      print('Error deleting image file: $e');
    }
  }

  List<String> _getUsedColors() {
    final colors = <String>{};
    for (final path in drawingPaths) {
      colors.add(path.color.toString());
    }
    return colors.toList();
  }
}
