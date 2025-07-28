import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_drawing_board/flutter_drawing_board.dart';
import 'package:flutter_drawing_board/paint_contents.dart';
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
  final Rx<MaterialColor> selectedColor = Colors.blue.obs;
  final RxDouble brushSize = 5.0.obs;
  final Rx<Type> selectedTool = (SimpleLine).obs;
  final RxBool isDrawing = false.obs;
  final RxBool hasUnsavedChanges = false.obs;

  // Lesson mode tracking
  final RxBool isLessonMode = false.obs;
  final RxString lessonId = ''.obs;

  // Toolbar state management
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
  final List<MaterialColor> availableColors = [
    Colors.red,
    Colors.blue,
    Colors.green,
    Colors.yellow,
    Colors.orange,
    Colors.purple,
    Colors.pink,
    Colors.brown,
    Colors.grey,
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
    drawingController.setPaintContent(SimpleLine());
    drawingController.setStyle(
      color: selectedColor.value,
      strokeWidth: brushSize.value,
    );
    drawingController.addListener(_updateToolbarState);
  }

  // Setup listeners for drawing state changes
  void _setupDrawingListeners() {
    drawingController.addListener(() {
      hasUnsavedChanges.value = true;
    });
    _updateToolbarState();
  }

  // Initialize controller for lesson mode
  void initializeForLesson(TemplateModel template) {
    isLessonMode.value = true;
    selectedTemplate.value = template;
    currentArtworkTitle.value = template.name;

    // Clear previous drawing
    clearCanvas();

    // Set up drawing for this lesson
    hasUnsavedChanges.value = false;
    _updateToolbarState();
  }

  // Save artwork specifically for lesson completion
  Future<String?> saveArtworkForLesson({
    required String lessonId,
    required String activityName,
  }) async {
    try {
      isLoading.value = true;

      // Get image data from drawing board
      final imageData = await drawingController.getImageData();
      if (imageData == null) {
        throw Exception('Failed to get image data from drawing board');
      }

      // Generate unique filename with lesson context
      final timestamp = DateTime.now().millisecondsSinceEpoch;
      final filename = 'lesson_${lessonId}_${timestamp}.png';

      // Virtual path (in production you would save the actual file)
      final imagePath = 'artworks/lessons/$filename';

      // Create artwork model with lesson metadata
      final artwork = ArtworkModel(
        id: 'lesson_artwork_$timestamp',
        title: '$activityName - ${_formatDate(DateTime.now())}',
        createdAt: DateTime.now(),
        lastModified: DateTime.now(),
        imagePath: imagePath,
        isSharedWithParent: false,
        templateId: selectedTemplate.value?.id,
        type: ArtworkType.educational,
        metadata: {
          'lessonId': lessonId,
          'activityName': activityName,
          'isLessonArtwork': true,
        },
      );

      // Save to local storage
      artworks.add(artwork);
      await _saveArtworkToStorage(artwork);

      // Play success sound
      _playSound('success.mp3');

      hasUnsavedChanges.value = false;
      currentArtworkId.value = artwork.id;

      return artwork.id;
    } catch (e) {
      debugPrint('Error saving lesson artwork: $e');
      Get.snackbar(
        'Erreur',
        'Impossible de sauvegarder le dessin',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return null;
    } finally {
      isLoading.value = false;
    }
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

  // Proper undo method with observable updates
  void undo() {
    try {
      drawingController.undo();
      _updateToolbarState();
      _playSound('undo.mp3');
    } catch (e) {
      debugPrint('Error during undo: $e');
      Get.snackbar('Erreur', 'Impossible d\'annuler l\'action');
    }
  }

  // Proper redo method with observable updates
  void redo() {
    try {
      drawingController.redo();
      _updateToolbarState();
      _playSound('redo.mp3');
    } catch (e) {
      debugPrint('Error during redo: $e');
      Get.snackbar('Erreur', 'Impossible de refaire l\'action');
    }
  }

  // Tool selection method
  void selectTool(PaintContent content) {
    drawingController.setPaintContent(content);
    selectedTool.value = content.runtimeType;
    _playSound('select.mp3');
  }

  // Color selection method
  void setColor(MaterialColor color) {
    selectedColor.value = color;
    drawingController.setStyle(color: color);
    _playSound('select.mp3');
  }

  // Brush size setter
  void setBrushSize(double size) {
    if (size >= 1.0 && size <= 50.0) {
      brushSize.value = size;
      drawingController.setStyle(strokeWidth: size);
      _playSound('select.mp3');
    }
  }

  // Template selection method
  void selectTemplate(TemplateModel template) {
    selectedTemplate.value = template;
    _playSound('select.mp3');
  }

  // Clear canvas method with proper error handling
  void clearCanvas() {
    try {
      drawingController.clear();
      _updateToolbarState();
      _playSound('clear.mp3');
    } catch (e) {
      debugPrint('Error clearing canvas: $e');
      Get.snackbar('Erreur', 'Impossible d\'effacer le dessin');
    }
  }

  // Safe audio playback with fallback to haptic feedback
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

  // Enhanced save functionality
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
      );

      // Save to local storage
      if (currentArtworkId.value.isEmpty) {
        artworks.add(artwork);
      } else {
        // Update existing artwork
        final index = artworks.indexWhere((a) => a.id == artwork.id);
        if (index != -1) {
          artworks[index] = artwork;
        }
      }

      await _saveArtworkToStorage(artwork);

      // Update state
      hasUnsavedChanges.value = false;
      currentArtworkId.value = artwork.id;

      // Success feedback
      _playSound('save.mp3');
    } catch (e) {
      debugPrint('Error saving artwork: $e');
      Get.snackbar(
        'Erreur',
        'Impossible de sauvegarder le dessin',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  // Save artwork list to storage
  Future<void> _saveArtworkToStorage(ArtworkModel artwork) async {
    try {
      final artworksList = artworks.map((artwork) => artwork.toJson()).toList();
      await _storageService.setList('artworks', artworksList);
    } catch (e) {
      debugPrint('Error saving to storage: $e');
      rethrow;
    }
  }

  // Load saved artworks
  Future<void> loadArtworks() async {
    try {
      final artworksList = _storageService.getList('artworks') ?? [];
      artworks.value =
          artworksList
              .map((json) => ArtworkModel.fromJson(json))
              .toList()
              .reversed
              .toList();
    } catch (e) {
      debugPrint('Error loading artworks: $e');
      artworks.clear();
    }
  }

  // Delete artwork
  Future<void> deleteArtwork(String artworkId) async {
    try {
      artworks.removeWhere((artwork) => artwork.id == artworkId);

      // Update storage
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
    isLessonMode.value = false;

    // Reset to default drawing settings
    drawingController.setPaintContent(SimpleLine());
    drawingController.setStyle(color: Colors.blue, strokeWidth: 5.0);

    // Update local observables to match
    selectedTool.value = SimpleLine;
    selectedColor.value = Colors.blue;
    brushSize.value = 5.0;

    hasUnsavedChanges.value = false;
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
      // the drawing board's JSON data, not just the final image.
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
        colors: ['blue', 'red', 'green'],
        educationalPrompt: 'Trace un beau cercle et décore-le!',
      ),
      // ... add more templates as needed
    ];
  }

  // Share with parent functionality
  Future<void> shareWithParent(String artworkId) async {
    try {
      final artwork = artworks.firstWhere((a) => a.id == artworkId);
      final updatedArtwork = artwork.copyWith(isSharedWithParent: true);

      // Update in list
      final index = artworks.indexWhere((a) => a.id == artworkId);
      if (index != -1) {
        artworks[index] = updatedArtwork;
      }

      // Save to storage
      await _saveArtworkToStorage(updatedArtwork);

      Get.snackbar(
        'Partagé!',
        'Ton dessin a été partagé avec tes parents',
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    } catch (e) {
      debugPrint('Error sharing with parent: $e');
    }
  }

  // Share artwork functionality (simplified without external packages)
  Future<void> shareArtwork(String artworkId) async {
    try {
      // In a real app, this would use share_plus or similar
      Get.snackbar(
        'Partage',
        'Fonction de partage disponible prochainement!',
        backgroundColor: Colors.blue,
        colorText: Colors.white,
      );
    } catch (e) {
      debugPrint('Error sharing artwork: $e');
    }
  }

  // Export artwork (simplified)
  Future<void> exportArtwork(String artworkId, {String format = 'png'}) async {
    try {
      // In a real app, this would export to device storage
      Get.snackbar(
        'Export',
        'Ton dessin sera exporté en format $format',
        backgroundColor: Colors.blue,
        colorText: Colors.white,
      );
    } catch (e) {
      debugPrint('Error exporting artwork: $e');
    }
  }

  // Get artwork statistics for dashboard
  Map<String, int> getArtworkStats() {
    final now = DateTime.now();
    final startOfWeek = now.subtract(Duration(days: now.weekday - 1));

    return {
      'total': artworks.length,
      'thisWeek':
          artworks.where((a) => a.createdAt.isAfter(startOfWeek)).length,
      'templates': artworks.where((a) => a.type == ArtworkType.template).length,
      'freeDrawing':
          artworks.where((a) => a.type == ArtworkType.freeDrawing).length,
      'educational':
          artworks.where((a) => a.type == ArtworkType.educational).length,
    };
  }

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

  // Get lesson artworks
  List<ArtworkModel> getLessonArtworks() {
    return artworks
        .where((artwork) => artwork.type == ArtworkType.educational)
        .toList();
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

  // Format date helper
  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}
