// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'refresh_token_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$RefreshTokenResponse {

 bool get success; String get message; RefreshTokenData? get data;
/// Create a copy of RefreshTokenResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RefreshTokenResponseCopyWith<RefreshTokenResponse> get copyWith => _$RefreshTokenResponseCopyWithImpl<RefreshTokenResponse>(this as RefreshTokenResponse, _$identity);

  /// Serializes this RefreshTokenResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RefreshTokenResponse&&(identical(other.success, success) || other.success == success)&&(identical(other.message, message) || other.message == message)&&(identical(other.data, data) || other.data == data));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,success,message,data);

@override
String toString() {
  return 'RefreshTokenResponse(success: $success, message: $message, data: $data)';
}


}

/// @nodoc
abstract mixin class $RefreshTokenResponseCopyWith<$Res>  {
  factory $RefreshTokenResponseCopyWith(RefreshTokenResponse value, $Res Function(RefreshTokenResponse) _then) = _$RefreshTokenResponseCopyWithImpl;
@useResult
$Res call({
 bool success, String message, RefreshTokenData? data
});


$RefreshTokenDataCopyWith<$Res>? get data;

}
/// @nodoc
class _$RefreshTokenResponseCopyWithImpl<$Res>
    implements $RefreshTokenResponseCopyWith<$Res> {
  _$RefreshTokenResponseCopyWithImpl(this._self, this._then);

  final RefreshTokenResponse _self;
  final $Res Function(RefreshTokenResponse) _then;

/// Create a copy of RefreshTokenResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? success = null,Object? message = null,Object? data = freezed,}) {
  return _then(_self.copyWith(
success: null == success ? _self.success : success // ignore: cast_nullable_to_non_nullable
as bool,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,data: freezed == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as RefreshTokenData?,
  ));
}
/// Create a copy of RefreshTokenResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RefreshTokenDataCopyWith<$Res>? get data {
    if (_self.data == null) {
    return null;
  }

  return $RefreshTokenDataCopyWith<$Res>(_self.data!, (value) {
    return _then(_self.copyWith(data: value));
  });
}
}


/// Adds pattern-matching-related methods to [RefreshTokenResponse].
extension RefreshTokenResponsePatterns on RefreshTokenResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RefreshTokenResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RefreshTokenResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RefreshTokenResponse value)  $default,){
final _that = this;
switch (_that) {
case _RefreshTokenResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RefreshTokenResponse value)?  $default,){
final _that = this;
switch (_that) {
case _RefreshTokenResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool success,  String message,  RefreshTokenData? data)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RefreshTokenResponse() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool success,  String message,  RefreshTokenData? data)  $default,) {final _that = this;
switch (_that) {
case _RefreshTokenResponse():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool success,  String message,  RefreshTokenData? data)?  $default,) {final _that = this;
switch (_that) {
case _RefreshTokenResponse() when $default != null:
return $default(_that.success,_that.message,_that.data);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _RefreshTokenResponse implements RefreshTokenResponse {
  const _RefreshTokenResponse({required this.success, required this.message, this.data});
  factory _RefreshTokenResponse.fromJson(Map<String, dynamic> json) => _$RefreshTokenResponseFromJson(json);

@override final  bool success;
@override final  String message;
@override final  RefreshTokenData? data;

/// Create a copy of RefreshTokenResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RefreshTokenResponseCopyWith<_RefreshTokenResponse> get copyWith => __$RefreshTokenResponseCopyWithImpl<_RefreshTokenResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RefreshTokenResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RefreshTokenResponse&&(identical(other.success, success) || other.success == success)&&(identical(other.message, message) || other.message == message)&&(identical(other.data, data) || other.data == data));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,success,message,data);

@override
String toString() {
  return 'RefreshTokenResponse(success: $success, message: $message, data: $data)';
}


}

/// @nodoc
abstract mixin class _$RefreshTokenResponseCopyWith<$Res> implements $RefreshTokenResponseCopyWith<$Res> {
  factory _$RefreshTokenResponseCopyWith(_RefreshTokenResponse value, $Res Function(_RefreshTokenResponse) _then) = __$RefreshTokenResponseCopyWithImpl;
@override @useResult
$Res call({
 bool success, String message, RefreshTokenData? data
});


@override $RefreshTokenDataCopyWith<$Res>? get data;

}
/// @nodoc
class __$RefreshTokenResponseCopyWithImpl<$Res>
    implements _$RefreshTokenResponseCopyWith<$Res> {
  __$RefreshTokenResponseCopyWithImpl(this._self, this._then);

  final _RefreshTokenResponse _self;
  final $Res Function(_RefreshTokenResponse) _then;

/// Create a copy of RefreshTokenResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? success = null,Object? message = null,Object? data = freezed,}) {
  return _then(_RefreshTokenResponse(
success: null == success ? _self.success : success // ignore: cast_nullable_to_non_nullable
as bool,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,data: freezed == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as RefreshTokenData?,
  ));
}

/// Create a copy of RefreshTokenResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RefreshTokenDataCopyWith<$Res>? get data {
    if (_self.data == null) {
    return null;
  }

  return $RefreshTokenDataCopyWith<$Res>(_self.data!, (value) {
    return _then(_self.copyWith(data: value));
  });
}
}


