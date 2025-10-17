// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'verification_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$VerificationResponse {

 bool get success; String get message; VerificationData? get data;
/// Create a copy of VerificationResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VerificationResponseCopyWith<VerificationResponse> get copyWith => _$VerificationResponseCopyWithImpl<VerificationResponse>(this as VerificationResponse, _$identity);

  /// Serializes this VerificationResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VerificationResponse&&(identical(other.success, success) || other.success == success)&&(identical(other.message, message) || other.message == message)&&(identical(other.data, data) || other.data == data));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,success,message,data);

@override
String toString() {
  return 'VerificationResponse(success: $success, message: $message, data: $data)';
}


}

/// @nodoc
abstract mixin class $VerificationResponseCopyWith<$Res>  {
  factory $VerificationResponseCopyWith(VerificationResponse value, $Res Function(VerificationResponse) _then) = _$VerificationResponseCopyWithImpl;
@useResult
$Res call({
 bool success, String message, VerificationData? data
});


$VerificationDataCopyWith<$Res>? get data;

}
/// @nodoc
class _$VerificationResponseCopyWithImpl<$Res>
    implements $VerificationResponseCopyWith<$Res> {
  _$VerificationResponseCopyWithImpl(this._self, this._then);

  final VerificationResponse _self;
  final $Res Function(VerificationResponse) _then;

/// Create a copy of VerificationResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? success = null,Object? message = null,Object? data = freezed,}) {
  return _then(_self.copyWith(
success: null == success ? _self.success : success // ignore: cast_nullable_to_non_nullable
as bool,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,data: freezed == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as VerificationData?,
  ));
}
/// Create a copy of VerificationResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$VerificationDataCopyWith<$Res>? get data {
    if (_self.data == null) {
    return null;
  }

  return $VerificationDataCopyWith<$Res>(_self.data!, (value) {
    return _then(_self.copyWith(data: value));
  });
}
}


/// Adds pattern-matching-related methods to [VerificationResponse].
extension VerificationResponsePatterns on VerificationResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _VerificationResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _VerificationResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _VerificationResponse value)  $default,){
final _that = this;
switch (_that) {
case _VerificationResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _VerificationResponse value)?  $default,){
final _that = this;
switch (_that) {
case _VerificationResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool success,  String message,  VerificationData? data)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _VerificationResponse() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool success,  String message,  VerificationData? data)  $default,) {final _that = this;
switch (_that) {
case _VerificationResponse():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool success,  String message,  VerificationData? data)?  $default,) {final _that = this;
switch (_that) {
case _VerificationResponse() when $default != null:
return $default(_that.success,_that.message,_that.data);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _VerificationResponse implements VerificationResponse {
  const _VerificationResponse({required this.success, required this.message, this.data});
  factory _VerificationResponse.fromJson(Map<String, dynamic> json) => _$VerificationResponseFromJson(json);

@override final  bool success;
@override final  String message;
@override final  VerificationData? data;

/// Create a copy of VerificationResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$VerificationResponseCopyWith<_VerificationResponse> get copyWith => __$VerificationResponseCopyWithImpl<_VerificationResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$VerificationResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _VerificationResponse&&(identical(other.success, success) || other.success == success)&&(identical(other.message, message) || other.message == message)&&(identical(other.data, data) || other.data == data));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,success,message,data);

@override
String toString() {
  return 'VerificationResponse(success: $success, message: $message, data: $data)';
}


}

/// @nodoc
abstract mixin class _$VerificationResponseCopyWith<$Res> implements $VerificationResponseCopyWith<$Res> {
  factory _$VerificationResponseCopyWith(_VerificationResponse value, $Res Function(_VerificationResponse) _then) = __$VerificationResponseCopyWithImpl;
@override @useResult
$Res call({
 bool success, String message, VerificationData? data
});


@override $VerificationDataCopyWith<$Res>? get data;

}
/// @nodoc
class __$VerificationResponseCopyWithImpl<$Res>
    implements _$VerificationResponseCopyWith<$Res> {
  __$VerificationResponseCopyWithImpl(this._self, this._then);

  final _VerificationResponse _self;
  final $Res Function(_VerificationResponse) _then;

/// Create a copy of VerificationResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? success = null,Object? message = null,Object? data = freezed,}) {
  return _then(_VerificationResponse(
success: null == success ? _self.success : success // ignore: cast_nullable_to_non_nullable
as bool,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,data: freezed == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as VerificationData?,
  ));
}

/// Create a copy of VerificationResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$VerificationDataCopyWith<$Res>? get data {
    if (_self.data == null) {
    return null;
  }

  return $VerificationDataCopyWith<$Res>(_self.data!, (value) {
    return _then(_self.copyWith(data: value));
  });
}
}


