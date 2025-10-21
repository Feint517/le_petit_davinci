// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_pin_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ProfilePinResponse _$ProfilePinResponseFromJson(Map<String, dynamic> json) =>
    _ProfilePinResponse(
      success: json['success'] as bool,
      message: json['message'] as String,
      data:
          json['data'] == null
              ? null
              : ProfilePinData.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ProfilePinResponseToJson(_ProfilePinResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'data': instance.data,
    };

_ProfilePinData _$ProfilePinDataFromJson(Map<String, dynamic> json) =>
    _ProfilePinData(
      profileToken: json['profileToken'] as String,
      profile: Profile.fromJson(json['profile'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ProfilePinDataToJson(_ProfilePinData instance) =>
    <String, dynamic>{
      'profileToken': instance.profileToken,
      'profile': instance.profile,
    };
