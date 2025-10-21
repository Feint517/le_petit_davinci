// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'supabase_user.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SupabaseUser {

 String get id; String get email; String? get phone;@JsonKey(name: 'user_metadata') Map<String, dynamic>? get userMetadata;@JsonKey(name: 'app_metadata') Map<String, dynamic>? get appMetadata;@JsonKey(name: 'email_confirmed_at') String? get emailConfirmedAt;@JsonKey(name: 'phone_confirmed_at') String? get phoneConfirmedAt;@JsonKey(name: 'created_at') String? get createdAt;@JsonKey(name: 'updated_at') String? get updatedAt;
/// Create a copy of SupabaseUser
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SupabaseUserCopyWith<SupabaseUser> get copyWith => _$SupabaseUserCopyWithImpl<SupabaseUser>(this as SupabaseUser, _$identity);

  /// Serializes this SupabaseUser to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SupabaseUser&&(identical(other.id, id) || other.id == id)&&(identical(other.email, email) || other.email == email)&&(identical(other.phone, phone) || other.phone == phone)&&const DeepCollectionEquality().equals(other.userMetadata, userMetadata)&&const DeepCollectionEquality().equals(other.appMetadata, appMetadata)&&(identical(other.emailConfirmedAt, emailConfirmedAt) || other.emailConfirmedAt == emailConfirmedAt)&&(identical(other.phoneConfirmedAt, phoneConfirmedAt) || other.phoneConfirmedAt == phoneConfirmedAt)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,email,phone,const DeepCollectionEquality().hash(userMetadata),const DeepCollectionEquality().hash(appMetadata),emailConfirmedAt,phoneConfirmedAt,createdAt,updatedAt);

