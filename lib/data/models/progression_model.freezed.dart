// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'progression_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ProgressionModel {

 int get level; int get maxLevel;
/// Create a copy of ProgressionModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProgressionModelCopyWith<ProgressionModel> get copyWith => _$ProgressionModelCopyWithImpl<ProgressionModel>(this as ProgressionModel, _$identity);

  /// Serializes this ProgressionModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProgressionModel&&(identical(other.level, level) || other.level == level)&&(identical(other.maxLevel, maxLevel) || other.maxLevel == maxLevel));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,level,maxLevel);

@override
String toString() {
  return 'ProgressionModel(level: $level, maxLevel: $maxLevel)';
}


}

/// @nodoc
abstract mixin class $ProgressionModelCopyWith<$Res>  {
  factory $ProgressionModelCopyWith(ProgressionModel value, $Res Function(ProgressionModel) _then) = _$ProgressionModelCopyWithImpl;
@useResult
$Res call({
 int level, int maxLevel
});




}
/// @nodoc
class _$ProgressionModelCopyWithImpl<$Res>
    implements $ProgressionModelCopyWith<$Res> {
  _$ProgressionModelCopyWithImpl(this._self, this._then);

  final ProgressionModel _self;
  final $Res Function(ProgressionModel) _then;

/// Create a copy of ProgressionModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? level = null,Object? maxLevel = null,}) {
  return _then(_self.copyWith(
level: null == level ? _self.level : level // ignore: cast_nullable_to_non_nullable
as int,maxLevel: null == maxLevel ? _self.maxLevel : maxLevel // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [ProgressionModel].
extension ProgressionModelPatterns on ProgressionModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ProgressionModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ProgressionModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ProgressionModel value)  $default,){
final _that = this;
switch (_that) {
case _ProgressionModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ProgressionModel value)?  $default,){
final _that = this;
switch (_that) {
case _ProgressionModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int level,  int maxLevel)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ProgressionModel() when $default != null:
return $default(_that.level,_that.maxLevel);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int level,  int maxLevel)  $default,) {final _that = this;
switch (_that) {
case _ProgressionModel():
return $default(_that.level,_that.maxLevel);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int level,  int maxLevel)?  $default,) {final _that = this;
switch (_that) {
case _ProgressionModel() when $default != null:
return $default(_that.level,_that.maxLevel);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ProgressionModel implements ProgressionModel {
   _ProgressionModel({required this.level, required this.maxLevel});
  factory _ProgressionModel.fromJson(Map<String, dynamic> json) => _$ProgressionModelFromJson(json);

@override final  int level;
@override final  int maxLevel;

/// Create a copy of ProgressionModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProgressionModelCopyWith<_ProgressionModel> get copyWith => __$ProgressionModelCopyWithImpl<_ProgressionModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ProgressionModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProgressionModel&&(identical(other.level, level) || other.level == level)&&(identical(other.maxLevel, maxLevel) || other.maxLevel == maxLevel));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,level,maxLevel);

@override
String toString() {
  return 'ProgressionModel(level: $level, maxLevel: $maxLevel)';
}


}

/// @nodoc
abstract mixin class _$ProgressionModelCopyWith<$Res> implements $ProgressionModelCopyWith<$Res> {
  factory _$ProgressionModelCopyWith(_ProgressionModel value, $Res Function(_ProgressionModel) _then) = __$ProgressionModelCopyWithImpl;
@override @useResult
$Res call({
 int level, int maxLevel
});




}
/// @nodoc
class __$ProgressionModelCopyWithImpl<$Res>
    implements _$ProgressionModelCopyWith<$Res> {
  __$ProgressionModelCopyWithImpl(this._self, this._then);

  final _ProgressionModel _self;
  final $Res Function(_ProgressionModel) _then;

/// Create a copy of ProgressionModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? level = null,Object? maxLevel = null,}) {
  return _then(_ProgressionModel(
level: null == level ? _self.level : level // ignore: cast_nullable_to_non_nullable
as int,maxLevel: null == maxLevel ? _self.maxLevel : maxLevel // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
