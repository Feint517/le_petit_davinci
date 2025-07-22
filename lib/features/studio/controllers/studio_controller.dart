import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_drawing_board/flutter_drawing_board.dart';
import 'package:flutter_drawing_board/paint_contents.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:cross_file/cross_file.dart';
import 'package:le_petit_davinci/features/studio/models/artwork_model.dart';
import 'package:le_petit_davinci/services/storage_service.dart';
import 'package:audioplayers/audioplayers.dart';

class StudioController extends GetxController {
  final StorageService _storageService = Get.find<StorageService>();
  final AudioPlayer _audioPlayer = AudioPlayer();

  // Drawing board controller - High performance drawing engine
  late DrawingController drawingController;

  // Drawing state
  final Rx<Color> selectedColor = Colors.blue.obs;
  final RxDouble brushSize = 5.0.obs;
  final Rx<DrawingTool> selectedTool = DrawingTool.brush.obs;
  final RxBool isDrawing = false.obs;
  final RxBool hasUnsavedChanges = false.obs;

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
    const Color(0xFFE53E3E), // Red
    const Color(0xFF3182CE), // Blue
    const Color(0xFF38A169), // Green
    const Color(0xFFD69E2E), // Yellow
    const Color(0xFFDD6B20), // Orange
    const Color(0xFF9F7AEA), // Purple
    const Color(0xFFED64A6), // Pink
    const Color(0xFF975A16), // Brown
    const Color(0xFF1A202C), // Black
    const Color(0xFF718096), // Grey
  ];

  // Available brush sizes optimized for kids
  final List<double> availableSizes = [3.0, 6.0, 12.0, 20.0];

  @override
  void onInit() {
    super.onInit();
    _initializeDrawingController();
    loadArtworks();
    initializeTemplates();
  }

  @override
  void onClose() {
    drawingController.dispose();
    _audioPlayer.dispose();
    super.onClose();
  }

  void _initializeDrawingController() {
    drawingController = DrawingController();

    // Set default drawing style optimized for kids using setStyle
    drawingController.setStyle(
      color: selectedColor.value,
      strokeWidth: brushSize.value,
      style: PaintingStyle.stroke,
      strokeCap: StrokeCap.round,
      strokeJoin: StrokeJoin.round,
      isAntiAlias: true, // Smooth lines
    );

    // Set default drawing tool to SimpleLine (freehand drawing)
    drawingController.setPaintContent(SimpleLine());

    // Listen for drawing changes
    drawingController.addListener(() {
      hasUnsavedChanges.value = drawingController.getHistory.isNotEmpty;
    });
  }

  // Enhanced drawing functions with audio feedback
  void selectColor(Color color) {
    selectedColor.value = color;
    if (selectedTool.value == DrawingTool.eraser) {
      selectedTool.value = DrawingTool.brush;
    }

    // Update drawing controller paint
    _updateDrawingPaint();

    // Play color selection sound
    _playSound('color_select.mp3');

    // Haptic feedback
    HapticFeedback.lightImpact();

    // Visual feedback
    Get.snackbar(
      '',
      '',
      duration: const Duration(milliseconds: 800),
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: color.withOpacity(0.9),
      colorText: _getContrastColor(color),
      messageText: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.palette, color: _getContrastColor(color), size: 16),
          const SizedBox(width: 8),
          Text(
            'Couleur ${_getColorName(color)} sélectionnée!',
            style: TextStyle(
              color: _getContrastColor(color),
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
      titleText: const SizedBox.shrink(),
      margin: const EdgeInsets.only(left: 16, right: 16, bottom: 120),
    );
  }

  void selectBrushSize(double size) {
    brushSize.value = size;
    _updateDrawingPaint();
    _playSound('brush_select.mp3');
    HapticFeedback.selectionClick();
  }

  void selectTool(DrawingTool tool) {
    selectedTool.value = tool;

    switch (tool) {
      case DrawingTool.brush:
        // Set brush tool with SimpleLine for freehand drawing
        drawingController.setPaintContent(SimpleLine());
        drawingController.setStyle(
          color: selectedColor.value,
          strokeWidth: brushSize.value,
          style: PaintingStyle.stroke,
          strokeCap: StrokeCap.round,
          strokeJoin: StrokeJoin.round,
          isAntiAlias: true,
        );
        break;
      case DrawingTool.eraser:
        // Set eraser tool
        drawingController.setPaintContent(Eraser());
        drawingController.setStyle(
          strokeWidth: brushSize.value * 1.5, // Bigger eraser
          strokeCap: StrokeCap.round,
        );
        break;
      default:
        break;
    }

    _playSound('tool_select.mp3');
    HapticFeedback.mediumImpact();
  }

  void _updateDrawingPaint() {
    if (selectedTool.value == DrawingTool.brush) {
      drawingController.setStyle(
        color: selectedColor.value,
        strokeWidth: brushSize.value,
        style: PaintingStyle.stroke,
        strokeCap: StrokeCap.round,
        strokeJoin: StrokeJoin.round,
        isAntiAlias: true,
      );
    }
  }

  // Undo/Redo with improved feedback
  void undo() {
    if (drawingController.canUndo()) {
      drawingController.undo();
      _playSound('undo.mp3');
      HapticFeedback.lightImpact();

      Get.snackbar(
        'Annulé!',
        'Dernière action annulée',
        duration: const Duration(seconds: 1),
        backgroundColor: Colors.orange.withOpacity(0.8),
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.only(left: 16, right: 16, bottom: 120),
      );
    }
  }

  void redo() {
    if (drawingController.canRedo()) {
      drawingController.redo();
      _playSound('redo.mp3');
      HapticFeedback.lightImpact();

      Get.snackbar(
        'Refait!',
        'Action refaite',
        duration: const Duration(seconds: 1),
        backgroundColor: Colors.green.withOpacity(0.8),
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.only(left: 16, right: 16, bottom: 120),
      );
    }
  }

  void clearCanvas() {
    drawingController.clear();
    hasUnsavedChanges.value = false;
    _playSound('clear.mp3');
    HapticFeedback.mediumImpact();
  }

  void selectTemplate(TemplateModel? template) {
    selectedTemplate.value = template;
    clearCanvas(); // Clear existing drawing when selecting template

    if (template != null) {
      _playSound('template_select.mp3');
      Get.snackbar(
        'Modèle sélectionné!',
        'Tu peux maintenant dessiner sur ${template.name}',
        backgroundColor: Colors.blue.withOpacity(0.8),
        colorText: Colors.white,
        duration: const Duration(seconds: 2),
      );
    }
  }

  // Enhanced save with better error handling
  Future<void> saveArtwork({String? title}) async {
    try {
      isLoading.value = true;

      if (drawingController.getHistory.isEmpty) {
        Get.snackbar(
          'Attention',
          'Dessine quelque chose avant de sauvegarder!',
          backgroundColor: Colors.orange.withOpacity(0.8),
          colorText: Colors.white,
        );
        return;
      }

      final artworkTitle = title ?? currentArtworkTitle.value;
      final artworkId =
          currentArtworkId.value.isEmpty
              ? _generateArtworkId()
              : currentArtworkId.value;

      // Capture drawing as image with high quality - Fixed ByteData conversion
      final imageData = await drawingController.getImageData();
      if (imageData == null) {
        throw Exception('Impossible de capturer le dessin');
      }

      // Convert ByteData to Uint8List
      final uint8ListData = imageData.buffer.asUint8List();

      // Save image to file
      final imagePath = await _saveImageToFile(uint8ListData, artworkId);

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
          'strokesCount': drawingController.getHistory.length,
          'colorsUsed': [selectedColor.value.toString()],
          'brushSizeUsed': brushSize.value,
          'lastTool': selectedTool.value.toString(),
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
      hasUnsavedChanges.value = false;

      // Success feedback
      _playSound('save_success.mp3');
      HapticFeedback.heavyImpact();

      Get.snackbar(
        'Bravo! 🎨',
        'Ton dessin "$artworkTitle" est sauvegardé!',
        backgroundColor: Colors.green.withOpacity(0.9),
        colorText: Colors.white,
        duration: const Duration(seconds: 3),
        snackPosition: SnackPosition.TOP,
      );
    } catch (e) {
      Get.snackbar(
        'Erreur',
        'Impossible de sauvegarder: ${e.toString()}',
        backgroundColor: Colors.red.withOpacity(0.8),
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  // Enhanced sharing with better UX
  Future<void> shareWithParent(String artworkId) async {
    try {
      final artwork = artworks.firstWhere((a) => a.id == artworkId);
      final updatedArtwork = artwork.copyWith(isSharedWithParent: true);

      await _saveArtworkToStorage(updatedArtwork);

      final index = artworks.indexWhere((a) => a.id == artworkId);
      artworks[index] = updatedArtwork;

      _playSound('share_success.mp3');
      HapticFeedback.heavyImpact();

      Get.snackbar(
        'Partagé! 👨‍👩‍👧‍👦',
        'Papa et maman vont adorer ton dessin!',
        backgroundColor: Colors.blue.withOpacity(0.9),
        colorText: Colors.white,
        duration: const Duration(seconds: 3),
      );

      // TODO: Send notification to parent dashboard
    } catch (e) {
      Get.snackbar('Erreur', 'Impossible de partager le dessin');
    }
  }

  // Export with multiple format support
  Future<void> exportArtwork(String artworkId) async {
    try {
      final artwork = artworks.firstWhere((a) => a.id == artworkId);
      final file = XFile(artwork.imagePath);

      await Share.shareXFiles(
        [file],
        text:
            'Regardez le superbe dessin "${artwork.title}" créé avec Le Petit Davinci! 🎨',
        subject: 'Dessin - ${artwork.title}',
      );

      _playSound('export_success.mp3');
    } catch (e) {
      Get.snackbar('Erreur', 'Impossible d\'exporter le dessin');
    }
  }

  // Load artworks with better error handling
  Future<void> loadArtworks() async {
    try {
      isLoading.value = true;

      final artworksList = _storageService.getList('artworks') ?? [];
      artworks.value =
          artworksList
              .map((json) {
                try {
                  return ArtworkModel.fromJson(Map<String, dynamic>.from(json));
                } catch (e) {
                  print('Error parsing artwork: $e');
                  return null;
                }
              })
              .where((artwork) => artwork != null)
              .cast<ArtworkModel>()
              .toList()
            ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
    } catch (e) {
      print('Error loading artworks: $e');
      Get.snackbar('Erreur', 'Impossible de charger les dessins');
    } finally {
      isLoading.value = false;
    }
  }

  // Delete with confirmation and feedback
  Future<void> deleteArtwork(String artworkId) async {
    try {
      // Find artwork first
      final artwork = artworks.firstWhere((a) => a.id == artworkId);

      // Remove from list
      artworks.removeWhere((a) => a.id == artworkId);

      // Delete from storage
      await _deleteArtworkFromStorage(artworkId);

      _playSound('delete.mp3');

      Get.snackbar(
        'Supprimé 🗑️',
        '"${artwork.title}" a été supprimé',
        backgroundColor: Colors.orange.withOpacity(0.8),
        colorText: Colors.white,
        duration: const Duration(seconds: 2),
      );
    } catch (e) {
      Get.snackbar('Erreur', 'Impossible de supprimer le dessin');
    }
  }

  // Start new artwork with clean state
  void startNewArtwork() {
    clearCanvas();
    currentArtworkId.value = '';
    currentArtworkTitle.value = 'Mon nouveau dessin';
    selectedTemplate.value = null;
    hasUnsavedChanges.value = false;

    // Reset to default drawing settings
    selectedTool.value = DrawingTool.brush;
    selectedColor.value = Colors.blue;
    brushSize.value = 5.0;
    _updateDrawingPaint();
  }

  // Load existing artwork (placeholder for future enhancement)
  Future<void> loadArtworkForEditing(String artworkId) async {
    try {
      final artwork = artworks.firstWhere((a) => a.id == artworkId);
      currentArtworkId.value = artwork.id;
      currentArtworkTitle.value = artwork.title;

      // Note: Loading actual drawing data would require storing
      // the drawing board's JSON data, not just the final image
      clearCanvas();
      hasUnsavedChanges.value = false;
    } catch (e) {
      Get.snackbar(
        'Erreur',
        'Impossible de charger le dessin pour modification',
      );
    }
  }

  // Initialize templates with proper data
  void initializeTemplates() {
    templates.value = [
      TemplateModel(
        id: 'animal_cat',
        name: 'Chat Mignon',
        previewImagePath: 'assets/templates/previews/cat_preview.png',
        templateImagePath: 'assets/templates/cat_template.png',
        category: TemplateCategory.animals,
        difficulty: 1,
        colors: ['orange', 'black', 'white'],
        educationalPrompt: 'Colorie ce joli chat avec tes couleurs préférées!',
      ),
      TemplateModel(
        id: 'shape_circle',
        name: 'Cercle Parfait',
        previewImagePath: 'assets/templates/previews/circle_preview.png',
        templateImagePath: 'assets/templates/circle_template.png',
        category: TemplateCategory.shapes,
        difficulty: 1,
        educationalPrompt: 'Trace un beau cercle et décore-le!',
      ),
      TemplateModel(
        id: 'letter_a',
        name: 'Lettre A',
        previewImagePath: 'assets/templates/previews/letter_a_preview.png',
        templateImagePath: 'assets/templates/letter_a_template.png',
        category: TemplateCategory.letters,
        difficulty: 1,
        educationalPrompt: 'Trace la lettre A comme dans "Ami"!',
      ),
      TemplateModel(
        id: 'number_5',
        name: 'Chiffre 5',
        previewImagePath: 'assets/templates/previews/number_5_preview.png',
        templateImagePath: 'assets/templates/number_5_template.png',
        category: TemplateCategory.numbers,
        difficulty: 1,
        educationalPrompt: 'Écris le chiffre 5 et dessine 5 objets!',
      ),
      TemplateModel(
        id: 'seasonal_sun',
        name: 'Soleil d\'Été',
        previewImagePath: 'assets/templates/previews/sun_preview.png',
        templateImagePath: 'assets/templates/sun_template.png',
        category: TemplateCategory.seasonal,
        difficulty: 2,
        educationalPrompt: 'Dessine un beau soleil pour l\'été!',
      ),
    ];
  }

  // Audio feedback system
  Future<void> _playSound(String soundFile) async {
    try {
      await _audioPlayer.play(AssetSource('sounds/$soundFile'));
    } catch (e) {
      // Silently fail if sound file doesn't exist
      print('Sound file not found: $soundFile');
    }
  }

  // Helper methods
  String _generateArtworkId() {
    return 'artwork_${DateTime.now().millisecondsSinceEpoch}_${Random().nextInt(1000)}';
  }

  Future<String> _saveImageToFile(Uint8List imageData, String artworkId) async {
    final directory = await getApplicationDocumentsDirectory();
    final artworksDir = Directory('${directory.path}/artworks');

    if (!await artworksDir.exists()) {
      await artworksDir.create(recursive: true);
    }

    final file = File('${artworksDir.path}/$artworkId.png');
    await file.writeAsBytes(imageData);
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

  String _getColorName(Color color) {
    if (color.value == 0xFFE53E3E) return 'Rouge';
    if (color.value == 0xFF3182CE) return 'Bleu';
    if (color.value == 0xFF38A169) return 'Vert';
    if (color.value == 0xFFD69E2E) return 'Jaune';
    if (color.value == 0xFFDD6B20) return 'Orange';
    if (color.value == 0xFF9F7AEA) return 'Violet';
    if (color.value == 0xFFED64A6) return 'Rose';
    if (color.value == 0xFF975A16) return 'Marron';
    if (color.value == 0xFF1A202C) return 'Noir';
    if (color.value == 0xFF718096) return 'Gris';
    return 'Personnalisée';
  }

  Color _getContrastColor(Color color) {
    final luminance =
        (0.299 * color.red + 0.587 * color.green + 0.114 * color.blue) / 255;
    return luminance > 0.5 ? Colors.black : Colors.white;
  }
}
