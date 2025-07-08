// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'fetch_user_data_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$FetchUserDataRequest {

 String get id;
/// Create a copy of FetchUserDataRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FetchUserDataRequestCopyWith<FetchUserDataRequest> get copyWith => _$FetchUserDataRequestCopyWithImpl<FetchUserDataRequest>(this as FetchUserDataRequest, _$identity);

  /// Serializes this FetchUserDataRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FetchUserDataRequest&&(identical(other.id, id) || other.id == id));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id);

@override
String toString() {
  return 'FetchUserDataRequest(id: $id)';
}


}

/// @nodoc
abstract mixin class $FetchUserDataRequestCopyWith<$Res>  {
  factory $FetchUserDataRequestCopyWith(FetchUserDataRequest value, $Res Function(FetchUserDataRequest) _then) = _$FetchUserDataRequestCopyWithImpl;
@useResult
$Res call({
 String id
});




}
/// @nodoc
class _$FetchUserDataRequestCopyWithImpl<$Res>
    implements $FetchUserDataRequestCopyWith<$Res> {
  _$FetchUserDataRequestCopyWithImpl(this._self, this._then);

  final FetchUserDataRequest _self;
  final $Res Function(FetchUserDataRequest) _then;

/// Create a copy of FetchUserDataRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [FetchUserDataRequest].
extension FetchUserDataRequestPatterns on FetchUserDataRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FetchUserDataRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FetchUserDataRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FetchUserDataRequest value)  $default,){
final _that = this;
switch (_that) {
case _FetchUserDataRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FetchUserDataRequest value)?  $default,){
final _that = this;
switch (_that) {
case _FetchUserDataRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FetchUserDataRequest() when $default != null:
return $default(_that.id);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id)  $default,) {final _that = this;
switch (_that) {
case _FetchUserDataRequest():
return $default(_that.id);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id)?  $default,) {final _that = this;
switch (_that) {
case _FetchUserDataRequest() when $default != null:
return $default(_that.id);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _FetchUserDataRequest implements FetchUserDataRequest {
  const _FetchUserDataRequest({required this.id});
  factory _FetchUserDataRequest.fromJson(Map<String, dynamic> json) => _$FetchUserDataRequestFromJson(json);

@override final  String id;

/// Create a copy of FetchUserDataRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FetchUserDataRequestCopyWith<_FetchUserDataRequest> get copyWith => __$FetchUserDataRequestCopyWithImpl<_FetchUserDataRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FetchUserDataRequestToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FetchUserDataRequest&&(identical(other.id, id) || other.id == id));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id);

@override
String toString() {
  return 'FetchUserDataRequest(id: $id)';
}


}

/// @nodoc
abstract mixin class _$FetchUserDataRequestCopyWith<$Res> implements $FetchUserDataRequestCopyWith<$Res> {
  factory _$FetchUserDataRequestCopyWith(_FetchUserDataRequest value, $Res Function(_FetchUserDataRequest) _then) = __$FetchUserDataRequestCopyWithImpl;
@override @useResult
$Res call({
 String id
});




}
/// @nodoc
class __$FetchUserDataRequestCopyWithImpl<$Res>
    implements _$FetchUserDataRequestCopyWith<$Res> {
  __$FetchUserDataRequestCopyWithImpl(this._self, this._then);

  final _FetchUserDataRequest _self;
  final $Res Function(_FetchUserDataRequest) _then;

/// Create a copy of FetchUserDataRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,}) {
  return _then(_FetchUserDataRequest(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
