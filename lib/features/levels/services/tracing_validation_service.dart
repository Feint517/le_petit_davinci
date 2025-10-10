import 'package:flutter/material.dart';
import 'package:le_petit_davinci/features/levels/models/letter_path_data.dart';
import 'package:le_petit_davinci/services/tracing_sound_service.dart';

/// Service for validating letter tracing accuracy
class TracingValidationService {
  static const double defaultTolerance = 25.0;
  static const double minAccuracyThreshold = 0.6;
  static const double completionThreshold = 0.95; // Much higher threshold
  static const double pathCoverageThreshold = 0.85; // Require 85% path coverage
  static const int minStrokeLength = 10; // Minimum points required for a valid stroke

  /// Validates a user's tracing stroke against the expected letter path
  static TracingResult validateStroke(
    List<Offset> userStroke,
    LetterPathData letterPath, {
    double? customTolerance,
  }) {
    if (userStroke.isEmpty) {
      return TracingResult(
        accuracy: 0.0,
        isValid: false,
        feedback: TracingFeedback.emptyStroke,
        correctPoints: [],
        incorrectPoints: [],
      );
    }

    // Require minimum stroke length for meaningful validation
    if (userStroke.length < minStrokeLength) {
      return TracingResult(
        accuracy: 0.0,
        isValid: false,
        feedback: TracingFeedback.veryPoor,
        correctPoints: [],
        incorrectPoints: userStroke,
      );
    }

    final tolerance = customTolerance ?? defaultTolerance;
    final correctPoints = <Offset>[];
    final incorrectPoints = <Offset>[];
    double totalAccuracy = 0.0;

    // Check each point in the user stroke
    for (final point in userStroke) {
      if (letterPath.isPointOnPath(point, customTolerance: tolerance)) {
        correctPoints.add(point);
      } else {
        incorrectPoints.add(point);
      }
    }

    // Calculate accuracy based on stroke quality, not just point count
    totalAccuracy = _calculateStrokeAccuracy(
      userStroke,
      correctPoints,
      letterPath,
    );

    // Determine feedback
    TracingFeedback feedback = _determineFeedback(
      totalAccuracy,
      userStroke,
      letterPath,
    );

    // Check if stroke is valid - require both accuracy and proper coverage
    final isValid = totalAccuracy >= minAccuracyThreshold &&
        _hasGoodPathCoverage(userStroke, letterPath) &&
        letterPath.followsCorrectDirection(userStroke);

    return TracingResult(
      accuracy: totalAccuracy,
      isValid: isValid,
      feedback: feedback,
      correctPoints: correctPoints,
      incorrectPoints: incorrectPoints,
    );
  }

  /// Calculates stroke accuracy based on multiple factors
  static double _calculateStrokeAccuracy(
    List<Offset> userStroke,
    List<Offset> correctPoints,
    LetterPathData letterPath,
  ) {
    if (userStroke.isEmpty) return 0.0;

    // Basic accuracy from correct points
    final basicAccuracy = correctPoints.length / userStroke.length;
    
    // Path coverage factor - how much of the path was covered
    final coverageFactor = _calculatePathCoverage(userStroke, letterPath);
    
    // Stroke length factor - longer strokes get bonus (encourages complete tracing)
    final strokeLengthFactor = _calculateStrokeLengthFactor(userStroke, letterPath);
    
    // Combine factors with weights
    final accuracy = (basicAccuracy * 0.4) + (coverageFactor * 0.4) + (strokeLengthFactor * 0.2);
    
    return accuracy.clamp(0.0, 1.0);
  }

  /// Calculates how much of the letter path was covered by the stroke
  static double _calculatePathCoverage(List<Offset> userStroke, LetterPathData letterPath) {
    if (userStroke.isEmpty || letterPath.keyPoints.isEmpty) return 0.0;

    int coveredKeyPoints = 0;
    for (final keyPoint in letterPath.keyPoints) {
      bool isCovered = userStroke.any((userPoint) =>
          (userPoint - keyPoint).distance <= defaultTolerance * 1.5);
      if (isCovered) {
        coveredKeyPoints++;
      }
    }

    return coveredKeyPoints / letterPath.keyPoints.length;
  }

