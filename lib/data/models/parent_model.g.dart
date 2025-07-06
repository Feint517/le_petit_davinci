// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'parent_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ParentModel _$ParentModelFromJson(Map<String, dynamic> json) => _ParentModel(
  id: json['id'] as String,
  firstName: json['firstName'] as String,
  lastName: json['lastName'] as String,
  email: json['email'] as String,
  children:
      (json['children'] as List<dynamic>)
          .map((e) => ChildModel.fromJson(e as Map<String, dynamic>))
          .toList(),
);

Map<String, dynamic> _$ParentModelToJson(_ParentModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'email': instance.email,
      'children': instance.children,
    };
