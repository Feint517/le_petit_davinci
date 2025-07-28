import 'package:flutter/material.dart';

class ArtworkModel {
  final String id;
  final String title;
  final DateTime createdAt;
  final DateTime? lastModified;
  final String imagePath;
  final bool isSharedWithParent;
  final List<ParentFeedback> feedback;
  final String? templateId;
  final ArtworkType type;
  final Map<String, dynamic> metadata;

  ArtworkModel({
    required this.id,
    required this.title,
    required this.createdAt,
    this.lastModified,
    required this.imagePath,
    this.isSharedWithParent = false,
    this.feedback = const [],
    this.templateId,
    this.type = ArtworkType.freeDrawing,
    this.metadata = const {},
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'createdAt': createdAt.toIso8601String(),
      'lastModified': lastModified?.toIso8601String(),
      'imagePath': imagePath,
      'isSharedWithParent': isSharedWithParent,
      'feedback': feedback.map((f) => f.toJson()).toList(),
      'templateId': templateId,
      'type': type.toString(),
      'metadata': metadata,
    };
  }

  factory ArtworkModel.fromJson(Map<String, dynamic> json) {
    return ArtworkModel(
      id: json['id'],
      title: json['title'],
      createdAt: DateTime.parse(json['createdAt']),
      lastModified:
          json['lastModified'] != null
              ? DateTime.parse(json['lastModified'])
              : null,
      imagePath: json['imagePath'],
      isSharedWithParent: json['isSharedWithParent'] ?? false,
      feedback:
          (json['feedback'] as List?)
              ?.map((f) => ParentFeedback.fromJson(f))
              .toList() ??
          [],
      templateId: json['templateId'],
      type: ArtworkType.values.firstWhere(
        (e) => e.toString() == json['type'],
        orElse: () => ArtworkType.freeDrawing,
      ),
      metadata: Map<String, dynamic>.from(json['metadata'] ?? {}),
    );
  }

  ArtworkModel copyWith({
    String? id,
    String? title,
    DateTime? createdAt,
    DateTime? lastModified,
    String? imagePath,
    bool? isSharedWithParent,
    List<ParentFeedback>? feedback,
    String? templateId,
    ArtworkType? type,
    Map<String, dynamic>? metadata,
  }) {
    return ArtworkModel(
      id: id ?? this.id,
      title: title ?? this.title,
      createdAt: createdAt ?? this.createdAt,
      lastModified: lastModified ?? this.lastModified,
      imagePath: imagePath ?? this.imagePath,
      isSharedWithParent: isSharedWithParent ?? this.isSharedWithParent,
      feedback: feedback ?? this.feedback,
      templateId: templateId ?? this.templateId,
      type: type ?? this.type,
      metadata: metadata ?? this.metadata,
    );
  }
}

class ParentFeedback {
  final String id;
  final String parentId;
  final String message;
  final int stars;
  final DateTime timestamp;
  final String? voiceMessagePath;

  ParentFeedback({
    required this.id,
    required this.parentId,
    required this.message,
    required this.stars,
    required this.timestamp,
    this.voiceMessagePath,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'parentId': parentId,
      'message': message,
      'stars': stars,
      'timestamp': timestamp.toIso8601String(),
      'voiceMessagePath': voiceMessagePath,
    };
  }

  factory ParentFeedback.fromJson(Map<String, dynamic> json) {
    return ParentFeedback(
      id: json['id'],
      parentId: json['parentId'],
      message: json['message'],
      stars: json['stars'],
      timestamp: DateTime.parse(json['timestamp']),
      voiceMessagePath: json['voiceMessagePath'],
    );
  }
}

enum ArtworkType { freeDrawing, template, educational, collaborative }

class DrawingPath {
  final List<Offset> points;
  final Color color;
  final double strokeWidth;
  final DrawingTool tool;

  DrawingPath({
    required this.points,
    required this.color,
    required this.strokeWidth,
    this.tool = DrawingTool.brush,
  });

  Map<String, dynamic> toJson() {
    return {
      'points': points.map((p) => [p.dx, p.dy]).toList(),
      'color': color.value,
      'strokeWidth': strokeWidth,
      'tool': tool.toString(),
    };
  }

  factory DrawingPath.fromJson(Map<String, dynamic> json) {
    return DrawingPath(
      points: (json['points'] as List).map((p) => Offset(p[0], p[1])).toList(),
      color: Color(json['color']),
      strokeWidth: json['strokeWidth'],
      tool: DrawingTool.values.firstWhere(
        (e) => e.toString() == json['tool'],
        orElse: () => DrawingTool.brush,
      ),
    );
  }
}

enum DrawingTool { brush, eraser, stamp, text }

class TemplateModel {
  final String id;
  final String name;
  final String previewImagePath;
  final String templateImagePath;
  final TemplateCategory category;
  final int difficulty;
  final List<String> colors;
  final String? educationalPrompt;

  TemplateModel({
    required this.id,
    required this.name,
    required this.previewImagePath,
    required this.templateImagePath,
    required this.category,
    this.difficulty = 1,
    this.colors = const [],
    this.educationalPrompt,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'previewImagePath': previewImagePath,
      'templateImagePath': templateImagePath,
      'category': category.toString(),
      'difficulty': difficulty,
      'colors': colors,
      'educationalPrompt': educationalPrompt,
    };
  }

  factory TemplateModel.fromJson(Map<String, dynamic> json) {
    return TemplateModel(
      id: json['id'],
      name: json['name'],
      previewImagePath: json['previewImagePath'],
      templateImagePath: json['templateImagePath'],
      category: TemplateCategory.values.firstWhere(
        (e) => e.toString() == json['category'],
        orElse: () => TemplateCategory.animals,
      ),
      difficulty: json['difficulty'] ?? 1,
      colors: List<String>.from(json['colors'] ?? []),
      educationalPrompt: json['educationalPrompt'],
    );
  }
}

enum TemplateCategory { animals, shapes, letters, numbers, seasonal, daily ,educational}
