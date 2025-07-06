// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'title_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TitleModel {

 String get category; String get name; String get description; String get unlockLevel;
/// Create a copy of TitleModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TitleModelCopyWith<TitleModel> get copyWith => _$TitleModelCopyWithImpl<TitleModel>(this as TitleModel, _$identity);

  /// Serializes this TitleModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TitleModel&&(identical(other.category, category) || other.category == category)&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.unlockLevel, unlockLevel) || other.unlockLevel == unlockLevel));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,category,name,description,unlockLevel);

@override
String toString() {
  return 'TitleModel(category: $category, name: $name, description: $description, unlockLevel: $unlockLevel)';
}


}

/// @nodoc
abstract mixin class $TitleModelCopyWith<$Res>  {
  factory $TitleModelCopyWith(TitleModel value, $Res Function(TitleModel) _then) = _$TitleModelCopyWithImpl;
@useResult
$Res call({
 String category, String name, String description, String unlockLevel
});




}
/// @nodoc
class _$TitleModelCopyWithImpl<$Res>
    implements $TitleModelCopyWith<$Res> {
  _$TitleModelCopyWithImpl(this._self, this._then);

  final TitleModel _self;
  final $Res Function(TitleModel) _then;

/// Create a copy of TitleModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? category = null,Object? name = null,Object? description = null,Object? unlockLevel = null,}) {
  return _then(_self.copyWith(
category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,unlockLevel: null == unlockLevel ? _self.unlockLevel : unlockLevel // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [TitleModel].
extension TitleModelPatterns on TitleModel {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TitleModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TitleModel() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TitleModel value)  $default,){
final _that = this;
switch (_that) {
case _TitleModel():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TitleModel value)?  $default,){
final _that = this;
switch (_that) {
case _TitleModel() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String category,  String name,  String description,  String unlockLevel)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TitleModel() when $default != null:
return $default(_that.category,_that.name,_that.description,_that.unlockLevel);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String category,  String name,  String description,  String unlockLevel)  $default,) {final _that = this;
switch (_that) {
case _TitleModel():
return $default(_that.category,_that.name,_that.description,_that.unlockLevel);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String category,  String name,  String description,  String unlockLevel)?  $default,) {final _that = this;
switch (_that) {
case _TitleModel() when $default != null:
return $default(_that.category,_that.name,_that.description,_that.unlockLevel);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TitleModel implements TitleModel {
   _TitleModel({required this.category, required this.name, required this.description, required this.unlockLevel});
  factory _TitleModel.fromJson(Map<String, dynamic> json) => _$TitleModelFromJson(json);

@override final  String category;
@override final  String name;
@override final  String description;
@override final  String unlockLevel;

/// Create a copy of TitleModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TitleModelCopyWith<_TitleModel> get copyWith => __$TitleModelCopyWithImpl<_TitleModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TitleModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TitleModel&&(identical(other.category, category) || other.category == category)&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.unlockLevel, unlockLevel) || other.unlockLevel == unlockLevel));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,category,name,description,unlockLevel);

@override
String toString() {
  return 'TitleModel(category: $category, name: $name, description: $description, unlockLevel: $unlockLevel)';
}


}

/// @nodoc
abstract mixin class _$TitleModelCopyWith<$Res> implements $TitleModelCopyWith<$Res> {
  factory _$TitleModelCopyWith(_TitleModel value, $Res Function(_TitleModel) _then) = __$TitleModelCopyWithImpl;
@override @useResult
$Res call({
 String category, String name, String description, String unlockLevel
});




}
/// @nodoc
class __$TitleModelCopyWithImpl<$Res>
    implements _$TitleModelCopyWith<$Res> {
  __$TitleModelCopyWithImpl(this._self, this._then);

  final _TitleModel _self;
  final $Res Function(_TitleModel) _then;

/// Create a copy of TitleModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? category = null,Object? name = null,Object? description = null,Object? unlockLevel = null,}) {
  return _then(_TitleModel(
category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,unlockLevel: null == unlockLevel ? _self.unlockLevel : unlockLevel // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