/// @nodoc
mixin _$VerificationData {

 String get email; bool get verified; SupabaseSession? get session;
/// Create a copy of VerificationData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VerificationDataCopyWith<VerificationData> get copyWith => _$VerificationDataCopyWithImpl<VerificationData>(this as VerificationData, _$identity);

  /// Serializes this VerificationData to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VerificationData&&(identical(other.email, email) || other.email == email)&&(identical(other.verified, verified) || other.verified == verified)&&(identical(other.session, session) || other.session == session));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,email,verified,session);

@override
String toString() {
  return 'VerificationData(email: $email, verified: $verified, session: $session)';
}


}

/// @nodoc
abstract mixin class $VerificationDataCopyWith<$Res>  {
  factory $VerificationDataCopyWith(VerificationData value, $Res Function(VerificationData) _then) = _$VerificationDataCopyWithImpl;
@useResult
$Res call({
 String email, bool verified, SupabaseSession? session
});


$SupabaseSessionCopyWith<$Res>? get session;

}
/// @nodoc
class _$VerificationDataCopyWithImpl<$Res>
    implements $VerificationDataCopyWith<$Res> {
  _$VerificationDataCopyWithImpl(this._self, this._then);

  final VerificationData _self;
  final $Res Function(VerificationData) _then;

/// Create a copy of VerificationData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? email = null,Object? verified = null,Object? session = freezed,}) {
  return _then(_self.copyWith(
email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,verified: null == verified ? _self.verified : verified // ignore: cast_nullable_to_non_nullable
as bool,session: freezed == session ? _self.session : session // ignore: cast_nullable_to_non_nullable
as SupabaseSession?,
  ));
}
/// Create a copy of VerificationData
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
}
}


/// Adds pattern-matching-related methods to [VerificationData].
extension VerificationDataPatterns on VerificationData {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _VerificationData value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _VerificationData() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _VerificationData value)  $default,){
final _that = this;
switch (_that) {
case _VerificationData():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _VerificationData value)?  $default,){
final _that = this;
switch (_that) {
case _VerificationData() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String email,  bool verified,  SupabaseSession? session)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _VerificationData() when $default != null:
return $default(_that.email,_that.verified,_that.session);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String email,  bool verified,  SupabaseSession? session)  $default,) {final _that = this;
switch (_that) {
case _VerificationData():
return $default(_that.email,_that.verified,_that.session);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String email,  bool verified,  SupabaseSession? session)?  $default,) {final _that = this;
switch (_that) {
case _VerificationData() when $default != null:
return $default(_that.email,_that.verified,_that.session);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _VerificationData implements VerificationData {
  const _VerificationData({required this.email, required this.verified, this.session});
  factory _VerificationData.fromJson(Map<String, dynamic> json) => _$VerificationDataFromJson(json);

@override final  String email;
@override final  bool verified;
@override final  SupabaseSession? session;

/// Create a copy of VerificationData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$VerificationDataCopyWith<_VerificationData> get copyWith => __$VerificationDataCopyWithImpl<_VerificationData>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$VerificationDataToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _VerificationData&&(identical(other.email, email) || other.email == email)&&(identical(other.verified, verified) || other.verified == verified)&&(identical(other.session, session) || other.session == session));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,email,verified,session);

@override
String toString() {
  return 'VerificationData(email: $email, verified: $verified, session: $session)';
}


}

/// @nodoc
abstract mixin class _$VerificationDataCopyWith<$Res> implements $VerificationDataCopyWith<$Res> {
  factory _$VerificationDataCopyWith(_VerificationData value, $Res Function(_VerificationData) _then) = __$VerificationDataCopyWithImpl;
@override @useResult
$Res call({
 String email, bool verified, SupabaseSession? session
});


@override $SupabaseSessionCopyWith<$Res>? get session;

}
/// @nodoc
class __$VerificationDataCopyWithImpl<$Res>
    implements _$VerificationDataCopyWith<$Res> {
  __$VerificationDataCopyWithImpl(this._self, this._then);

  final _VerificationData _self;
  final $Res Function(_VerificationData) _then;

/// Create a copy of VerificationData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? email = null,Object? verified = null,Object? session = freezed,}) {
  return _then(_VerificationData(
email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,verified: null == verified ? _self.verified : verified // ignore: cast_nullable_to_non_nullable
as bool,session: freezed == session ? _self.session : session // ignore: cast_nullable_to_non_nullable
as SupabaseSession?,
  ));
}

/// Create a copy of VerificationData
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
}
}

// dart format on
