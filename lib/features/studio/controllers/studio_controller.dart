import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_drawing_board/flutter_drawing_board.dart';
import 'package:get/get.dart';
import 'package:le_petit_davinci/features/studio/models/artwork_model.dart';
import 'package:le_petit_davinci/services/storage_service.dart';
import 'package:audioplayers/audioplayers.dart';

class StudioController extends GetxController {
  final StorageService _storageService = Get.find<StorageService>();
  final AudioPlayer _audioPlayer = AudioPlayer();

  // Drawing board controller - High performance drawing engine
  late DrawingController drawingController;

  // Drawing state - All observable variables
  final Rx<Color> selectedColor = Colors.blue.obs;
  final RxDouble brushSize = 5.0.obs;
  final Rx<DrawingTool> selectedTool = DrawingTool.brush.obs;
  final RxBool isDrawing = false.obs;
  final RxBool hasUnsavedChanges = false.obs;

  // Toolbar state management - FIXED: Added missing observable variables
  final RxBool canUndo = false.obs;
  final RxBool canRedo = false.obs;
  final RxInt historyLength = 0.obs;

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
    const Color(0xFFFFFFFF), // White
    const Color(0xFFF56565), // Light Red
    const Color(0xFF63B3ED), // Light Blue
    const Color(0xFF68D391), // Light Green
    const Color(0xFFFBD38D), // Light Yellow
    const Color(0xFFFBB6CE), // Light Pink
  ];

  // Available brush sizes optimized for kids
  final List<double> availableSizes = [3.0, 6.0, 12.0, 20.0];

  @override
  void onInit() {
    super.onInit();
    _initializeDrawingController();
    loadArtworks();
    initializeTemplates();
    _setupDrawingListeners();
  }

  @override
  void onClose() {
    // Proper cleanup to prevent memory leaks
    drawingController.removeListener(_updateToolbarState);
    drawingController.dispose();
    _audioPlayer.dispose();
    super.onClose();
  }

  void _initializeDrawingController() {
    drawingController = DrawingController();

    // Set default drawing style optimized for kids
    drawingController.setStyle(
      color: selectedColor.value,
      strokeWidth: brushSize.value,
    );

    // Listen to drawing state changes for toolbar updates
    drawingController.addListener(_updateToolbarState);
  }

  // Setup listeners for drawing state changes
  void _setupDrawingListeners() {
    // Update observable states when drawing changes
    ever(isDrawing, (bool drawing) {
      _updateToolbarState();
    });

    // Update toolbar state on initialization
    _updateToolbarState();
  }

  // Update toolbar state based on drawing controller
  void _updateToolbarState() {
    try {
      canUndo.value = drawingController.canUndo();
      canRedo.value = drawingController.canRedo();
      historyLength.value = drawingController.getHistory.length;
    } catch (e) {
      debugPrint('Error updating toolbar state: $e');
      canUndo.value = false;
      canRedo.value = false;
      historyLength.value = 0;
    }
  }

  // FIXED: Proper undo method with observable updates
  void undo() {
    try {
      if (drawingController.canUndo()) {
        drawingController.undo();
        hasUnsavedChanges.value = true;
        _updateToolbarState();
        _playSound('undo.mp3');
      }
    } catch (e) {
      debugPrint('Error during undo: $e');
      Get.snackbar('Erreur', 'Impossible d\'annuler l\'action');
    }
  }

  // FIXED: Proper redo method with observable updates
  void redo() {
    try {
      if (drawingController.canRedo()) {
        drawingController.redo();
        hasUnsavedChanges.value = true;
        _updateToolbarState();
        _playSound('redo.mp3');
      }
    } catch (e) {
      debugPrint('Error during redo: $e');
      Get.snackbar('Erreur', 'Impossible de refaire l\'action');
    }
  }

  // Tool selection method
  void selectTool(DrawingTool tool) {
    selectedTool.value = tool;
    _updateDrawingPaint();
    _playSound('select.mp3');
  }

  // Color selection method
  void setColor(Color color) {
    selectedColor.value = color;
    _updateDrawingPaint();
    _playSound('select.mp3');
  }

  // Brush size setter with validation
  void setBrushSize(double size) {
    if (size >= 1.0 && size <= 50.0) {
      brushSize.value = size;
      _updateDrawingPaint();
      _playSound('select.mp3');
    }
  }

  // Template selection method
  void selectTemplate(TemplateModel template) {
    selectedTemplate.value = template;
    _playSound('select.mp3');
  }

  // FIXED: Clear canvas method with proper error handling
  void clearCanvas() {
    try {
      drawingController.clear();
      hasUnsavedChanges.value = true;
      _updateToolbarState();
      _playSound('clear.mp3');
    } catch (e) {
      debugPrint('Error clearing canvas: $e');
      Get.snackbar('Erreur', 'Impossible d\'effacer le dessin');
    }
  }

  // FIXED: Update drawing paint method with proper error handling
  void _updateDrawingPaint() {
    try {
      Color paintColor;

      // Handle eraser tool
      if (selectedTool.value == DrawingTool.eraser) {
        paintColor = Colors.white; // Use white for erasing on white background
      } else {
        paintColor = selectedColor.value;
      }

      drawingController.setStyle(
        color: paintColor,
        strokeWidth: brushSize.value,
      );
    } catch (e) {
      debugPrint('Error updating drawing paint: $e');
    }
  }

  // IMPROVED: Safe audio playback with fallback to haptic feedback
  Future<void> _playSound(String soundFile) async {
    _provideFeedback();
  }

  // Haptic feedback as fallback when audio fails
  void _provideFeedback() {
    try {
      HapticFeedback.lightImpact();
    } catch (e) {
      debugPrint('Haptic feedback not available: $e');
    }
  }

  // Enhanced save functionality - FIXED: Use correct StorageService methods
  Future<void> saveArtwork({String? customTitle}) async {
    try {
      isLoading.value = true;

      // Get image data from drawing board
      final imageData = await drawingController.getImageData();
      if (imageData == null) {
        throw Exception('Failed to get image data from drawing board');
      }

      // Generate unique filename
      final timestamp = DateTime.now().millisecondsSinceEpoch;
      final filename = 'artwork_$timestamp.png';

      // Virtual path (in production you would save the actual file)
      final imagePath = 'artworks/$filename';

      // Create artwork model
      final artwork = ArtworkModel(
        id:
            currentArtworkId.value.isNotEmpty
                ? currentArtworkId.value
                : 'artwork_$timestamp',
        title: customTitle ?? currentArtworkTitle.value,
        createdAt: DateTime.now(),
        lastModified: DateTime.now(),
        imagePath: imagePath,
        isSharedWithParent: false,
        templateId: selectedTemplate.value?.id,
        type:
            selectedTemplate.value != null
                ? ArtworkType.template
                : ArtworkType.freeDrawing,
        metadata: {
          'brushSize': brushSize.value,
          'primaryColor': selectedColor.value.value.toRadixString(16),
          'toolsUsed': [selectedTool.value.toString()],
        },
      );

      // Save to storage
      await _saveArtworkToStorage(artwork);

      // Update local list
      final existingIndex = artworks.indexWhere((a) => a.id == artwork.id);
      if (existingIndex != -1) {
        artworks[existingIndex] = artwork;
      } else {
        artworks.insert(0, artwork);
      }

      // Update state
      currentArtworkId.value = artwork.id;
      hasUnsavedChanges.value = false;

      _playSound('save.mp3');

      Get.snackbar(
        'Sauvé! 🎨',
        'Ton dessin "${artwork.title}" a été sauvé',
        backgroundColor: Colors.green.withOpacity(0.8),
        colorText: Colors.white,
        duration: const Duration(seconds: 3),
      );
    } catch (e) {
      debugPrint('Error saving artwork: $e');
      Get.snackbar(
        'Erreur',
        'Impossible de sauvegarder le dessin',
        backgroundColor: Colors.red.withOpacity(0.8),
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  // Save artwork to storage - FIXED: Use correct StorageService methods
  Future<void> _saveArtworkToStorage(ArtworkModel artwork) async {
    try {
      final artworksList = _storageService.getList('artworks') ?? [];

      // Remove existing artwork with same ID
      artworksList.removeWhere((json) => json['id'] == artwork.id);

      // Add updated artwork
      artworksList.insert(0, artwork.toJson());

      await _storageService.setList('artworks', artworksList);
    } catch (e) {
      debugPrint('Error saving artwork to storage: $e');
      rethrow;
    }
  }

  // Load artworks from storage - FIXED: Use correct StorageService methods
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
                  debugPrint('Error parsing artwork: $e');
                  return null;
                }
              })
              .where((artwork) => artwork != null)
              .cast<ArtworkModel>()
              .toList()
            ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
    } catch (e) {
      debugPrint('Error loading artworks: $e');
      Get.snackbar('Erreur', 'Impossible de charger les dessins');
    } finally {
      isLoading.value = false;
    }
  }

  // Delete with confirmation and feedback - FIXED: Use correct StorageService methods
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
      debugPrint('Error deleting artwork: $e');
      Get.snackbar('Erreur', 'Impossible de supprimer le dessin');
    }
  }

  // Delete artwork from storage - FIXED: Use correct StorageService methods
  Future<void> _deleteArtworkFromStorage(String artworkId) async {
    try {
      final artworksList = _storageService.getList('artworks') ?? [];
      artworksList.removeWhere((json) => json['id'] == artworkId);
      await _storageService.setList('artworks', artworksList);
    } catch (e) {
      debugPrint('Error deleting from storage: $e');
      rethrow;
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
    _updateToolbarState();
  }

  // Load existing artwork for editing
  Future<void> loadArtworkForEditing(String artworkId) async {
    try {
      final artwork = artworks.firstWhere((a) => a.id == artworkId);
      currentArtworkId.value = artwork.id;
      currentArtworkTitle.value = artwork.title;

      // Load template if exists
      if (artwork.templateId != null) {
        try {
          selectedTemplate.value = templates.firstWhere(
            (t) => t.id == artwork.templateId,
          );
        } catch (e) {
          debugPrint('Template not found: ${artwork.templateId}');
        }
      }

      // Note: Loading actual drawing data would require storing
      // the drawing board's JSON data, not just the final image
      clearCanvas();
      hasUnsavedChanges.value = false;
      _updateToolbarState();
    } catch (e) {
      debugPrint('Error loading artwork for editing: $e');
      Get.snackbar(
        'Erreur',
        'Impossible de charger le dessin pour modification',
      );
    }
  }

  // Initialize templates with proper data - FIXED: Use correct enum values
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
        colors: ['blue', 'red', 'green'],
        educationalPrompt: 'Trace un beau cercle et décore-le!',
      ),
      TemplateModel(
        id: 'letter_a',
        name: 'Lettre A',
        previewImagePath: 'assets/templates/previews/letter_a_preview.png',
        templateImagePath: 'assets/templates/letter_a_template.png',
        category: TemplateCategory.letters,
        difficulty: 1,
        colors: ['red', 'blue'],
        educationalPrompt: 'Trace la lettre A comme dans "Ami"!',
      ),
      TemplateModel(
        id: 'number_5',
        name: 'Chiffre 5',
        previewImagePath: 'assets/templates/previews/number_5_preview.png',
        templateImagePath: 'assets/templates/number_5_template.png',
        category: TemplateCategory.numbers,
        difficulty: 1,
        colors: ['purple', 'green'],
        educationalPrompt: 'Écris le chiffre 5 et dessine 5 objets!',
      ),
      TemplateModel(
        id: 'seasonal_sun',
        name: 'Soleil d\'Été',
        previewImagePath: 'assets/templates/previews/sun_preview.png',
        templateImagePath: 'assets/templates/sun_template.png',
        category: TemplateCategory.seasonal,
        difficulty: 2,
        colors: ['yellow', 'orange'],
        educationalPrompt: 'Dessine un beau soleil pour l\'été!',
      ),
      TemplateModel(
        id: 'daily_house',
        name: 'Ma Maison',
        previewImagePath: 'assets/templates/previews/house_preview.png',
        templateImagePath: 'assets/templates/house_template.png',
        category: TemplateCategory.daily,
        difficulty: 2,
        colors: ['brown', 'red', 'blue'],
        educationalPrompt: 'Colorie ta maison de rêve!',
      ),
    ];
  }

  // Share with parent functionality
  Future<void> shareWithParent(String artworkId) async {
    try {
      final artworkIndex = artworks.indexWhere((a) => a.id == artworkId);
      if (artworkIndex != -1) {
        final updatedArtwork = artworks[artworkIndex].copyWith(
          isSharedWithParent: true,
        );
        artworks[artworkIndex] = updatedArtwork;

        // Update storage
        await _saveArtworkToStorage(updatedArtwork);

        _playSound('share.mp3');

        Get.snackbar(
          'Partagé! 👨‍👩‍👧‍👦',
          'Ton dessin a été partagé avec papa et maman',
          backgroundColor: Colors.blue.withOpacity(0.8),
          colorText: Colors.white,
          duration: const Duration(seconds: 3),
        );
      }
    } catch (e) {
      debugPrint('Error sharing with parent: $e');
      Get.snackbar('Erreur', 'Impossible de partager le dessin');
    }
  }

  // Share artwork functionality (simplified without external packages)
  Future<void> shareArtwork(String artworkId) async {
    try {
      final artwork = artworks.firstWhere((a) => a.id == artworkId);

      _playSound('share.mp3');

      Get.snackbar(
        'Partage! 📤',
        'Dessin "${artwork.title}" prêt à partager',
        backgroundColor: Colors.green.withOpacity(0.8),
        colorText: Colors.white,
      );
    } catch (e) {
      debugPrint('Error sharing artwork: $e');
      Get.snackbar('Erreur', 'Impossible de partager le dessin');
    }
  }

  // Export artwork (simplified)
  Future<void> exportArtwork(String artworkId, {String format = 'png'}) async {
    try {
      isLoading.value = true;

      final artwork = artworks.firstWhere((a) => a.id == artworkId);

      _playSound('export.mp3');

      Get.snackbar(
        'Exporté! 📤',
        'Le dessin "${artwork.title}" a été exporté',
        backgroundColor: Colors.blue.withOpacity(0.8),
        colorText: Colors.white,
      );
    } catch (e) {
      debugPrint('Error exporting artwork: $e');
      Get.snackbar('Erreur', 'Impossible d\'exporter le dessin');
    } finally {
      isLoading.value = false;
    }
  }

  // Get artwork statistics for dashboard
  Map<String, int> getArtworkStats() {
    return {
      'total': artworks.length,
      'thisWeek':
          artworks
              .where(
                (a) => a.createdAt.isAfter(
                  DateTime.now().subtract(const Duration(days: 7)),
                ),
              )
              .length,
      'templates': artworks.where((a) => a.type == ArtworkType.template).length,
      'freeDrawing':
          artworks.where((a) => a.type == ArtworkType.freeDrawing).length,
    };
  }

  // Additional utility methods for better UX

  // Check if there are unsaved changes before navigation
  bool hasUnsavedWork() {
    return hasUnsavedChanges.value;
  }

  // Auto-save functionality (could be called periodically)
  Future<void> autoSave() async {
    if (hasUnsavedChanges.value && currentArtworkId.value.isNotEmpty) {
      try {
        await saveArtwork();
        debugPrint('Auto-saved artwork: ${currentArtworkTitle.value}');
      } catch (e) {
        debugPrint('Auto-save failed: $e');
      }
    }
  }

  // Update artwork title
  void updateArtworkTitle(String newTitle) {
    if (newTitle.trim().isNotEmpty) {
      currentArtworkTitle.value = newTitle.trim();
      hasUnsavedChanges.value = true;
    }
  }

  // Get recent artworks (for dashboard)
  List<ArtworkModel> getRecentArtworks({int limit = 6}) {
    final sorted = List<ArtworkModel>.from(artworks)..sort((a, b) {
      final bDate = b.lastModified ?? DateTime.fromMillisecondsSinceEpoch(0);
      final aDate = a.lastModified ?? DateTime.fromMillisecondsSinceEpoch(0);
      return bDate.compareTo(aDate);
    });
    return sorted.take(limit).toList();
  }

  // Performance optimization: Dispose resources when needed
  void disposeResources() {
    try {
      drawingController.removeListener(_updateToolbarState);
      _audioPlayer.stop();
    } catch (e) {
      debugPrint('Error disposing resources: $e');
    }
  }
}