  /// Calculates stroke length factor to encourage complete tracing
  static double _calculateStrokeLengthFactor(List<Offset> userStroke, LetterPathData letterPath) {
    if (userStroke.length < 2) return 0.0;

    // Calculate total stroke length
    double strokeLength = 0.0;
    for (int i = 0; i < userStroke.length - 1; i++) {
      strokeLength += (userStroke[i + 1] - userStroke[i]).distance;
    }

    // Estimate expected path length (rough approximation)
    double expectedLength = 0.0;
    for (int i = 0; i < letterPath.keyPoints.length - 1; i++) {
      expectedLength += (letterPath.keyPoints[i + 1] - letterPath.keyPoints[i]).distance;
    }

    if (expectedLength == 0) return 0.0;

    // Return factor based on how close stroke length is to expected length
    final lengthRatio = strokeLength / expectedLength;
    return lengthRatio.clamp(0.0, 1.0);
  }

  /// Checks if the stroke has good path coverage
  static bool _hasGoodPathCoverage(List<Offset> userStroke, LetterPathData letterPath) {
    final coverage = _calculatePathCoverage(userStroke, letterPath);
    return coverage >= pathCoverageThreshold; // Require 85% path coverage
  }

  /// Determines appropriate feedback based on tracing performance
  static TracingFeedback _determineFeedback(
    double accuracy,
    List<Offset> userStroke,
    LetterPathData letterPath,
  ) {
    if (accuracy >= completionThreshold) {
      return TracingFeedback.excellent;
    } else if (accuracy >= 0.85) {
      return TracingFeedback.good;
    } else if (accuracy >= 0.7) {
      return TracingFeedback.needsImprovement;
    } else if (accuracy >= 0.5) {
      return TracingFeedback.poor;
    } else {
      return TracingFeedback.veryPoor;
    }
  }

  /// Validates the complete tracing session
  static CompleteTracingResult validateCompleteTracing(
    List<List<Offset>> allStrokes,
    LetterPathData letterPath,
  ) {
    if (allStrokes.isEmpty) {
      return CompleteTracingResult(
        overallAccuracy: 0.0,
        isComplete: false,
        feedback: TracingFeedback.emptyStroke,
        strokeResults: [],
      );
    }

    final strokeResults = <TracingResult>[];
    double totalAccuracy = 0.0;

    // Validate each stroke
    for (final stroke in allStrokes) {
      final result = validateStroke(stroke, letterPath);
      strokeResults.add(result);
      totalAccuracy += result.accuracy;
    }

    // Calculate overall accuracy
    totalAccuracy /= allStrokes.length;

    // Check if tracing is complete - much stricter requirements
    final isComplete = _isTracingComplete(allStrokes, letterPath, totalAccuracy);

    // Determine overall feedback
    final feedback = _determineFeedback(totalAccuracy, [], letterPath);

    return CompleteTracingResult(
      overallAccuracy: totalAccuracy,
      isComplete: isComplete,
      feedback: feedback,
      strokeResults: strokeResults,
    );
  }

  /// Checks if tracing is truly complete with strict requirements
  static bool _isTracingComplete(
    List<List<Offset>> allStrokes,
    LetterPathData letterPath,
    double totalAccuracy,
  ) {
    // Must have high overall accuracy
    if (totalAccuracy < completionThreshold) return false;
    
    // Must have covered all key points
    if (!_hasCoveredAllKeyPoints(allStrokes, letterPath)) return false;
    
    // Must have good path coverage across all strokes
    final allUserPoints = <Offset>[];
    for (final stroke in allStrokes) {
      allUserPoints.addAll(stroke);
    }
    
    final coverage = _calculatePathCoverage(allUserPoints, letterPath);
    if (coverage < pathCoverageThreshold) return false;
    
    // Must have traced a significant portion of the path length
    final strokeLengthFactor = _calculateStrokeLengthFactor(allUserPoints, letterPath);
    if (strokeLengthFactor < 0.7) return false; // Require 70% of expected path length
    
    return true;
  }

