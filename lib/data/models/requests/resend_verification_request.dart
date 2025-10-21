import 'package:freezed_annotation/freezed_annotation.dart';

part 'resend_verification_request.freezed.dart';
part 'resend_verification_request.g.dart';

@freezed
abstract class ResendVerificationRequest with _$ResendVerificationRequest {
  const factory ResendVerificationRequest({required String email}) =
      _ResendVerificationRequest;

  factory ResendVerificationRequest.fromJson(Map<String, dynamic> json) =>
      _$ResendVerificationRequestFromJson(json);
}
