import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:le_petit_davinci/data/models/auth/supabase_user.dart';

part 'supabase_session.freezed.dart';
part 'supabase_session.g.dart';

@freezed
abstract class SupabaseSession with _$SupabaseSession {
  const factory SupabaseSession({
    @JsonKey(name: 'access_token') required String accessToken,
    @JsonKey(name: 'refresh_token') required String refreshToken,
    @JsonKey(name: 'expires_in') required int expiresIn,
    @JsonKey(name: 'token_type') required String tokenType,
    required SupabaseUser user,
  }) = _SupabaseSession;

  factory SupabaseSession.fromJson(Map<String, dynamic> json) =>
      _$SupabaseSessionFromJson(json);
}
