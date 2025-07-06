import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:le_petit_davinci/data/models/child_model.dart';

part 'parent_model.freezed.dart';
part 'parent_model.g.dart';


@freezed
abstract class ParentModel with _$ParentModel {
  factory ParentModel({
    required String id,
    required String firstName,
    required String lastName,
    required String email,
    required List<ChildModel> children,
  }) = _ParentModel;

  factory ParentModel.fromJson(Map<String, dynamic> json) =>
      _$ParentModelFromJson(json);
}