@override
String toString() {
  return 'SupabaseUser(id: $id, email: $email, phone: $phone, userMetadata: $userMetadata, appMetadata: $appMetadata, emailConfirmedAt: $emailConfirmedAt, phoneConfirmedAt: $phoneConfirmedAt, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $SupabaseUserCopyWith<$Res>  {
  factory $SupabaseUserCopyWith(SupabaseUser value, $Res Function(SupabaseUser) _then) = _$SupabaseUserCopyWithImpl;
@useResult
$Res call({
 String id, String email, String? phone,@JsonKey(name: 'user_metadata') Map<String, dynamic>? userMetadata,@JsonKey(name: 'app_metadata') Map<String, dynamic>? appMetadata,@JsonKey(name: 'email_confirmed_at') String? emailConfirmedAt,@JsonKey(name: 'phone_confirmed_at') String? phoneConfirmedAt,@JsonKey(name: 'created_at') String? createdAt,@JsonKey(name: 'updated_at') String? updatedAt
});




}
/// @nodoc
class _$SupabaseUserCopyWithImpl<$Res>
    implements $SupabaseUserCopyWith<$Res> {
  _$SupabaseUserCopyWithImpl(this._self, this._then);

  final SupabaseUser _self;
  final $Res Function(SupabaseUser) _then;

/// Create a copy of SupabaseUser
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? email = null,Object? phone = freezed,Object? userMetadata = freezed,Object? appMetadata = freezed,Object? emailConfirmedAt = freezed,Object? phoneConfirmedAt = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,phone: freezed == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String?,userMetadata: freezed == userMetadata ? _self.userMetadata : userMetadata // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,appMetadata: freezed == appMetadata ? _self.appMetadata : appMetadata // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,emailConfirmedAt: freezed == emailConfirmedAt ? _self.emailConfirmedAt : emailConfirmedAt // ignore: cast_nullable_to_non_nullable
as String?,phoneConfirmedAt: freezed == phoneConfirmedAt ? _self.phoneConfirmedAt : phoneConfirmedAt // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [SupabaseUser].
extension SupabaseUserPatterns on SupabaseUser {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SupabaseUser value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SupabaseUser() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SupabaseUser value)  $default,){
final _that = this;
switch (_that) {
case _SupabaseUser():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SupabaseUser value)?  $default,){
final _that = this;
switch (_that) {
case _SupabaseUser() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String email,  String? phone, @JsonKey(name: 'user_metadata')  Map<String, dynamic>? userMetadata, @JsonKey(name: 'app_metadata')  Map<String, dynamic>? appMetadata, @JsonKey(name: 'email_confirmed_at')  String? emailConfirmedAt, @JsonKey(name: 'phone_confirmed_at')  String? phoneConfirmedAt, @JsonKey(name: 'created_at')  String? createdAt, @JsonKey(name: 'updated_at')  String? updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SupabaseUser() when $default != null:
return $default(_that.id,_that.email,_that.phone,_that.userMetadata,_that.appMetadata,_that.emailConfirmedAt,_that.phoneConfirmedAt,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String email,  String? phone, @JsonKey(name: 'user_metadata')  Map<String, dynamic>? userMetadata, @JsonKey(name: 'app_metadata')  Map<String, dynamic>? appMetadata, @JsonKey(name: 'email_confirmed_at')  String? emailConfirmedAt, @JsonKey(name: 'phone_confirmed_at')  String? phoneConfirmedAt, @JsonKey(name: 'created_at')  String? createdAt, @JsonKey(name: 'updated_at')  String? updatedAt)  $default,) {final _that = this;
switch (_that) {
case _SupabaseUser():
return $default(_that.id,_that.email,_that.phone,_that.userMetadata,_that.appMetadata,_that.emailConfirmedAt,_that.phoneConfirmedAt,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String email,  String? phone, @JsonKey(name: 'user_metadata')  Map<String, dynamic>? userMetadata, @JsonKey(name: 'app_metadata')  Map<String, dynamic>? appMetadata, @JsonKey(name: 'email_confirmed_at')  String? emailConfirmedAt, @JsonKey(name: 'phone_confirmed_at')  String? phoneConfirmedAt, @JsonKey(name: 'created_at')  String? createdAt, @JsonKey(name: 'updated_at')  String? updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _SupabaseUser() when $default != null:
return $default(_that.id,_that.email,_that.phone,_that.userMetadata,_that.appMetadata,_that.emailConfirmedAt,_that.phoneConfirmedAt,_that.createdAt,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SupabaseUser implements SupabaseUser {
  const _SupabaseUser({required this.id, required this.email, this.phone, @JsonKey(name: 'user_metadata') final  Map<String, dynamic>? userMetadata, @JsonKey(name: 'app_metadata') final  Map<String, dynamic>? appMetadata, @JsonKey(name: 'email_confirmed_at') this.emailConfirmedAt, @JsonKey(name: 'phone_confirmed_at') this.phoneConfirmedAt, @JsonKey(name: 'created_at') this.createdAt, @JsonKey(name: 'updated_at') this.updatedAt}): _userMetadata = userMetadata,_appMetadata = appMetadata;
  factory _SupabaseUser.fromJson(Map<String, dynamic> json) => _$SupabaseUserFromJson(json);

@override final  String id;
@override final  String email;
@override final  String? phone;
 final  Map<String, dynamic>? _userMetadata;
@override@JsonKey(name: 'user_metadata') Map<String, dynamic>? get userMetadata {
  final value = _userMetadata;
  if (value == null) return null;
  if (_userMetadata is EqualUnmodifiableMapView) return _userMetadata;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}

 final  Map<String, dynamic>? _appMetadata;
@override@JsonKey(name: 'app_metadata') Map<String, dynamic>? get appMetadata {
  final value = _appMetadata;
  if (value == null) return null;
  if (_appMetadata is EqualUnmodifiableMapView) return _appMetadata;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}

@override@JsonKey(name: 'email_confirmed_at') final  String? emailConfirmedAt;
@override@JsonKey(name: 'phone_confirmed_at') final  String? phoneConfirmedAt;
@override@JsonKey(name: 'created_at') final  String? createdAt;
@override@JsonKey(name: 'updated_at') final  String? updatedAt;

/// Create a copy of SupabaseUser
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SupabaseUserCopyWith<_SupabaseUser> get copyWith => __$SupabaseUserCopyWithImpl<_SupabaseUser>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SupabaseUserToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SupabaseUser&&(identical(other.id, id) || other.id == id)&&(identical(other.email, email) || other.email == email)&&(identical(other.phone, phone) || other.phone == phone)&&const DeepCollectionEquality().equals(other._userMetadata, _userMetadata)&&const DeepCollectionEquality().equals(other._appMetadata, _appMetadata)&&(identical(other.emailConfirmedAt, emailConfirmedAt) || other.emailConfirmedAt == emailConfirmedAt)&&(identical(other.phoneConfirmedAt, phoneConfirmedAt) || other.phoneConfirmedAt == phoneConfirmedAt)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,email,phone,const DeepCollectionEquality().hash(_userMetadata),const DeepCollectionEquality().hash(_appMetadata),emailConfirmedAt,phoneConfirmedAt,createdAt,updatedAt);

@override
String toString() {
  return 'SupabaseUser(id: $id, email: $email, phone: $phone, userMetadata: $userMetadata, appMetadata: $appMetadata, emailConfirmedAt: $emailConfirmedAt, phoneConfirmedAt: $phoneConfirmedAt, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$SupabaseUserCopyWith<$Res> implements $SupabaseUserCopyWith<$Res> {
  factory _$SupabaseUserCopyWith(_SupabaseUser value, $Res Function(_SupabaseUser) _then) = __$SupabaseUserCopyWithImpl;
@override @useResult
$Res call({
 String id, String email, String? phone,@JsonKey(name: 'user_metadata') Map<String, dynamic>? userMetadata,@JsonKey(name: 'app_metadata') Map<String, dynamic>? appMetadata,@JsonKey(name: 'email_confirmed_at') String? emailConfirmedAt,@JsonKey(name: 'phone_confirmed_at') String? phoneConfirmedAt,@JsonKey(name: 'created_at') String? createdAt,@JsonKey(name: 'updated_at') String? updatedAt
});




}
/// @nodoc
class __$SupabaseUserCopyWithImpl<$Res>
    implements _$SupabaseUserCopyWith<$Res> {
  __$SupabaseUserCopyWithImpl(this._self, this._then);

  final _SupabaseUser _self;
  final $Res Function(_SupabaseUser) _then;

/// Create a copy of SupabaseUser
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? email = null,Object? phone = freezed,Object? userMetadata = freezed,Object? appMetadata = freezed,Object? emailConfirmedAt = freezed,Object? phoneConfirmedAt = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,}) {
  return _then(_SupabaseUser(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,phone: freezed == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String?,userMetadata: freezed == userMetadata ? _self._userMetadata : userMetadata // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,appMetadata: freezed == appMetadata ? _self._appMetadata : appMetadata // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,emailConfirmedAt: freezed == emailConfirmedAt ? _self.emailConfirmedAt : emailConfirmedAt // ignore: cast_nullable_to_non_nullable
as String?,phoneConfirmedAt: freezed == phoneConfirmedAt ? _self.phoneConfirmedAt : phoneConfirmedAt // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
