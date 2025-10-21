import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:le_petit_davinci/data/models/auth/supabase_session.dart';
import 'package:le_petit_davinci/data/models/auth/supabase_user.dart';
import 'package:le_petit_davinci/data/models/auth/profile.dart';

part 'auth_response.freezed.dart';
part 'auth_response.g.dart';

/// Response from login/register endpoints
@freezed
abstract class AuthResponse with _$AuthResponse {
  const factory AuthResponse({
    required bool success,
    required String message,
    required AuthData data,
  }) = _AuthResponse;

  factory AuthResponse.fromJson(Map<String, dynamic> json) =>
      _$AuthResponseFromJson(json);
}

@freezed
abstract class AuthData with _$AuthData {
  const factory AuthData({
    SupabaseSession? session,
    SupabaseUser? user,
    List<Profile>? profiles,
    int? profileCount,
  }) = _AuthData;

  factory AuthData.fromJson(Map<String, dynamic> json) =>
      _$AuthDataFromJson(json);
}
