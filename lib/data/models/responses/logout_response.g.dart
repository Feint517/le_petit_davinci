// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'logout_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_LogoutResponse _$LogoutResponseFromJson(Map<String, dynamic> json) =>
    _LogoutResponse(
      status: (json['status'] as num).toInt(),
      message: json['message'] as String,
    );

Map<String, dynamic> _$LogoutResponseToJson(_LogoutResponse instance) =>
    <String, dynamic>{'status': instance.status, 'message': instance.message};
