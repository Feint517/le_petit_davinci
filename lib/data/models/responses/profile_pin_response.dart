import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:le_petit_davinci/data/models/auth/profile.dart';

part 'profile_pin_response.freezed.dart';
part 'profile_pin_response.g.dart';

@freezed
abstract class ProfilePinResponse with _$ProfilePinResponse {
  const factory ProfilePinResponse({
    required bool success,
    required String message,
    ProfilePinData? data,
  }) = _ProfilePinResponse;

  factory ProfilePinResponse.fromJson(Map<String, dynamic> json) =>
      _$ProfilePinResponseFromJson(json);
}

@freezed
abstract class ProfilePinData with _$ProfilePinData {
  const factory ProfilePinData({
    required String profileToken,
    required Profile profile,
  }) = _ProfilePinData;

  factory ProfilePinData.fromJson(Map<String, dynamic> json) =>
      _$ProfilePinDataFromJson(json);
}
