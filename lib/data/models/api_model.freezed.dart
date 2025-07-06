// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'api_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ApiResponseModel {

 int get status; String get message; ParentModel get parent;
/// Create a copy of ApiResponseModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ApiResponseModelCopyWith<ApiResponseModel> get copyWith => _$ApiResponseModelCopyWithImpl<ApiResponseModel>(this as ApiResponseModel, _$identity);

  /// Serializes this ApiResponseModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ApiResponseModel&&(identical(other.status, status) || other.status == status)&&(identical(other.message, message) || other.message == message)&&(identical(other.parent, parent) || other.parent == parent));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,status,message,parent);

@override
String toString() {
  return 'ApiResponseModel(status: $status, message: $message, parent: $parent)';
}


}

/// @nodoc
abstract mixin class $ApiResponseModelCopyWith<$Res>  {
  factory $ApiResponseModelCopyWith(ApiResponseModel value, $Res Function(ApiResponseModel) _then) = _$ApiResponseModelCopyWithImpl;
@useResult
$Res call({
 int status, String message, ParentModel parent
});


$ParentModelCopyWith<$Res> get parent;

}
/// @nodoc
class _$ApiResponseModelCopyWithImpl<$Res>
    implements $ApiResponseModelCopyWith<$Res> {
  _$ApiResponseModelCopyWithImpl(this._self, this._then);

  final ApiResponseModel _self;
  final $Res Function(ApiResponseModel) _then;

/// Create a copy of ApiResponseModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? message = null,Object? parent = null,}) {
  return _then(_self.copyWith(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as int,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,parent: null == parent ? _self.parent : parent // ignore: cast_nullable_to_non_nullable
as ParentModel,
  ));
}
/// Create a copy of ApiResponseModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ParentModelCopyWith<$Res> get parent {
  
  return $ParentModelCopyWith<$Res>(_self.parent, (value) {
    return _then(_self.copyWith(parent: value));
  });
}
}


/// Adds pattern-matching-related methods to [ApiResponseModel].
extension ApiResponseModelPatterns on ApiResponseModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ApiResponseModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ApiResponseModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ApiResponseModel value)  $default,){
final _that = this;
switch (_that) {
case _ApiResponseModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ApiResponseModel value)?  $default,){
final _that = this;
switch (_that) {
case _ApiResponseModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int status,  String message,  ParentModel parent)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ApiResponseModel() when $default != null:
return $default(_that.status,_that.message,_that.parent);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int status,  String message,  ParentModel parent)  $default,) {final _that = this;
switch (_that) {
case _ApiResponseModel():
return $default(_that.status,_that.message,_that.parent);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int status,  String message,  ParentModel parent)?  $default,) {final _that = this;
switch (_that) {
case _ApiResponseModel() when $default != null:
return $default(_that.status,_that.message,_that.parent);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ApiResponseModel implements ApiResponseModel {
   _ApiResponseModel({required this.status, required this.message, required this.parent});
  factory _ApiResponseModel.fromJson(Map<String, dynamic> json) => _$ApiResponseModelFromJson(json);

@override final  int status;
@override final  String message;
@override final  ParentModel parent;

/// Create a copy of ApiResponseModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ApiResponseModelCopyWith<_ApiResponseModel> get copyWith => __$ApiResponseModelCopyWithImpl<_ApiResponseModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ApiResponseModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ApiResponseModel&&(identical(other.status, status) || other.status == status)&&(identical(other.message, message) || other.message == message)&&(identical(other.parent, parent) || other.parent == parent));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,status,message,parent);

@override
String toString() {
  return 'ApiResponseModel(status: $status, message: $message, parent: $parent)';
}


}

/// @nodoc
abstract mixin class _$ApiResponseModelCopyWith<$Res> implements $ApiResponseModelCopyWith<$Res> {
  factory _$ApiResponseModelCopyWith(_ApiResponseModel value, $Res Function(_ApiResponseModel) _then) = __$ApiResponseModelCopyWithImpl;
@override @useResult
$Res call({
 int status, String message, ParentModel parent
});


@override $ParentModelCopyWith<$Res> get parent;

}
/// @nodoc
class __$ApiResponseModelCopyWithImpl<$Res>
    implements _$ApiResponseModelCopyWith<$Res> {
  __$ApiResponseModelCopyWithImpl(this._self, this._then);

  final _ApiResponseModel _self;
  final $Res Function(_ApiResponseModel) _then;

/// Create a copy of ApiResponseModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? message = null,Object? parent = null,}) {
  return _then(_ApiResponseModel(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as int,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,parent: null == parent ? _self.parent : parent // ignore: cast_nullable_to_non_nullable
as ParentModel,
  ));
}

/// Create a copy of ApiResponseModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ParentModelCopyWith<$Res> get parent {
  
  return $ParentModelCopyWith<$Res>(_self.parent, (value) {
    return _then(_self.copyWith(parent: value));
  });
}
}

// dart format on
