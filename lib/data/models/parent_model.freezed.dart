// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'parent_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ParentModel {

 String get id; String get firstName; String get lastName; String get email; List<ChildModel> get children;
/// Create a copy of ParentModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ParentModelCopyWith<ParentModel> get copyWith => _$ParentModelCopyWithImpl<ParentModel>(this as ParentModel, _$identity);

  /// Serializes this ParentModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ParentModel&&(identical(other.id, id) || other.id == id)&&(identical(other.firstName, firstName) || other.firstName == firstName)&&(identical(other.lastName, lastName) || other.lastName == lastName)&&(identical(other.email, email) || other.email == email)&&const DeepCollectionEquality().equals(other.children, children));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,firstName,lastName,email,const DeepCollectionEquality().hash(children));

@override
String toString() {
  return 'ParentModel(id: $id, firstName: $firstName, lastName: $lastName, email: $email, children: $children)';
}


}

/// @nodoc
abstract mixin class $ParentModelCopyWith<$Res>  {
  factory $ParentModelCopyWith(ParentModel value, $Res Function(ParentModel) _then) = _$ParentModelCopyWithImpl;
@useResult
$Res call({
 String id, String firstName, String lastName, String email, List<ChildModel> children
});




}
/// @nodoc
class _$ParentModelCopyWithImpl<$Res>
    implements $ParentModelCopyWith<$Res> {
  _$ParentModelCopyWithImpl(this._self, this._then);

  final ParentModel _self;
  final $Res Function(ParentModel) _then;

/// Create a copy of ParentModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? firstName = null,Object? lastName = null,Object? email = null,Object? children = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,firstName: null == firstName ? _self.firstName : firstName // ignore: cast_nullable_to_non_nullable
as String,lastName: null == lastName ? _self.lastName : lastName // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,children: null == children ? _self.children : children // ignore: cast_nullable_to_non_nullable
as List<ChildModel>,
  ));
}

}


/// Adds pattern-matching-related methods to [ParentModel].
extension ParentModelPatterns on ParentModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ParentModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ParentModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ParentModel value)  $default,){
final _that = this;
switch (_that) {
case _ParentModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ParentModel value)?  $default,){
final _that = this;
switch (_that) {
case _ParentModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String firstName,  String lastName,  String email,  List<ChildModel> children)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ParentModel() when $default != null:
return $default(_that.id,_that.firstName,_that.lastName,_that.email,_that.children);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String firstName,  String lastName,  String email,  List<ChildModel> children)  $default,) {final _that = this;
switch (_that) {
case _ParentModel():
return $default(_that.id,_that.firstName,_that.lastName,_that.email,_that.children);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String firstName,  String lastName,  String email,  List<ChildModel> children)?  $default,) {final _that = this;
switch (_that) {
case _ParentModel() when $default != null:
return $default(_that.id,_that.firstName,_that.lastName,_that.email,_that.children);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ParentModel implements ParentModel {
   _ParentModel({required this.id, required this.firstName, required this.lastName, required this.email, required final  List<ChildModel> children}): _children = children;
  factory _ParentModel.fromJson(Map<String, dynamic> json) => _$ParentModelFromJson(json);

@override final  String id;
@override final  String firstName;
@override final  String lastName;
@override final  String email;
 final  List<ChildModel> _children;
@override List<ChildModel> get children {
  if (_children is EqualUnmodifiableListView) return _children;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_children);
}


/// Create a copy of ParentModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ParentModelCopyWith<_ParentModel> get copyWith => __$ParentModelCopyWithImpl<_ParentModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ParentModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ParentModel&&(identical(other.id, id) || other.id == id)&&(identical(other.firstName, firstName) || other.firstName == firstName)&&(identical(other.lastName, lastName) || other.lastName == lastName)&&(identical(other.email, email) || other.email == email)&&const DeepCollectionEquality().equals(other._children, _children));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,firstName,lastName,email,const DeepCollectionEquality().hash(_children));

@override
String toString() {
  return 'ParentModel(id: $id, firstName: $firstName, lastName: $lastName, email: $email, children: $children)';
}


}

/// @nodoc
abstract mixin class _$ParentModelCopyWith<$Res> implements $ParentModelCopyWith<$Res> {
  factory _$ParentModelCopyWith(_ParentModel value, $Res Function(_ParentModel) _then) = __$ParentModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String firstName, String lastName, String email, List<ChildModel> children
});




}
/// @nodoc
class __$ParentModelCopyWithImpl<$Res>
    implements _$ParentModelCopyWith<$Res> {
  __$ParentModelCopyWithImpl(this._self, this._then);

  final _ParentModel _self;
  final $Res Function(_ParentModel) _then;

/// Create a copy of ParentModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? firstName = null,Object? lastName = null,Object? email = null,Object? children = null,}) {
  return _then(_ParentModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,firstName: null == firstName ? _self.firstName : firstName // ignore: cast_nullable_to_non_nullable
as String,lastName: null == lastName ? _self.lastName : lastName // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,children: null == children ? _self._children : children // ignore: cast_nullable_to_non_nullable
as List<ChildModel>,
  ));
}


}

// dart format on
