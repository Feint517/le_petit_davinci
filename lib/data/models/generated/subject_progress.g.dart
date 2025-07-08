// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../subject/subject_progress.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SubjectProgress _$SubjectProgressFromJson(Map<String, dynamic> json) =>
    _SubjectProgress(
      progress: json['progress'] as String,
      timeSpent: json['time_spent'] as String,
    );

Map<String, dynamic> _$SubjectProgressToJson(_SubjectProgress instance) =>
    <String, dynamic>{
      'progress': instance.progress,
      'time_spent': instance.timeSpent,
    };
