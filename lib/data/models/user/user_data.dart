import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:le_petit_davinci/data/models/subject/subject_progress.dart';

part '../generated/user_data.freezed.dart';
part '../generated/user_data.g.dart';

@freezed
abstract class UserData with _$UserData {
  factory UserData({
    required int id,
    required String name,
    @JsonKey(name: 'class') required String userClass,
    required SubjectProgress french,
    required SubjectProgress english,
    required SubjectProgress math,
  }) = _UserData;

  factory UserData.fromJson(Map<String, dynamic> json) =>
      _$UserDataFromJson(json);
}
