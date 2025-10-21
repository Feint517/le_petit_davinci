// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'refresh_token_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_RefreshTokenResponse _$RefreshTokenResponseFromJson(
  Map<String, dynamic> json,
) => _RefreshTokenResponse(
  success: json['success'] as bool,
  message: json['message'] as String,
  data:
      json['data'] == null
          ? null
          : RefreshTokenData.fromJson(json['data'] as Map<String, dynamic>),
);

Map<String, dynamic> _$RefreshTokenResponseToJson(
  _RefreshTokenResponse instance,
) => <String, dynamic>{
  'success': instance.success,
  'message': instance.message,
  'data': instance.data,
};

_RefreshTokenData _$RefreshTokenDataFromJson(Map<String, dynamic> json) =>
    _RefreshTokenData(
      session: SupabaseSession.fromJson(
        json['session'] as Map<String, dynamic>,
      ),
    );

Map<String, dynamic> _$RefreshTokenDataToJson(_RefreshTokenData instance) =>
    <String, dynamic>{'session': instance.session};
