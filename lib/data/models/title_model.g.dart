// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'title_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TitleModel _$TitleModelFromJson(Map<String, dynamic> json) => _TitleModel(
  category: json['category'] as String,
  name: json['name'] as String,
  description: json['description'] as String,
  unlockLevel: json['unlockLevel'] as String,
);

Map<String, dynamic> _$TitleModelToJson(_TitleModel instance) =>
    <String, dynamic>{
      'category': instance.category,
      'name': instance.name,
      'description': instance.description,
      'unlockLevel': instance.unlockLevel,
    };
