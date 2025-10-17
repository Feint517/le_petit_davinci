import 'package:freezed_annotation/freezed_annotation.dart';

part 'validate_profile_pin_request.freezed.dart';
part 'validate_profile_pin_request.g.dart';

@freezed
abstract class ValidateProfilePinRequest with _$ValidateProfilePinRequest {
  const factory ValidateProfilePinRequest({
    @JsonKey(name: 'profile_id') required String profileId,
    required String pin,
  }) = _ValidateProfilePinRequest;

  factory ValidateProfilePinRequest.fromJson(Map<String, dynamic> json) =>
      _$ValidateProfilePinRequestFromJson(json);
}
