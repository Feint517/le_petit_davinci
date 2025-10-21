import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:le_petit_davinci/data/models/auth/supabase_session.dart';

part 'refresh_token_response.freezed.dart';
part 'refresh_token_response.g.dart';

@freezed
abstract class RefreshTokenResponse with _$RefreshTokenResponse {
  const factory RefreshTokenResponse({
    required bool success,
    required String message,
    RefreshTokenData? data,
  }) = _RefreshTokenResponse;

  factory RefreshTokenResponse.fromJson(Map<String, dynamic> json) =>
      _$RefreshTokenResponseFromJson(json);
}

@freezed
abstract class RefreshTokenData with _$RefreshTokenData {
  const factory RefreshTokenData({required SupabaseSession session}) =
      _RefreshTokenData;

  factory RefreshTokenData.fromJson(Map<String, dynamic> json) =>
      _$RefreshTokenDataFromJson(json);
}
