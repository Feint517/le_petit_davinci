import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:le_petit_davinci/data/models/user/user_data.dart';

part '../generated/user_data_response.freezed.dart';
part '../generated/user_data_response.g.dart';

@freezed
abstract class UserDataResponse with _$UserDataResponse {
  const factory UserDataResponse({
    required int status,
    required String message,
    required UserData data,
  }) = _UserDataResponse;

  factory UserDataResponse.fromJson(Map<String, dynamic> json) =>
      _$UserDataResponseFromJson(json);
}