/// @nodoc
mixin _$RefreshTokenData {

 SupabaseSession get session;
/// Create a copy of RefreshTokenData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RefreshTokenDataCopyWith<RefreshTokenData> get copyWith => _$RefreshTokenDataCopyWithImpl<RefreshTokenData>(this as RefreshTokenData, _$identity);

  /// Serializes this RefreshTokenData to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RefreshTokenData&&(identical(other.session, session) || other.session == session));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,session);

@override
String toString() {
  return 'RefreshTokenData(session: $session)';
}


}

/// @nodoc
abstract mixin class $RefreshTokenDataCopyWith<$Res>  {
  factory $RefreshTokenDataCopyWith(RefreshTokenData value, $Res Function(RefreshTokenData) _then) = _$RefreshTokenDataCopyWithImpl;
@useResult
$Res call({
 SupabaseSession session
});


$SupabaseSessionCopyWith<$Res> get session;

}
/// @nodoc
class _$RefreshTokenDataCopyWithImpl<$Res>
    implements $RefreshTokenDataCopyWith<$Res> {
  _$RefreshTokenDataCopyWithImpl(this._self, this._then);

  final RefreshTokenData _self;
  final $Res Function(RefreshTokenData) _then;

/// Create a copy of RefreshTokenData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? session = null,}) {
  return _then(_self.copyWith(
session: null == session ? _self.session : session // ignore: cast_nullable_to_non_nullable
as SupabaseSession,
  ));
}
/// Create a copy of RefreshTokenData
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SupabaseSessionCopyWith<$Res> get session {
  
  return $SupabaseSessionCopyWith<$Res>(_self.session, (value) {
    return _then(_self.copyWith(session: value));
  });
}
}


/// Adds pattern-matching-related methods to [RefreshTokenData].
extension RefreshTokenDataPatterns on RefreshTokenData {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RefreshTokenData value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RefreshTokenData() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RefreshTokenData value)  $default,){
final _that = this;
switch (_that) {
case _RefreshTokenData():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RefreshTokenData value)?  $default,){
final _that = this;
switch (_that) {
case _RefreshTokenData() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( SupabaseSession session)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RefreshTokenData() when $default != null:
return $default(_that.session);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( SupabaseSession session)  $default,) {final _that = this;
switch (_that) {
case _RefreshTokenData():
return $default(_that.session);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( SupabaseSession session)?  $default,) {final _that = this;
switch (_that) {
case _RefreshTokenData() when $default != null:
return $default(_that.session);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _RefreshTokenData implements RefreshTokenData {
  const _RefreshTokenData({required this.session});
  factory _RefreshTokenData.fromJson(Map<String, dynamic> json) => _$RefreshTokenDataFromJson(json);

@override final  SupabaseSession session;

/// Create a copy of RefreshTokenData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RefreshTokenDataCopyWith<_RefreshTokenData> get copyWith => __$RefreshTokenDataCopyWithImpl<_RefreshTokenData>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RefreshTokenDataToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RefreshTokenData&&(identical(other.session, session) || other.session == session));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,session);

@override
String toString() {
  return 'RefreshTokenData(session: $session)';
}


}

/// @nodoc
abstract mixin class _$RefreshTokenDataCopyWith<$Res> implements $RefreshTokenDataCopyWith<$Res> {
  factory _$RefreshTokenDataCopyWith(_RefreshTokenData value, $Res Function(_RefreshTokenData) _then) = __$RefreshTokenDataCopyWithImpl;
@override @useResult
$Res call({
 SupabaseSession session
});


@override $SupabaseSessionCopyWith<$Res> get session;

}
/// @nodoc
class __$RefreshTokenDataCopyWithImpl<$Res>
    implements _$RefreshTokenDataCopyWith<$Res> {
  __$RefreshTokenDataCopyWithImpl(this._self, this._then);

  final _RefreshTokenData _self;
  final $Res Function(_RefreshTokenData) _then;

/// Create a copy of RefreshTokenData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? session = null,}) {
  return _then(_RefreshTokenData(
session: null == session ? _self.session : session // ignore: cast_nullable_to_non_nullable
as SupabaseSession,
  ));
}

/// Create a copy of RefreshTokenData
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SupabaseSessionCopyWith<$Res> get session {
  
  return $SupabaseSessionCopyWith<$Res>(_self.session, (value) {
    return _then(_self.copyWith(session: value));
  });
}
}

// dart format on
