// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'profile_pin_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ProfilePinResponse {

 bool get success; String get message; ProfilePinData? get data;
/// Create a copy of ProfilePinResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProfilePinResponseCopyWith<ProfilePinResponse> get copyWith => _$ProfilePinResponseCopyWithImpl<ProfilePinResponse>(this as ProfilePinResponse, _$identity);

  /// Serializes this ProfilePinResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProfilePinResponse&&(identical(other.success, success) || other.success == success)&&(identical(other.message, message) || other.message == message)&&(identical(other.data, data) || other.data == data));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,success,message,data);

@override
String toString() {
  return 'ProfilePinResponse(success: $success, message: $message, data: $data)';
}


}

/// @nodoc
abstract mixin class $ProfilePinResponseCopyWith<$Res>  {
  factory $ProfilePinResponseCopyWith(ProfilePinResponse value, $Res Function(ProfilePinResponse) _then) = _$ProfilePinResponseCopyWithImpl;
@useResult
$Res call({
 bool success, String message, ProfilePinData? data
});


$ProfilePinDataCopyWith<$Res>? get data;

}
/// @nodoc
class _$ProfilePinResponseCopyWithImpl<$Res>
    implements $ProfilePinResponseCopyWith<$Res> {
  _$ProfilePinResponseCopyWithImpl(this._self, this._then);

  final ProfilePinResponse _self;
  final $Res Function(ProfilePinResponse) _then;

/// Create a copy of ProfilePinResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? success = null,Object? message = null,Object? data = freezed,}) {
  return _then(_self.copyWith(
success: null == success ? _self.success : success // ignore: cast_nullable_to_non_nullable
as bool,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,data: freezed == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as ProfilePinData?,
  ));
}
/// Create a copy of ProfilePinResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ProfilePinDataCopyWith<$Res>? get data {
    if (_self.data == null) {
    return null;
  }

  return $ProfilePinDataCopyWith<$Res>(_self.data!, (value) {
    return _then(_self.copyWith(data: value));
  });
}
}


/// Adds pattern-matching-related methods to [ProfilePinResponse].
extension ProfilePinResponsePatterns on ProfilePinResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ProfilePinResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ProfilePinResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ProfilePinResponse value)  $default,){
final _that = this;
switch (_that) {
case _ProfilePinResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ProfilePinResponse value)?  $default,){
final _that = this;
switch (_that) {
case _ProfilePinResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool success,  String message,  ProfilePinData? data)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ProfilePinResponse() when $default != null:
return $default(_that.success,_that.message,_that.data);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool success,  String message,  ProfilePinData? data)  $default,) {final _that = this;
switch (_that) {
case _ProfilePinResponse():
return $default(_that.success,_that.message,_that.data);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool success,  String message,  ProfilePinData? data)?  $default,) {final _that = this;
switch (_that) {
case _ProfilePinResponse() when $default != null:
return $default(_that.success,_that.message,_that.data);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ProfilePinResponse implements ProfilePinResponse {
  const _ProfilePinResponse({required this.success, required this.message, this.data});
  factory _ProfilePinResponse.fromJson(Map<String, dynamic> json) => _$ProfilePinResponseFromJson(json);

@override final  bool success;
@override final  String message;
@override final  ProfilePinData? data;

/// Create a copy of ProfilePinResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProfilePinResponseCopyWith<_ProfilePinResponse> get copyWith => __$ProfilePinResponseCopyWithImpl<_ProfilePinResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ProfilePinResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProfilePinResponse&&(identical(other.success, success) || other.success == success)&&(identical(other.message, message) || other.message == message)&&(identical(other.data, data) || other.data == data));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,success,message,data);

@override
String toString() {
  return 'ProfilePinResponse(success: $success, message: $message, data: $data)';
}


}

/// @nodoc
abstract mixin class _$ProfilePinResponseCopyWith<$Res> implements $ProfilePinResponseCopyWith<$Res> {
  factory _$ProfilePinResponseCopyWith(_ProfilePinResponse value, $Res Function(_ProfilePinResponse) _then) = __$ProfilePinResponseCopyWithImpl;
@override @useResult
$Res call({
 bool success, String message, ProfilePinData? data
});


@override $ProfilePinDataCopyWith<$Res>? get data;

}
/// @nodoc
class __$ProfilePinResponseCopyWithImpl<$Res>
    implements _$ProfilePinResponseCopyWith<$Res> {
  __$ProfilePinResponseCopyWithImpl(this._self, this._then);

  final _ProfilePinResponse _self;
  final $Res Function(_ProfilePinResponse) _then;

/// Create a copy of ProfilePinResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? success = null,Object? message = null,Object? data = freezed,}) {
  return _then(_ProfilePinResponse(
success: null == success ? _self.success : success // ignore: cast_nullable_to_non_nullable
as bool,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,data: freezed == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as ProfilePinData?,
  ));
}

/// Create a copy of ProfilePinResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ProfilePinDataCopyWith<$Res>? get data {
    if (_self.data == null) {
    return null;
  }

  return $ProfilePinDataCopyWith<$Res>(_self.data!, (value) {
    return _then(_self.copyWith(data: value));
  });
}
}


