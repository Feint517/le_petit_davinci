// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'auth_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AuthResponse {

 bool get success; String get message; AuthData get data;
/// Create a copy of AuthResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AuthResponseCopyWith<AuthResponse> get copyWith => _$AuthResponseCopyWithImpl<AuthResponse>(this as AuthResponse, _$identity);

  /// Serializes this AuthResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuthResponse&&(identical(other.success, success) || other.success == success)&&(identical(other.message, message) || other.message == message)&&(identical(other.data, data) || other.data == data));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,success,message,data);

@override
String toString() {
  return 'AuthResponse(success: $success, message: $message, data: $data)';
}


}

/// @nodoc
abstract mixin class $AuthResponseCopyWith<$Res>  {
  factory $AuthResponseCopyWith(AuthResponse value, $Res Function(AuthResponse) _then) = _$AuthResponseCopyWithImpl;
@useResult
$Res call({
 bool success, String message, AuthData data
});


$AuthDataCopyWith<$Res> get data;

}
/// @nodoc
class _$AuthResponseCopyWithImpl<$Res>
    implements $AuthResponseCopyWith<$Res> {
  _$AuthResponseCopyWithImpl(this._self, this._then);

  final AuthResponse _self;
  final $Res Function(AuthResponse) _then;

/// Create a copy of AuthResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? success = null,Object? message = null,Object? data = null,}) {
  return _then(_self.copyWith(
success: null == success ? _self.success : success // ignore: cast_nullable_to_non_nullable
as bool,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,data: null == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as AuthData,
  ));
}
/// Create a copy of AuthResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AuthDataCopyWith<$Res> get data {
  
  return $AuthDataCopyWith<$Res>(_self.data, (value) {
    return _then(_self.copyWith(data: value));
  });
}
}


/// Adds pattern-matching-related methods to [AuthResponse].
extension AuthResponsePatterns on AuthResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AuthResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AuthResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AuthResponse value)  $default,){
final _that = this;
switch (_that) {
case _AuthResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AuthResponse value)?  $default,){
final _that = this;
switch (_that) {
case _AuthResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool success,  String message,  AuthData data)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AuthResponse() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool success,  String message,  AuthData data)  $default,) {final _that = this;
switch (_that) {
case _AuthResponse():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool success,  String message,  AuthData data)?  $default,) {final _that = this;
switch (_that) {
case _AuthResponse() when $default != null:
return $default(_that.success,_that.message,_that.data);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AuthResponse implements AuthResponse {
  const _AuthResponse({required this.success, required this.message, required this.data});
  factory _AuthResponse.fromJson(Map<String, dynamic> json) => _$AuthResponseFromJson(json);

@override final  bool success;
@override final  String message;
@override final  AuthData data;

/// Create a copy of AuthResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AuthResponseCopyWith<_AuthResponse> get copyWith => __$AuthResponseCopyWithImpl<_AuthResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AuthResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AuthResponse&&(identical(other.success, success) || other.success == success)&&(identical(other.message, message) || other.message == message)&&(identical(other.data, data) || other.data == data));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,success,message,data);

@override
String toString() {
  return 'AuthResponse(success: $success, message: $message, data: $data)';
}


}

/// @nodoc
abstract mixin class _$AuthResponseCopyWith<$Res> implements $AuthResponseCopyWith<$Res> {
  factory _$AuthResponseCopyWith(_AuthResponse value, $Res Function(_AuthResponse) _then) = __$AuthResponseCopyWithImpl;
@override @useResult
$Res call({
 bool success, String message, AuthData data
});


@override $AuthDataCopyWith<$Res> get data;

}
/// @nodoc
class __$AuthResponseCopyWithImpl<$Res>
    implements _$AuthResponseCopyWith<$Res> {
  __$AuthResponseCopyWithImpl(this._self, this._then);

  final _AuthResponse _self;
  final $Res Function(_AuthResponse) _then;

/// Create a copy of AuthResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? success = null,Object? message = null,Object? data = null,}) {
  return _then(_AuthResponse(
success: null == success ? _self.success : success // ignore: cast_nullable_to_non_nullable
as bool,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,data: null == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as AuthData,
  ));
}

/// Create a copy of AuthResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AuthDataCopyWith<$Res> get data {
  
  return $AuthDataCopyWith<$Res>(_self.data, (value) {
    return _then(_self.copyWith(data: value));
  });
}
}


/// @nodoc
mixin _$AuthData {

 SupabaseSession? get session; SupabaseUser? get user; List<Profile>? get profiles; int? get profileCount;
/// Create a copy of AuthData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AuthDataCopyWith<AuthData> get copyWith => _$AuthDataCopyWithImpl<AuthData>(this as AuthData, _$identity);

  /// Serializes this AuthData to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuthData&&(identical(other.session, session) || other.session == session)&&(identical(other.user, user) || other.user == user)&&const DeepCollectionEquality().equals(other.profiles, profiles)&&(identical(other.profileCount, profileCount) || other.profileCount == profileCount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,session,user,const DeepCollectionEquality().hash(profiles),profileCount);

@override
String toString() {
  return 'AuthData(session: $session, user: $user, profiles: $profiles, profileCount: $profileCount)';
}


}

