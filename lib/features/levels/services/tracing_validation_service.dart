import 'package:flutter/material.dart';
import 'package:le_petit_davinci/features/levels/models/letter_path_data.dart';
import 'package:le_petit_davinci/services/tracing_sound_service.dart';

/// Service for validating letter tracing accuracy
class TracingValidationService {
  static const double defaultTolerance = 25.0;
  static const double minAccuracyThreshold = 0.7;
  static const double completionThreshold = 0.85;

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

    // Calculate accuracy
    totalAccuracy = correctPoints.length / userStroke.length;

    // Determine feedback
    TracingFeedback feedback = _determineFeedback(
      totalAccuracy,
      userStroke,
      letterPath,
    );

    // Check if stroke is valid
    final isValid = totalAccuracy >= minAccuracyThreshold &&
        letterPath.followsCorrectDirection(userStroke);

    return TracingResult(
      accuracy: totalAccuracy,
      isValid: isValid,
      feedback: feedback,
      correctPoints: correctPoints,
      incorrectPoints: incorrectPoints,
    );
  }

  /// Determines appropriate feedback based on tracing performance
  static TracingFeedback _determineFeedback(
    double accuracy,
    List<Offset> userStroke,
    LetterPathData letterPath,
  ) {
    if (accuracy >= completionThreshold) {
      return TracingFeedback.excellent;
    } else if (accuracy >= 0.8) {
      return TracingFeedback.good;
    } else if (accuracy >= 0.6) {
      return TracingFeedback.needsImprovement;
    } else if (accuracy >= 0.4) {
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

    // Check if tracing is complete
    final isComplete = totalAccuracy >= completionThreshold &&
        _hasCoveredAllKeyPoints(allStrokes, letterPath);

    // Determine overall feedback
    final feedback = _determineFeedback(totalAccuracy, [], letterPath);

    return CompleteTracingResult(
      overallAccuracy: totalAccuracy,
      isComplete: isComplete,
      feedback: feedback,
      strokeResults: strokeResults,
    );
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

    // Require at least 80% of key points to be covered
    return coveredKeyPoints >= (letterPath.keyPoints.length * 0.8);
  }

  /// Provides real-time feedback during tracing
  static RealTimeFeedback getRealTimeFeedback(
    Offset currentPoint,
    LetterPathData letterPath,
    List<Offset> currentStroke,
  ) {
    final isOnPath = letterPath.isPointOnPath(currentPoint);
    final distance = letterPath.getClosestPointOnPath(currentPoint);
    
    if (isOnPath) {
      // Play correct sound occasionally to avoid spam
      if (currentStroke.length % 10 == 0) {
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
      if (currentStroke.length % 15 == 0) {
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
