import 'dart:math' as math;
import 'dart:ui';
import 'package:flutter/material.dart';

/// Represents a letter path with validation data
class LetterPathData {
  final String letter;
  final Path path;
  final List<PathSegment> segments;
  final List<Offset> keyPoints;
  final double tolerance;

  LetterPathData({
    required this.letter,
    required this.path,
    required this.segments,
    required this.keyPoints,
    this.tolerance = 20.0,
  });

  /// Get path metrics for validation
  Iterable<PathMetric> get pathMetrics => path.computeMetrics();

  /// Check if a point is within tolerance of the path
  bool isPointOnPath(Offset point, {double? customTolerance}) {
    final tolerance = customTolerance ?? this.tolerance;
    return pathMetrics.any((metric) {
      for (double d = 0; d < metric.length; d += 2) {
        final tangent = metric.getTangentForOffset(d);
        if (tangent != null) {
          final distance = (tangent.position - point).distance;
          if (distance <= tolerance) {
            return true;
          }
        }
      }
      return false;
    });
  }

  /// Get the closest point on the path to a given point
  Offset? getClosestPointOnPath(Offset point) {
    double minDistance = double.infinity;
    Offset? closestPoint;

    for (final metric in pathMetrics) {
      for (double d = 0; d < metric.length; d += 2) {
        final tangent = metric.getTangentForOffset(d);
        if (tangent != null) {
          final distance = (tangent.position - point).distance;
          if (distance < minDistance) {
            minDistance = distance;
            closestPoint = tangent.position;
          }
        }
      }
    }

    return closestPoint;
  }

  /// Calculate accuracy of user stroke against expected path
  double calculateAccuracy(List<Offset> userStroke) {
    if (userStroke.isEmpty) return 0.0;

    int correctPoints = 0;
    for (final point in userStroke) {
      if (isPointOnPath(point)) {
        correctPoints++;
      }
    }

    return correctPoints / userStroke.length;
  }

  /// Check if user stroke follows correct direction
  bool followsCorrectDirection(List<Offset> userStroke) {
    if (userStroke.length < 2) return false;

    // Check if user stroke generally follows the path direction
    for (int i = 0; i < userStroke.length - 1; i++) {
      final userDirection = userStroke[i + 1] - userStroke[i];
      final closestPoint = getClosestPointOnPath(userStroke[i]);

      if (closestPoint != null) {
        // Find next point on path
        final nextPathPoint = _getNextPointOnPath(closestPoint);
        if (nextPathPoint != null) {
          final pathDirection = nextPathPoint - closestPoint;
          final dotProduct =
              userDirection.dx * pathDirection.dx +
              userDirection.dy * pathDirection.dy;
          if (dotProduct < 0) {
            return false; // Wrong direction
          }
        }
      }
    }

    return true;
  }

  Offset? _getNextPointOnPath(Offset point) {
    for (final metric in pathMetrics) {
      for (double d = 0; d < metric.length - 2; d += 2) {
        final tangent = metric.getTangentForOffset(d);
        if (tangent != null &&
            (tangent.position - point).distance < tolerance) {
          final nextTangent = metric.getTangentForOffset(d + 2);
          return nextTangent?.position;
        }
      }
    }
    return null;
  }
}

/// Represents a segment of a letter path
class PathSegment {
  final Offset start;
  final Offset end;
  final PathSegmentType type;
  final double strokeWidth;

  PathSegment({
    required this.start,
    required this.end,
    required this.type,
    this.strokeWidth = 8.0,
  });
}

enum PathSegmentType { line, curve, arc }

