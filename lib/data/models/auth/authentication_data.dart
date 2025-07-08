import 'package:freezed_annotation/freezed_annotation.dart';

part 'authentication_data.freezed.dart';
part 'authentication_data.g.dart';

@freezed
abstract class AuthenticationData with _$AuthenticationData {
  factory AuthenticationData({required int id}) = _AuthenticationData;

  factory AuthenticationData.fromJson(Map<String, dynamic> json) =>
      _$AuthenticationDataFromJson(json);
}