/// @nodoc
abstract mixin class $AuthDataCopyWith<$Res>  {
  factory $AuthDataCopyWith(AuthData value, $Res Function(AuthData) _then) = _$AuthDataCopyWithImpl;
@useResult
$Res call({
 SupabaseSession? session, SupabaseUser? user, List<Profile>? profiles, int? profileCount
});


$SupabaseSessionCopyWith<$Res>? get session;$SupabaseUserCopyWith<$Res>? get user;

}
/// @nodoc
class _$AuthDataCopyWithImpl<$Res>
    implements $AuthDataCopyWith<$Res> {
  _$AuthDataCopyWithImpl(this._self, this._then);

  final AuthData _self;
  final $Res Function(AuthData) _then;

/// Create a copy of AuthData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? session = freezed,Object? user = freezed,Object? profiles = freezed,Object? profileCount = freezed,}) {
  return _then(_self.copyWith(
session: freezed == session ? _self.session : session // ignore: cast_nullable_to_non_nullable
as SupabaseSession?,user: freezed == user ? _self.user : user // ignore: cast_nullable_to_non_nullable
as SupabaseUser?,profiles: freezed == profiles ? _self.profiles : profiles // ignore: cast_nullable_to_non_nullable
as List<Profile>?,profileCount: freezed == profileCount ? _self.profileCount : profileCount // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}
/// Create a copy of AuthData
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SupabaseSessionCopyWith<$Res>? get session {
    if (_self.session == null) {
    return null;
  }

  return $SupabaseSessionCopyWith<$Res>(_self.session!, (value) {
    return _then(_self.copyWith(session: value));
  });
}/// Create a copy of AuthData
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SupabaseUserCopyWith<$Res>? get user {
    if (_self.user == null) {
    return null;
  }

  return $SupabaseUserCopyWith<$Res>(_self.user!, (value) {
    return _then(_self.copyWith(user: value));
  });
}
}


/// Adds pattern-matching-related methods to [AuthData].
extension AuthDataPatterns on AuthData {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AuthData value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AuthData() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AuthData value)  $default,){
final _that = this;
switch (_that) {
case _AuthData():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AuthData value)?  $default,){
final _that = this;
switch (_that) {
case _AuthData() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( SupabaseSession? session,  SupabaseUser? user,  List<Profile>? profiles,  int? profileCount)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AuthData() when $default != null:
return $default(_that.session,_that.user,_that.profiles,_that.profileCount);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( SupabaseSession? session,  SupabaseUser? user,  List<Profile>? profiles,  int? profileCount)  $default,) {final _that = this;
switch (_that) {
case _AuthData():
return $default(_that.session,_that.user,_that.profiles,_that.profileCount);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( SupabaseSession? session,  SupabaseUser? user,  List<Profile>? profiles,  int? profileCount)?  $default,) {final _that = this;
switch (_that) {
case _AuthData() when $default != null:
return $default(_that.session,_that.user,_that.profiles,_that.profileCount);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AuthData implements AuthData {
  const _AuthData({this.session, this.user, final  List<Profile>? profiles, this.profileCount}): _profiles = profiles;
  factory _AuthData.fromJson(Map<String, dynamic> json) => _$AuthDataFromJson(json);

@override final  SupabaseSession? session;
@override final  SupabaseUser? user;
 final  List<Profile>? _profiles;
@override List<Profile>? get profiles {
  final value = _profiles;
  if (value == null) return null;
  if (_profiles is EqualUnmodifiableListView) return _profiles;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

@override final  int? profileCount;

/// Create a copy of AuthData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AuthDataCopyWith<_AuthData> get copyWith => __$AuthDataCopyWithImpl<_AuthData>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AuthDataToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AuthData&&(identical(other.session, session) || other.session == session)&&(identical(other.user, user) || other.user == user)&&const DeepCollectionEquality().equals(other._profiles, _profiles)&&(identical(other.profileCount, profileCount) || other.profileCount == profileCount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,session,user,const DeepCollectionEquality().hash(_profiles),profileCount);

@override
String toString() {
  return 'AuthData(session: $session, user: $user, profiles: $profiles, profileCount: $profileCount)';
}


}

/// @nodoc
abstract mixin class _$AuthDataCopyWith<$Res> implements $AuthDataCopyWith<$Res> {
  factory _$AuthDataCopyWith(_AuthData value, $Res Function(_AuthData) _then) = __$AuthDataCopyWithImpl;
@override @useResult
$Res call({
 SupabaseSession? session, SupabaseUser? user, List<Profile>? profiles, int? profileCount
});


@override $SupabaseSessionCopyWith<$Res>? get session;@override $SupabaseUserCopyWith<$Res>? get user;

}
/// @nodoc
class __$AuthDataCopyWithImpl<$Res>
    implements _$AuthDataCopyWith<$Res> {
  __$AuthDataCopyWithImpl(this._self, this._then);

  final _AuthData _self;
  final $Res Function(_AuthData) _then;

/// Create a copy of AuthData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? session = freezed,Object? user = freezed,Object? profiles = freezed,Object? profileCount = freezed,}) {
  return _then(_AuthData(
session: freezed == session ? _self.session : session // ignore: cast_nullable_to_non_nullable
as SupabaseSession?,user: freezed == user ? _self.user : user // ignore: cast_nullable_to_non_nullable
as SupabaseUser?,profiles: freezed == profiles ? _self._profiles : profiles // ignore: cast_nullable_to_non_nullable
as List<Profile>?,profileCount: freezed == profileCount ? _self.profileCount : profileCount // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

/// Create a copy of AuthData
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SupabaseSessionCopyWith<$Res>? get session {
    if (_self.session == null) {
    return null;
  }

  return $SupabaseSessionCopyWith<$Res>(_self.session!, (value) {
    return _then(_self.copyWith(session: value));
  });
}/// Create a copy of AuthData
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SupabaseUserCopyWith<$Res>? get user {
    if (_self.user == null) {
    return null;
  }

  return $SupabaseUserCopyWith<$Res>(_self.user!, (value) {
    return _then(_self.copyWith(user: value));
  });
}
}

// dart format on