/// @nodoc
mixin _$ProfilePinData {

 String get profileToken; Profile get profile;
/// Create a copy of ProfilePinData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProfilePinDataCopyWith<ProfilePinData> get copyWith => _$ProfilePinDataCopyWithImpl<ProfilePinData>(this as ProfilePinData, _$identity);

  /// Serializes this ProfilePinData to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProfilePinData&&(identical(other.profileToken, profileToken) || other.profileToken == profileToken)&&(identical(other.profile, profile) || other.profile == profile));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,profileToken,profile);

@override
String toString() {
  return 'ProfilePinData(profileToken: $profileToken, profile: $profile)';
}


}

/// @nodoc
abstract mixin class $ProfilePinDataCopyWith<$Res>  {
  factory $ProfilePinDataCopyWith(ProfilePinData value, $Res Function(ProfilePinData) _then) = _$ProfilePinDataCopyWithImpl;
@useResult
$Res call({
 String profileToken, Profile profile
});


$ProfileCopyWith<$Res> get profile;

}
/// @nodoc
class _$ProfilePinDataCopyWithImpl<$Res>
    implements $ProfilePinDataCopyWith<$Res> {
  _$ProfilePinDataCopyWithImpl(this._self, this._then);

  final ProfilePinData _self;
  final $Res Function(ProfilePinData) _then;

/// Create a copy of ProfilePinData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? profileToken = null,Object? profile = null,}) {
  return _then(_self.copyWith(
profileToken: null == profileToken ? _self.profileToken : profileToken // ignore: cast_nullable_to_non_nullable
as String,profile: null == profile ? _self.profile : profile // ignore: cast_nullable_to_non_nullable
as Profile,
  ));
}
/// Create a copy of ProfilePinData
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ProfileCopyWith<$Res> get profile {
  
  return $ProfileCopyWith<$Res>(_self.profile, (value) {
    return _then(_self.copyWith(profile: value));
  });
}
}


/// Adds pattern-matching-related methods to [ProfilePinData].
extension ProfilePinDataPatterns on ProfilePinData {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ProfilePinData value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ProfilePinData() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ProfilePinData value)  $default,){
final _that = this;
switch (_that) {
case _ProfilePinData():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ProfilePinData value)?  $default,){
final _that = this;
switch (_that) {
case _ProfilePinData() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String profileToken,  Profile profile)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ProfilePinData() when $default != null:
return $default(_that.profileToken,_that.profile);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String profileToken,  Profile profile)  $default,) {final _that = this;
switch (_that) {
case _ProfilePinData():
return $default(_that.profileToken,_that.profile);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String profileToken,  Profile profile)?  $default,) {final _that = this;
switch (_that) {
case _ProfilePinData() when $default != null:
return $default(_that.profileToken,_that.profile);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ProfilePinData implements ProfilePinData {
  const _ProfilePinData({required this.profileToken, required this.profile});
  factory _ProfilePinData.fromJson(Map<String, dynamic> json) => _$ProfilePinDataFromJson(json);

@override final  String profileToken;
@override final  Profile profile;

/// Create a copy of ProfilePinData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProfilePinDataCopyWith<_ProfilePinData> get copyWith => __$ProfilePinDataCopyWithImpl<_ProfilePinData>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ProfilePinDataToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProfilePinData&&(identical(other.profileToken, profileToken) || other.profileToken == profileToken)&&(identical(other.profile, profile) || other.profile == profile));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,profileToken,profile);

@override
String toString() {
  return 'ProfilePinData(profileToken: $profileToken, profile: $profile)';
}


}

/// @nodoc
abstract mixin class _$ProfilePinDataCopyWith<$Res> implements $ProfilePinDataCopyWith<$Res> {
  factory _$ProfilePinDataCopyWith(_ProfilePinData value, $Res Function(_ProfilePinData) _then) = __$ProfilePinDataCopyWithImpl;
@override @useResult
$Res call({
 String profileToken, Profile profile
});


@override $ProfileCopyWith<$Res> get profile;

}
/// @nodoc
class __$ProfilePinDataCopyWithImpl<$Res>
    implements _$ProfilePinDataCopyWith<$Res> {
  __$ProfilePinDataCopyWithImpl(this._self, this._then);

  final _ProfilePinData _self;
  final $Res Function(_ProfilePinData) _then;

/// Create a copy of ProfilePinData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? profileToken = null,Object? profile = null,}) {
  return _then(_ProfilePinData(
profileToken: null == profileToken ? _self.profileToken : profileToken // ignore: cast_nullable_to_non_nullable
as String,profile: null == profile ? _self.profile : profile // ignore: cast_nullable_to_non_nullable
as Profile,
  ));
}

/// Create a copy of ProfilePinData
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ProfileCopyWith<$Res> get profile {
  
  return $ProfileCopyWith<$Res>(_self.profile, (value) {
    return _then(_self.copyWith(profile: value));
  });
}
}

// dart format on
