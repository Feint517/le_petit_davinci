// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ApiResponseModel _$ApiResponseModelFromJson(Map<String, dynamic> json) =>
    _ApiResponseModel(
      status: (json['status'] as num).toInt(),
      message: json['message'] as String,
      parent: ParentModel.fromJson(json['parent'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ApiResponseModelToJson(_ApiResponseModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'parent': instance.parent,
    };
