// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../user/user_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UserData _$UserDataFromJson(Map<String, dynamic> json) => _UserData(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String,
  userClass: json['class'] as String,
  french: SubjectProgress.fromJson(json['french'] as Map<String, dynamic>),
  english: SubjectProgress.fromJson(json['english'] as Map<String, dynamic>),
  math: SubjectProgress.fromJson(json['math'] as Map<String, dynamic>),
);

Map<String, dynamic> _$UserDataToJson(_UserData instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'class': instance.userClass,
  'french': instance.french,
  'english': instance.english,
  'math': instance.math,
};
