import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:le_petit_davinci/data/models/parent_model.dart';

part 'api_model.freezed.dart';
part 'api_model.g.dart';


@freezed
abstract class ApiResponseModel with _$ApiResponseModel {
  factory ApiResponseModel({
    required int status,
    required String message,
    required ParentModel parent,
  }) = _ApiResponseModel;

  factory ApiResponseModel.fromJson(Map<String, dynamic> json) =>
      _$ApiResponseModelFromJson(json);
}

