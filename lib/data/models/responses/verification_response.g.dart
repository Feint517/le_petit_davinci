// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'verification_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_VerificationResponse _$VerificationResponseFromJson(
  Map<String, dynamic> json,
) => _VerificationResponse(
  success: json['success'] as bool,
  message: json['message'] as String,
  data:
      json['data'] == null
          ? null
          : VerificationData.fromJson(json['data'] as Map<String, dynamic>),
);

Map<String, dynamic> _$VerificationResponseToJson(
  _VerificationResponse instance,
) => <String, dynamic>{
  'success': instance.success,
  'message': instance.message,
  'data': instance.data,
};

_VerificationData _$VerificationDataFromJson(Map<String, dynamic> json) =>
    _VerificationData(
      email: json['email'] as String,
      verified: json['verified'] as bool,
      session:
          json['session'] == null
              ? null
              : SupabaseSession.fromJson(
                json['session'] as Map<String, dynamic>,
              ),
    );

Map<String, dynamic> _$VerificationDataToJson(_VerificationData instance) =>
    <String, dynamic>{
      'email': instance.email,
      'verified': instance.verified,
      'session': instance.session,
    };