/// Factory class for creating letter path data
class LetterPathFactory {
  static LetterPathData createLetterPath(String letter, Size canvasSize) {
    final upperLetter = letter.toUpperCase();
    final center = Offset(canvasSize.width / 2, canvasSize.height / 2);
    final scale = math.min(canvasSize.width, canvasSize.height) * 0.6;

    switch (upperLetter) {
      case 'A':
        return _createLetterA(center, scale);
      case 'B':
        return _createLetterB(center, scale);
      case 'C':
        return _createLetterC(center, scale);
      case 'D':
        return _createLetterD(center, scale);
      case 'E':
        return _createLetterE(center, scale);
      case 'F':
        return _createLetterF(center, scale);
      case 'G':
        return _createLetterG(center, scale);
      case 'H':
        return _createLetterH(center, scale);
      case 'I':
        return _createLetterI(center, scale);
      case 'J':
        return _createLetterJ(center, scale);
      case 'K':
        return _createLetterK(center, scale);
      case 'L':
        return _createLetterL(center, scale);
      case 'M':
        return _createLetterM(center, scale);
      case 'N':
        return _createLetterN(center, scale);
      case 'O':
        return _createLetterO(center, scale);
      case 'P':
        return _createLetterP(center, scale);
      case 'Q':
        return _createLetterQ(center, scale);
      case 'R':
        return _createLetterR(center, scale);
      case 'S':
        return _createLetterS(center, scale);
      case 'T':
        return _createLetterT(center, scale);
      case 'U':
        return _createLetterU(center, scale);
      case 'V':
        return _createLetterV(center, scale);
      case 'W':
        return _createLetterW(center, scale);
      case 'X':
        return _createLetterX(center, scale);
      case 'Y':
        return _createLetterY(center, scale);
      case 'Z':
        return _createLetterZ(center, scale);
      default:
        return _createLetterA(center, scale);
    }
  }

  static LetterPathData _createLetterA(Offset center, double scale) {
    final path = Path();
    final keyPoints = <Offset>[];
    final segments = <PathSegment>[];

    // Left diagonal
    final leftStart = Offset(center.dx - scale * 0.3, center.dy + scale * 0.3);
    final topPoint = Offset(center.dx, center.dy - scale * 0.3);
    final rightEnd = Offset(center.dx + scale * 0.3, center.dy + scale * 0.3);

    path.moveTo(leftStart.dx, leftStart.dy);
    path.lineTo(topPoint.dx, topPoint.dy);
    path.lineTo(rightEnd.dx, rightEnd.dy);

    // Crossbar
    final crossbarLeft = Offset(center.dx - scale * 0.2, center.dy);
    final crossbarRight = Offset(center.dx + scale * 0.2, center.dy);
    path.moveTo(crossbarLeft.dx, crossbarLeft.dy);
    path.lineTo(crossbarRight.dx, crossbarRight.dy);

    keyPoints.addAll([
      leftStart,
      topPoint,
      rightEnd,
      crossbarLeft,
      crossbarRight,
    ]);

    segments.addAll([
      PathSegment(start: leftStart, end: topPoint, type: PathSegmentType.line),
      PathSegment(start: topPoint, end: rightEnd, type: PathSegmentType.line),
      PathSegment(
        start: crossbarLeft,
        end: crossbarRight,
        type: PathSegmentType.line,
      ),
    ]);

    return LetterPathData(
      letter: 'A',
      path: path,
      segments: segments,
      keyPoints: keyPoints,
    );
  }

  static LetterPathData _createLetterB(Offset center, double scale) {
    final path = Path();
    final keyPoints = <Offset>[];
    final segments = <PathSegment>[];

    // Vertical line
    final topLeft = Offset(center.dx - scale * 0.3, center.dy - scale * 0.3);
    final bottomLeft = Offset(center.dx - scale * 0.3, center.dy + scale * 0.3);

    path.moveTo(topLeft.dx, topLeft.dy);
    path.lineTo(bottomLeft.dx, bottomLeft.dy);

    // Top curve
    path.moveTo(topLeft.dx, topLeft.dy);
    path.quadraticBezierTo(
      center.dx + scale * 0.2,
      center.dy - scale * 0.3,
      center.dx + scale * 0.2,
      center.dy,
    );

    // Bottom curve
    path.moveTo(center.dx - scale * 0.3, center.dy);
    path.quadraticBezierTo(
      center.dx + scale * 0.2,
      center.dy,
      center.dx + scale * 0.2,
      center.dy + scale * 0.3,
    );

    keyPoints.addAll([topLeft, bottomLeft, center]);

    segments.addAll([
      PathSegment(start: topLeft, end: bottomLeft, type: PathSegmentType.line),
      PathSegment(start: topLeft, end: center, type: PathSegmentType.curve),
      PathSegment(start: center, end: bottomLeft, type: PathSegmentType.curve),
    ]);

    return LetterPathData(
      letter: 'B',
      path: path,
      segments: segments,
      keyPoints: keyPoints,
    );
  }

