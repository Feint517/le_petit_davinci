// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'supabase_session.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SupabaseSession _$SupabaseSessionFromJson(Map<String, dynamic> json) =>
    _SupabaseSession(
      accessToken: json['access_token'] as String,
      refreshToken: json['refresh_token'] as String,
      expiresIn: (json['expires_in'] as num).toInt(),
      tokenType: json['token_type'] as String,
      user: SupabaseUser.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SupabaseSessionToJson(_SupabaseSession instance) =>
    <String, dynamic>{
      'access_token': instance.accessToken,
      'refresh_token': instance.refreshToken,
      'expires_in': instance.expiresIn,
      'token_type': instance.tokenType,
      'user': instance.user,
    };
