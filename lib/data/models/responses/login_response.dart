import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:le_petit_davinci/data/models/auth/authentication_data.dart';

part 'login_response.freezed.dart';
part 'login_response.g.dart';

@freezed
abstract class LoginResponse with _$LoginResponse {
  const factory LoginResponse({
    required int status,
    required String message,
    required AuthenticationData data,
  }) = _LoginResponse;

  factory LoginResponse.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseFromJson(json);
}
