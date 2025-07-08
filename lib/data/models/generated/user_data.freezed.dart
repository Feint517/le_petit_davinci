// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of '../user/user_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$UserData {

 int get id; String get name;@JsonKey(name: 'class') String get userClass; SubjectProgress get french; SubjectProgress get english; SubjectProgress get math;
/// Create a copy of UserData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserDataCopyWith<UserData> get copyWith => _$UserDataCopyWithImpl<UserData>(this as UserData, _$identity);

  /// Serializes this UserData to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserData&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.userClass, userClass) || other.userClass == userClass)&&(identical(other.french, french) || other.french == french)&&(identical(other.english, english) || other.english == english)&&(identical(other.math, math) || other.math == math));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,userClass,french,english,math);

@override
String toString() {
  return 'UserData(id: $id, name: $name, userClass: $userClass, french: $french, english: $english, math: $math)';
}


}

/// @nodoc
abstract mixin class $UserDataCopyWith<$Res>  {
  factory $UserDataCopyWith(UserData value, $Res Function(UserData) _then) = _$UserDataCopyWithImpl;
@useResult
$Res call({
 int id, String name,@JsonKey(name: 'class') String userClass, SubjectProgress french, SubjectProgress english, SubjectProgress math
});


$SubjectProgressCopyWith<$Res> get french;$SubjectProgressCopyWith<$Res> get english;$SubjectProgressCopyWith<$Res> get math;

}
/// @nodoc
class _$UserDataCopyWithImpl<$Res>
    implements $UserDataCopyWith<$Res> {
  _$UserDataCopyWithImpl(this._self, this._then);

  final UserData _self;
  final $Res Function(UserData) _then;

/// Create a copy of UserData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? userClass = null,Object? french = null,Object? english = null,Object? math = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,userClass: null == userClass ? _self.userClass : userClass // ignore: cast_nullable_to_non_nullable
as String,french: null == french ? _self.french : french // ignore: cast_nullable_to_non_nullable
as SubjectProgress,english: null == english ? _self.english : english // ignore: cast_nullable_to_non_nullable
as SubjectProgress,math: null == math ? _self.math : math // ignore: cast_nullable_to_non_nullable
as SubjectProgress,
  ));
}
/// Create a copy of UserData
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SubjectProgressCopyWith<$Res> get french {
  
  return $SubjectProgressCopyWith<$Res>(_self.french, (value) {
    return _then(_self.copyWith(french: value));
  });
}/// Create a copy of UserData
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SubjectProgressCopyWith<$Res> get english {
  
  return $SubjectProgressCopyWith<$Res>(_self.english, (value) {
    return _then(_self.copyWith(english: value));
  });
}/// Create a copy of UserData
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SubjectProgressCopyWith<$Res> get math {
  
  return $SubjectProgressCopyWith<$Res>(_self.math, (value) {
    return _then(_self.copyWith(math: value));
  });
}
}


/// Adds pattern-matching-related methods to [UserData].
extension UserDataPatterns on UserData {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UserData value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UserData() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UserData value)  $default,){
final _that = this;
switch (_that) {
case _UserData():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UserData value)?  $default,){
final _that = this;
switch (_that) {
case _UserData() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String name, @JsonKey(name: 'class')  String userClass,  SubjectProgress french,  SubjectProgress english,  SubjectProgress math)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UserData() when $default != null:
return $default(_that.id,_that.name,_that.userClass,_that.french,_that.english,_that.math);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String name, @JsonKey(name: 'class')  String userClass,  SubjectProgress french,  SubjectProgress english,  SubjectProgress math)  $default,) {final _that = this;
switch (_that) {
case _UserData():
return $default(_that.id,_that.name,_that.userClass,_that.french,_that.english,_that.math);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String name, @JsonKey(name: 'class')  String userClass,  SubjectProgress french,  SubjectProgress english,  SubjectProgress math)?  $default,) {final _that = this;
switch (_that) {
case _UserData() when $default != null:
return $default(_that.id,_that.name,_that.userClass,_that.french,_that.english,_that.math);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _UserData implements UserData {
   _UserData({required this.id, required this.name, @JsonKey(name: 'class') required this.userClass, required this.french, required this.english, required this.math});
  factory _UserData.fromJson(Map<String, dynamic> json) => _$UserDataFromJson(json);

@override final  int id;
@override final  String name;
@override@JsonKey(name: 'class') final  String userClass;
@override final  SubjectProgress french;
@override final  SubjectProgress english;
@override final  SubjectProgress math;

/// Create a copy of UserData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserDataCopyWith<_UserData> get copyWith => __$UserDataCopyWithImpl<_UserData>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UserDataToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserData&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.userClass, userClass) || other.userClass == userClass)&&(identical(other.french, french) || other.french == french)&&(identical(other.english, english) || other.english == english)&&(identical(other.math, math) || other.math == math));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,userClass,french,english,math);

@override
String toString() {
  return 'UserData(id: $id, name: $name, userClass: $userClass, french: $french, english: $english, math: $math)';
}


}

/// @nodoc
abstract mixin class _$UserDataCopyWith<$Res> implements $UserDataCopyWith<$Res> {
  factory _$UserDataCopyWith(_UserData value, $Res Function(_UserData) _then) = __$UserDataCopyWithImpl;
@override @useResult
$Res call({
 int id, String name,@JsonKey(name: 'class') String userClass, SubjectProgress french, SubjectProgress english, SubjectProgress math
});


@override $SubjectProgressCopyWith<$Res> get french;@override $SubjectProgressCopyWith<$Res> get english;@override $SubjectProgressCopyWith<$Res> get math;

}
/// @nodoc
class __$UserDataCopyWithImpl<$Res>
    implements _$UserDataCopyWith<$Res> {
  __$UserDataCopyWithImpl(this._self, this._then);

  final _UserData _self;
  final $Res Function(_UserData) _then;

/// Create a copy of UserData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? userClass = null,Object? french = null,Object? english = null,Object? math = null,}) {
  return _then(_UserData(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,userClass: null == userClass ? _self.userClass : userClass // ignore: cast_nullable_to_non_nullable
as String,french: null == french ? _self.french : french // ignore: cast_nullable_to_non_nullable
as SubjectProgress,english: null == english ? _self.english : english // ignore: cast_nullable_to_non_nullable
as SubjectProgress,math: null == math ? _self.math : math // ignore: cast_nullable_to_non_nullable
as SubjectProgress,
  ));
}

/// Create a copy of UserData
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SubjectProgressCopyWith<$Res> get french {
  
  return $SubjectProgressCopyWith<$Res>(_self.french, (value) {
    return _then(_self.copyWith(french: value));
  });
}/// Create a copy of UserData
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SubjectProgressCopyWith<$Res> get english {
  
  return $SubjectProgressCopyWith<$Res>(_self.english, (value) {
    return _then(_self.copyWith(english: value));
  });
}/// Create a copy of UserData
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SubjectProgressCopyWith<$Res> get math {
  
  return $SubjectProgressCopyWith<$Res>(_self.math, (value) {
    return _then(_self.copyWith(math: value));
  });
}
}

// dart format on
