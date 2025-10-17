import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:le_petit_davinci/data/models/auth/supabase_session.dart';

part 'verification_response.freezed.dart';
part 'verification_response.g.dart';

@freezed
abstract class VerificationResponse with _$VerificationResponse {
  const factory VerificationResponse({
    required bool success,
    required String message,
    VerificationData? data,
  }) = _VerificationResponse;

  factory VerificationResponse.fromJson(Map<String, dynamic> json) =>
      _$VerificationResponseFromJson(json);
}

@freezed
abstract class VerificationData with _$VerificationData {
  const factory VerificationData({
    required String email,
    required bool verified,
    SupabaseSession? session,
  }) = _VerificationData;

  factory VerificationData.fromJson(Map<String, dynamic> json) =>
      _$VerificationDataFromJson(json);
}