  /// Checks if all key points of the letter have been covered
  static bool _hasCoveredAllKeyPoints(
    List<List<Offset>> allStrokes,
    LetterPathData letterPath,
  ) {
    final allUserPoints = <Offset>[];
    for (final stroke in allStrokes) {
      allUserPoints.addAll(stroke);
    }

    int coveredKeyPoints = 0;
    for (final keyPoint in letterPath.keyPoints) {
      bool isCovered = allUserPoints.any((userPoint) =>
          (userPoint - keyPoint).distance <= defaultTolerance);
      if (isCovered) {
        coveredKeyPoints++;
      }
    }

    // Require at least 90% of key points to be covered
    return coveredKeyPoints >= (letterPath.keyPoints.length * 0.9);
  }

  /// Provides real-time feedback during tracing
  static RealTimeFeedback getRealTimeFeedback(
    Offset currentPoint,
    LetterPathData letterPath,
    List<Offset> currentStroke,
  ) {
    // Only provide feedback for longer strokes to avoid spam
    if (currentStroke.length < 5) {
      return RealTimeFeedback(
        type: FeedbackType.correct,
        message: 'Start tracing...',
        color: Colors.blue,
      );
    }

    final isOnPath = letterPath.isPointOnPath(currentPoint);
    final distance = letterPath.getClosestPointOnPath(currentPoint);
    
    if (isOnPath) {
      // Play correct sound occasionally to avoid spam
      if (currentStroke.length % 20 == 0) {
        TracingSoundService.playCorrectSound();
      }
      
      return RealTimeFeedback(
        type: FeedbackType.correct,
        message: 'Great! Keep going!',
        color: Colors.green,
      );
    } else if (distance != null && (distance - currentPoint).distance < defaultTolerance * 1.5) {
      return RealTimeFeedback(
        type: FeedbackType.warning,
        message: 'Getting close!',
        color: Colors.orange,
      );
    } else {
      // Play incorrect sound occasionally to avoid spam
      if (currentStroke.length % 25 == 0) {
        TracingSoundService.playIncorrectSound();
      }
      
      return RealTimeFeedback(
        type: FeedbackType.incorrect,
        message: 'Try to stay on the line',
        color: Colors.red,
      );
    }
  }
}

/// Result of tracing validation
class TracingResult {
  final double accuracy;
  final bool isValid;
  final TracingFeedback feedback;
  final List<Offset> correctPoints;
  final List<Offset> incorrectPoints;

  TracingResult({
    required this.accuracy,
    required this.isValid,
    required this.feedback,
    required this.correctPoints,
    required this.incorrectPoints,
  });
}

/// Result of complete tracing validation
class CompleteTracingResult {
  final double overallAccuracy;
  final bool isComplete;
  final TracingFeedback feedback;
  final List<TracingResult> strokeResults;

  CompleteTracingResult({
    required this.overallAccuracy,
    required this.isComplete,
    required this.feedback,
    required this.strokeResults,
  });
}

/// Real-time feedback during tracing
class RealTimeFeedback {
  final FeedbackType type;
  final String message;
  final Color color;

  RealTimeFeedback({
    required this.type,
    required this.message,
    required this.color,
  });
}

/// Types of feedback
enum FeedbackType {
  correct,
  warning,
  incorrect,
}

/// Types of tracing feedback
enum TracingFeedback {
  excellent,
  good,
  needsImprovement,
  poor,
  veryPoor,
  emptyStroke,
}

/// Extension for feedback messages
extension TracingFeedbackExtension on TracingFeedback {
  String get message {
    switch (this) {
      case TracingFeedback.excellent:
        return 'Excellent! Perfect tracing!';
      case TracingFeedback.good:
        return 'Good job! Almost perfect!';
      case TracingFeedback.needsImprovement:
        return 'Good try! Try to stay closer to the line.';
      case TracingFeedback.poor:
        return 'Keep practicing! Focus on the dotted line.';
      case TracingFeedback.veryPoor:
        return 'Let\'s try again! Follow the dotted line carefully.';
      case TracingFeedback.emptyStroke:
        return 'Start tracing the letter!';
    }
  }

  Color get color {
    switch (this) {
      case TracingFeedback.excellent:
        return Colors.green;
      case TracingFeedback.good:
        return Colors.lightGreen;
      case TracingFeedback.needsImprovement:
        return Colors.orange;
      case TracingFeedback.poor:
        return Colors.deepOrange;
      case TracingFeedback.veryPoor:
        return Colors.red;
      case TracingFeedback.emptyStroke:
        return Colors.grey;
    }
  }
}
