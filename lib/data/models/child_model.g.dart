// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'child_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ChildModel _$ChildModelFromJson(Map<String, dynamic> json) => _ChildModel(
  id: json['id'] as String,
  name: json['name'] as String,
  lastName: json['lastName'] as String,
  age: json['age'] as String,
  unlockedBadges:
      (json['unlockedBadges'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
  titles:
      (json['titles'] as List<dynamic>)
          .map((e) => TitleModel.fromJson(e as Map<String, dynamic>))
          .toList(),
  progression: (json['progression'] as Map<String, dynamic>).map(
    (k, e) => MapEntry(k, ProgressionModel.fromJson(e as Map<String, dynamic>)),
  ),
);

Map<String, dynamic> _$ChildModelToJson(_ChildModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'lastName': instance.lastName,
      'age': instance.age,
      'unlockedBadges': instance.unlockedBadges,
      'titles': instance.titles,
      'progression': instance.progression,
    };
