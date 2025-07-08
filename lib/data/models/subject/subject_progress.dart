import 'package:freezed_annotation/freezed_annotation.dart';

part '../generated/subject_progress.freezed.dart';
part '../generated/subject_progress.g.dart';

@freezed
abstract class SubjectProgress with _$SubjectProgress {
  const factory SubjectProgress({
    required String progress,
    @JsonKey(name: 'time_spent') required String timeSpent,
  }) = _SubjectProgress;

  factory SubjectProgress.fromJson(Map<String, dynamic> json) =>
      _$SubjectProgressFromJson(json);
}
