// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AuthResponse _$AuthResponseFromJson(Map<String, dynamic> json) =>
    _AuthResponse(
      success: json['success'] as bool,
      message: json['message'] as String,
      data: AuthData.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AuthResponseToJson(_AuthResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'data': instance.data,
    };

_AuthData _$AuthDataFromJson(Map<String, dynamic> json) => _AuthData(
  session:
      json['session'] == null
          ? null
          : SupabaseSession.fromJson(json['session'] as Map<String, dynamic>),
  user:
      json['user'] == null
          ? null
          : SupabaseUser.fromJson(json['user'] as Map<String, dynamic>),
  profiles:
      (json['profiles'] as List<dynamic>?)
          ?.map((e) => Profile.fromJson(e as Map<String, dynamic>))
          .toList(),
  profileCount: (json['profileCount'] as num?)?.toInt(),
);

Map<String, dynamic> _$AuthDataToJson(_AuthData instance) => <String, dynamic>{
  'session': instance.session,
  'user': instance.user,
  'profiles': instance.profiles,
  'profileCount': instance.profileCount,
};
