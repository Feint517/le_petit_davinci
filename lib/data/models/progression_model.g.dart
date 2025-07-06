// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'progression_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ProgressionModel _$ProgressionModelFromJson(Map<String, dynamic> json) =>
    _ProgressionModel(
      level: (json['level'] as num).toInt(),
      maxLevel: (json['maxLevel'] as num).toInt(),
    );

Map<String, dynamic> _$ProgressionModelToJson(_ProgressionModel instance) =>
    <String, dynamic>{'level': instance.level, 'maxLevel': instance.maxLevel};
