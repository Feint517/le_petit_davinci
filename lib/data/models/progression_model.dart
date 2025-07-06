import 'package:freezed_annotation/freezed_annotation.dart';

part 'progression_model.freezed.dart';
part 'progression_model.g.dart';


@freezed
abstract class ProgressionModel with _$ProgressionModel {
  factory ProgressionModel({required int level, required int maxLevel}) =
      _ProgressionModel;

      factory ProgressionModel.fromJson(Map<String, dynamic> json) =>
      _$ProgressionModelFromJson(json);
}
