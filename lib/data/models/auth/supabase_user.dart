import 'package:freezed_annotation/freezed_annotation.dart';

part 'supabase_user.freezed.dart';
part 'supabase_user.g.dart';

@freezed
abstract class SupabaseUser with _$SupabaseUser {
  const factory SupabaseUser({
    required String id,
    required String email,
    String? phone,
    @JsonKey(name: 'user_metadata') Map<String, dynamic>? userMetadata,
    @JsonKey(name: 'app_metadata') Map<String, dynamic>? appMetadata,
    @JsonKey(name: 'email_confirmed_at') String? emailConfirmedAt,
    @JsonKey(name: 'phone_confirmed_at') String? phoneConfirmedAt,
    @JsonKey(name: 'created_at') String? createdAt,
    @JsonKey(name: 'updated_at') String? updatedAt,
  }) = _SupabaseUser;

  factory SupabaseUser.fromJson(Map<String, dynamic> json) =>
      _$SupabaseUserFromJson(json);
}
