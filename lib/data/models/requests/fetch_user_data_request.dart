import 'package:freezed_annotation/freezed_annotation.dart';

part 'fetch_user_data_request.freezed.dart';
part 'fetch_user_data_request.g.dart';

@freezed
abstract class FetchUserDataRequest with _$FetchUserDataRequest {
  const factory FetchUserDataRequest({required String id}) =
      _FetchUserDataRequest;

  factory FetchUserDataRequest.fromJson(Map<String, dynamic> json) =>
      _$FetchUserDataRequestFromJson(json);
}
