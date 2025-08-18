import 'package:le_petit_davinci/features/lessons/models/lesson_activity_model.dart';

enum LessonLanguage { english, french }

enum LessonStatus { locked, available, inProgress, completed }

class LessonModel {
  final String id;
  final String title;
  final String description;
  // final LessonType type;
  final LessonLanguage language;
  final LessonStatus status;
  final String videoId;
  final String videoTitle;
  // final String? thumbnailImagePath;
  // final int estimatedTotalMinutes;
  final List<LessonActivity> activities;
  // final String? prerequisiteLessonId;
  final List<String> learningObjectives;
  final DateTime? completedAt;
  final double? progress;

  const LessonModel({
    required this.id,
    required this.title,
    required this.description,
    // required this.type,
    required this.language,
    required this.status,
    required this.videoId,
    required this.videoTitle,
    // this.thumbnailImagePath,
    // required this.estimatedTotalMinutes,
    required this.activities,
    // this.prerequisiteLessonId,
    required this.learningObjectives,
    this.completedAt,
    this.progress,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      // 'type': type.toString(),
      'language': language.toString(),
      'status': status.toString(),
      'videoId': videoId,
      'videoTitle': videoTitle,
      // 'thumbnailImagePath': thumbnailImagePath,
      // 'estimatedTotalMinutes': estimatedTotalMinutes,
      'activities': activities.map((activity) => activity.toJson()).toList(),
      // 'prerequisiteLessonId': prerequisiteLessonId,
      'learningObjectives': learningObjectives,
      'completedAt': completedAt?.toIso8601String(),
      'progress': progress,
    };
  }

  factory LessonModel.fromJson(Map<String, dynamic> json) {
    return LessonModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      // type: LessonType.values.firstWhere((e) => e.toString() == json['type']),
      language: LessonLanguage.values.firstWhere(
        (e) => e.toString() == json['language'],
      ),
      status: LessonStatus.values.firstWhere(
        (e) => e.toString() == json['status'],
      ),
      videoId: json['videoId'],
      videoTitle: json['videoTitle'],
      // thumbnailImagePath: json['thumbnailImagePath'],
      // estimatedTotalMinutes: json['estimatedTotalMinutes'],
      activities:
          (json['activities'] as List)
              .map((activity) => LessonActivity.fromJson(activity))
              .toList(),
      // prerequisiteLessonId: json['prerequisiteLessonId'],
      learningObjectives: List<String>.from(json['learningObjectives']),
      completedAt:
          json['completedAt'] != null
              ? DateTime.parse(json['completedAt'])
              : null,
      progress: json['progress']?.toDouble(),
    );
  }

  LessonModel copyWith({
    String? id,
    String? title,
    String? description,
    // LessonType? type,
    LessonLanguage? language,
    LessonStatus? status,
    int? levelNumber,
    String? videoId,
    String? videoTitle,
    String? thumbnailImagePath,
    int? estimatedTotalMinutes,
    List<LessonActivity>? activities,
    String? prerequisiteLessonId,
    List<String>? learningObjectives,
    DateTime? completedAt,
    double? progress,
  }) {
    return LessonModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      // type: type ?? this.type,
      language: language ?? this.language,
      status: status ?? this.status,
      videoId: videoId ?? this.videoId,
      videoTitle: videoTitle ?? this.videoTitle,
      // thumbnailImagePath: thumbnailImagePath ?? this.thumbnailImagePath,
      // estimatedTotalMinutes:
      // estimatedTotalMinutes ?? this.estimatedTotalMinutes,
      activities: activities ?? this.activities,
      // prerequisiteLessonId: prerequisiteLessonId ?? this.prerequisiteLessonId,
      learningObjectives: learningObjectives ?? this.learningObjectives,
      completedAt: completedAt ?? this.completedAt,
      progress: progress ?? this.progress,
    );
  }

  bool get isCompleted => status == LessonStatus.completed;
  bool get isLocked => status == LessonStatus.locked;
  bool get isAvailable => status == LessonStatus.available;
  bool get isInProgress => status == LessonStatus.inProgress;

  bool get hasActivities => activities.isNotEmpty;
  int get totalActivities => activities.length;

  // Calculate video duration (estimate)
  // int get videoDurationMinutes =>
  //     (estimatedTotalMinutes * 0.4).round();
  // int get activitiesDurationMinutes =>
  //     estimatedTotalMinutes - videoDurationMinutes;
}

// Progress tracking for individual activities
class ActivityProgress {
  final String activityId;
  final String lessonId;
  final bool isCompleted;
  final DateTime? completedAt;
  final double score; // 0.0 to 1.0
  final int attempts;
  final Duration timeSpent;
  final Map<String, dynamic>? metadata;

  const ActivityProgress({
    required this.activityId,
    required this.lessonId,
    required this.isCompleted,
    this.completedAt,
    required this.score,
    required this.attempts,
    required this.timeSpent,
    this.metadata,
  });

  Map<String, dynamic> toJson() {
    return {
      'activityId': activityId,
      'lessonId': lessonId,
      'isCompleted': isCompleted,
      'completedAt': completedAt?.toIso8601String(),
      'score': score,
      'attempts': attempts,
      'timeSpent': timeSpent.inMilliseconds,
      'metadata': metadata,
    };
  }

  factory ActivityProgress.fromJson(Map<String, dynamic> json) {
    return ActivityProgress(
      activityId: json['activityId'],
      lessonId: json['lessonId'],
      isCompleted: json['isCompleted'],
      completedAt:
          json['completedAt'] != null
              ? DateTime.parse(json['completedAt'])
              : null,
      score: json['score'].toDouble(),
      attempts: json['attempts'],
      timeSpent: Duration(milliseconds: json['timeSpent']),
      metadata: json['metadata'],
    );
  }

  ActivityProgress copyWith({
    String? activityId,
    String? lessonId,
    bool? isCompleted,
    DateTime? completedAt,
    double? score,
    int? attempts,
    Duration? timeSpent,
    Map<String, dynamic>? metadata,
  }) {
    return ActivityProgress(
      activityId: activityId ?? this.activityId,
      lessonId: lessonId ?? this.lessonId,
      isCompleted: isCompleted ?? this.isCompleted,
      completedAt: completedAt ?? this.completedAt,
      score: score ?? this.score,
      attempts: attempts ?? this.attempts,
      timeSpent: timeSpent ?? this.timeSpent,
      metadata: metadata ?? this.metadata,
    );
  }
}