  static LetterPathData _createLetterC(Offset center, double scale) {
    final path = Path();
    final keyPoints = <Offset>[];
    final segments = <PathSegment>[];

    // C shape
    final rightTop = Offset(center.dx + scale * 0.2, center.dy - scale * 0.2);
    final leftTop = Offset(center.dx - scale * 0.2, center.dy - scale * 0.2);
    final leftBottom = Offset(center.dx - scale * 0.2, center.dy + scale * 0.2);
    final rightBottom = Offset(
      center.dx + scale * 0.2,
      center.dy + scale * 0.2,
    );

    path.moveTo(rightTop.dx, rightTop.dy);
    path.quadraticBezierTo(
      center.dx - scale * 0.3,
      center.dy - scale * 0.2,
      leftTop.dx,
      leftTop.dy,
    );
    path.quadraticBezierTo(
      center.dx - scale * 0.3,
      center.dy,
      leftBottom.dx,
      leftBottom.dy,
    );
    path.quadraticBezierTo(
      center.dx - scale * 0.3,
      center.dy + scale * 0.2,
      rightBottom.dx,
      rightBottom.dy,
    );

    keyPoints.addAll([rightTop, leftTop, leftBottom, rightBottom]);

    segments.addAll([
      PathSegment(start: rightTop, end: leftTop, type: PathSegmentType.curve),
      PathSegment(start: leftTop, end: leftBottom, type: PathSegmentType.curve),
      PathSegment(
        start: leftBottom,
        end: rightBottom,
        type: PathSegmentType.curve,
      ),
    ]);

    return LetterPathData(
      letter: 'C',
      path: path,
      segments: segments,
      keyPoints: keyPoints,
    );
  }

  // Add more letter creation methods...
  static LetterPathData _createLetterD(Offset center, double scale) {
    return _createLetterA(center, scale); // Placeholder
  }

  static LetterPathData _createLetterE(Offset center, double scale) {
    return _createLetterA(center, scale); // Placeholder
  }

  static LetterPathData _createLetterF(Offset center, double scale) {
    return _createLetterA(center, scale); // Placeholder
  }

  static LetterPathData _createLetterG(Offset center, double scale) {
    return _createLetterA(center, scale); // Placeholder
  }

  static LetterPathData _createLetterH(Offset center, double scale) {
    return _createLetterA(center, scale); // Placeholder
  }

  static LetterPathData _createLetterI(Offset center, double scale) {
    return _createLetterA(center, scale); // Placeholder
  }

  static LetterPathData _createLetterJ(Offset center, double scale) {
    return _createLetterA(center, scale); // Placeholder
  }

  static LetterPathData _createLetterK(Offset center, double scale) {
    return _createLetterA(center, scale); // Placeholder
  }

  static LetterPathData _createLetterL(Offset center, double scale) {
    return _createLetterA(center, scale); // Placeholder
  }

  static LetterPathData _createLetterM(Offset center, double scale) {
    return _createLetterA(center, scale); // Placeholder
  }

  static LetterPathData _createLetterN(Offset center, double scale) {
    return _createLetterA(center, scale); // Placeholder
  }

  static LetterPathData _createLetterO(Offset center, double scale) {
    return _createLetterA(center, scale); // Placeholder
  }

  static LetterPathData _createLetterP(Offset center, double scale) {
    return _createLetterA(center, scale); // Placeholder
  }

  static LetterPathData _createLetterQ(Offset center, double scale) {
    return _createLetterA(center, scale); // Placeholder
  }

  static LetterPathData _createLetterR(Offset center, double scale) {
    return _createLetterA(center, scale); // Placeholder
  }

  static LetterPathData _createLetterS(Offset center, double scale) {
    return _createLetterA(center, scale); // Placeholder
  }

  static LetterPathData _createLetterT(Offset center, double scale) {
    return _createLetterA(center, scale); // Placeholder
  }

  static LetterPathData _createLetterU(Offset center, double scale) {
    return _createLetterA(center, scale); // Placeholder
  }

  static LetterPathData _createLetterV(Offset center, double scale) {
    return _createLetterA(center, scale); // Placeholder
  }

  static LetterPathData _createLetterW(Offset center, double scale) {
    return _createLetterA(center, scale); // Placeholder
  }

  static LetterPathData _createLetterX(Offset center, double scale) {
    return _createLetterA(center, scale); // Placeholder
  }

  static LetterPathData _createLetterY(Offset center, double scale) {
    return _createLetterA(center, scale); // Placeholder
  }

  static LetterPathData _createLetterZ(Offset center, double scale) {
    return _createLetterA(center, scale); // Placeholder
  }
}
