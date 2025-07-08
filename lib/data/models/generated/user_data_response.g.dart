// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../responses/user_data_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UserDataResponse _$UserDataResponseFromJson(Map<String, dynamic> json) =>
    _UserDataResponse(
      status: (json['status'] as num).toInt(),
      message: json['message'] as String,
      data: UserData.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UserDataResponseToJson(_UserDataResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'data': instance.data,
    };
