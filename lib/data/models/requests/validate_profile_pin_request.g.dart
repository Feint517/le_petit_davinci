// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'validate_profile_pin_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ValidateProfilePinRequest _$ValidateProfilePinRequestFromJson(
  Map<String, dynamic> json,
) => _ValidateProfilePinRequest(
  profileId: json['profile_id'] as String,
  pin: json['pin'] as String,
);

Map<String, dynamic> _$ValidateProfilePinRequestToJson(
  _ValidateProfilePinRequest instance,
) => <String, dynamic>{'profile_id': instance.profileId, 'pin': instance.pin};
