// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'validate_profile_pin_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ValidateProfilePinRequest {

@JsonKey(name: 'profile_id') String get profileId; String get pin;
/// Create a copy of ValidateProfilePinRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ValidateProfilePinRequestCopyWith<ValidateProfilePinRequest> get copyWith => _$ValidateProfilePinRequestCopyWithImpl<ValidateProfilePinRequest>(this as ValidateProfilePinRequest, _$identity);

  /// Serializes this ValidateProfilePinRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ValidateProfilePinRequest&&(identical(other.profileId, profileId) || other.profileId == profileId)&&(identical(other.pin, pin) || other.pin == pin));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,profileId,pin);

@override
String toString() {
  return 'ValidateProfilePinRequest(profileId: $profileId, pin: $pin)';
}


}

/// @nodoc
abstract mixin class $ValidateProfilePinRequestCopyWith<$Res>  {
  factory $ValidateProfilePinRequestCopyWith(ValidateProfilePinRequest value, $Res Function(ValidateProfilePinRequest) _then) = _$ValidateProfilePinRequestCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'profile_id') String profileId, String pin
});




}
/// @nodoc
class _$ValidateProfilePinRequestCopyWithImpl<$Res>
    implements $ValidateProfilePinRequestCopyWith<$Res> {
  _$ValidateProfilePinRequestCopyWithImpl(this._self, this._then);

  final ValidateProfilePinRequest _self;
  final $Res Function(ValidateProfilePinRequest) _then;

/// Create a copy of ValidateProfilePinRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? profileId = null,Object? pin = null,}) {
  return _then(_self.copyWith(
profileId: null == profileId ? _self.profileId : profileId // ignore: cast_nullable_to_non_nullable
as String,pin: null == pin ? _self.pin : pin // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [ValidateProfilePinRequest].
extension ValidateProfilePinRequestPatterns on ValidateProfilePinRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ValidateProfilePinRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ValidateProfilePinRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ValidateProfilePinRequest value)  $default,){
final _that = this;
switch (_that) {
case _ValidateProfilePinRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ValidateProfilePinRequest value)?  $default,){
final _that = this;
switch (_that) {
case _ValidateProfilePinRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'profile_id')  String profileId,  String pin)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ValidateProfilePinRequest() when $default != null:
return $default(_that.profileId,_that.pin);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'profile_id')  String profileId,  String pin)  $default,) {final _that = this;
switch (_that) {
case _ValidateProfilePinRequest():
return $default(_that.profileId,_that.pin);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'profile_id')  String profileId,  String pin)?  $default,) {final _that = this;
switch (_that) {
case _ValidateProfilePinRequest() when $default != null:
return $default(_that.profileId,_that.pin);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ValidateProfilePinRequest implements ValidateProfilePinRequest {
  const _ValidateProfilePinRequest({@JsonKey(name: 'profile_id') required this.profileId, required this.pin});
  factory _ValidateProfilePinRequest.fromJson(Map<String, dynamic> json) => _$ValidateProfilePinRequestFromJson(json);

@override@JsonKey(name: 'profile_id') final  String profileId;
@override final  String pin;

/// Create a copy of ValidateProfilePinRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ValidateProfilePinRequestCopyWith<_ValidateProfilePinRequest> get copyWith => __$ValidateProfilePinRequestCopyWithImpl<_ValidateProfilePinRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ValidateProfilePinRequestToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ValidateProfilePinRequest&&(identical(other.profileId, profileId) || other.profileId == profileId)&&(identical(other.pin, pin) || other.pin == pin));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,profileId,pin);

@override
String toString() {
  return 'ValidateProfilePinRequest(profileId: $profileId, pin: $pin)';
}


}

/// @nodoc
abstract mixin class _$ValidateProfilePinRequestCopyWith<$Res> implements $ValidateProfilePinRequestCopyWith<$Res> {
  factory _$ValidateProfilePinRequestCopyWith(_ValidateProfilePinRequest value, $Res Function(_ValidateProfilePinRequest) _then) = __$ValidateProfilePinRequestCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'profile_id') String profileId, String pin
});




}
/// @nodoc
class __$ValidateProfilePinRequestCopyWithImpl<$Res>
    implements _$ValidateProfilePinRequestCopyWith<$Res> {
  __$ValidateProfilePinRequestCopyWithImpl(this._self, this._then);

  final _ValidateProfilePinRequest _self;
  final $Res Function(_ValidateProfilePinRequest) _then;

/// Create a copy of ValidateProfilePinRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? profileId = null,Object? pin = null,}) {
  return _then(_ValidateProfilePinRequest(
profileId: null == profileId ? _self.profileId : profileId // ignore: cast_nullable_to_non_nullable
as String,pin: null == pin ? _self.pin : pin // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
