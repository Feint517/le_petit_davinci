import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:le_petit_davinci/data/models/progression_model.dart';
import 'package:le_petit_davinci/data/models/title_model.dart';

part 'child_model.freezed.dart';
part 'child_model.g.dart';


@freezed
abstract class ChildModel with _$ChildModel {
  factory ChildModel ({
    required String id,
    required String name,
    required String lastName,
    required String age,
    required List<String> unlockedBadges,
    required List<TitleModel> titles,
    required Map<String, ProgressionModel> progression,

  }) = _ChildModel;

   factory ChildModel.fromJson(Map<String, dynamic> json) =>
      _$ChildModelFromJson(json);
}