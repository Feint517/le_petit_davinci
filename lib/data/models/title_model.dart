import 'package:freezed_annotation/freezed_annotation.dart';

part 'title_model.freezed.dart';
part 'title_model.g.dart';

@freezed
abstract class TitleModel with _$TitleModel {
  factory TitleModel({
    required String category,
    required String name,
    required String description,
    required String unlockLevel,
  }) = _TitleModel;

  factory TitleModel.fromJson(Map<String, dynamic> json) =>
      _$TitleModelFromJson(json);
}
