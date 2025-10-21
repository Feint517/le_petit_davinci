// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'supabase_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SupabaseUser _$SupabaseUserFromJson(Map<String, dynamic> json) =>
    _SupabaseUser(
      id: json['id'] as String,
      email: json['email'] as String,
      phone: json['phone'] as String?,
      userMetadata: json['user_metadata'] as Map<String, dynamic>?,
      appMetadata: json['app_metadata'] as Map<String, dynamic>?,
      emailConfirmedAt: json['email_confirmed_at'] as String?,
      phoneConfirmedAt: json['phone_confirmed_at'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
    );

Map<String, dynamic> _$SupabaseUserToJson(_SupabaseUser instance) =>
    <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'phone': instance.phone,
      'user_metadata': instance.userMetadata,
      'app_metadata': instance.appMetadata,
      'email_confirmed_at': instance.emailConfirmedAt,
      'phone_confirmed_at': instance.phoneConfirmedAt,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
    };
