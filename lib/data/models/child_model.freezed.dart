// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'child_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ChildModel {

 String get id; String get name; String get lastName; String get age; List<String> get unlockedBadges; List<TitleModel> get titles; Map<String, ProgressionModel> get progression;
/// Create a copy of ChildModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChildModelCopyWith<ChildModel> get copyWith => _$ChildModelCopyWithImpl<ChildModel>(this as ChildModel, _$identity);

  /// Serializes this ChildModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChildModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.lastName, lastName) || other.lastName == lastName)&&(identical(other.age, age) || other.age == age)&&const DeepCollectionEquality().equals(other.unlockedBadges, unlockedBadges)&&const DeepCollectionEquality().equals(other.titles, titles)&&const DeepCollectionEquality().equals(other.progression, progression));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,lastName,age,const DeepCollectionEquality().hash(unlockedBadges),const DeepCollectionEquality().hash(titles),const DeepCollectionEquality().hash(progression));

@override
String toString() {
  return 'ChildModel(id: $id, name: $name, lastName: $lastName, age: $age, unlockedBadges: $unlockedBadges, titles: $titles, progression: $progression)';
}


}

/// @nodoc
abstract mixin class $ChildModelCopyWith<$Res>  {
  factory $ChildModelCopyWith(ChildModel value, $Res Function(ChildModel) _then) = _$ChildModelCopyWithImpl;
@useResult
$Res call({
 String id, String name, String lastName, String age, List<String> unlockedBadges, List<TitleModel> titles, Map<String, ProgressionModel> progression
});




}
/// @nodoc
class _$ChildModelCopyWithImpl<$Res>
    implements $ChildModelCopyWith<$Res> {
  _$ChildModelCopyWithImpl(this._self, this._then);

  final ChildModel _self;
  final $Res Function(ChildModel) _then;

/// Create a copy of ChildModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? lastName = null,Object? age = null,Object? unlockedBadges = null,Object? titles = null,Object? progression = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,lastName: null == lastName ? _self.lastName : lastName // ignore: cast_nullable_to_non_nullable
as String,age: null == age ? _self.age : age // ignore: cast_nullable_to_non_nullable
as String,unlockedBadges: null == unlockedBadges ? _self.unlockedBadges : unlockedBadges // ignore: cast_nullable_to_non_nullable
as List<String>,titles: null == titles ? _self.titles : titles // ignore: cast_nullable_to_non_nullable
as List<TitleModel>,progression: null == progression ? _self.progression : progression // ignore: cast_nullable_to_non_nullable
as Map<String, ProgressionModel>,
  ));
}

}


/// Adds pattern-matching-related methods to [ChildModel].
extension ChildModelPatterns on ChildModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ChildModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ChildModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ChildModel value)  $default,){
final _that = this;
switch (_that) {
case _ChildModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ChildModel value)?  $default,){
final _that = this;
switch (_that) {
case _ChildModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String lastName,  String age,  List<String> unlockedBadges,  List<TitleModel> titles,  Map<String, ProgressionModel> progression)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ChildModel() when $default != null:
return $default(_that.id,_that.name,_that.lastName,_that.age,_that.unlockedBadges,_that.titles,_that.progression);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String lastName,  String age,  List<String> unlockedBadges,  List<TitleModel> titles,  Map<String, ProgressionModel> progression)  $default,) {final _that = this;
switch (_that) {
case _ChildModel():
return $default(_that.id,_that.name,_that.lastName,_that.age,_that.unlockedBadges,_that.titles,_that.progression);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String lastName,  String age,  List<String> unlockedBadges,  List<TitleModel> titles,  Map<String, ProgressionModel> progression)?  $default,) {final _that = this;
switch (_that) {
case _ChildModel() when $default != null:
return $default(_that.id,_that.name,_that.lastName,_that.age,_that.unlockedBadges,_that.titles,_that.progression);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ChildModel implements ChildModel {
   _ChildModel({required this.id, required this.name, required this.lastName, required this.age, required final  List<String> unlockedBadges, required final  List<TitleModel> titles, required final  Map<String, ProgressionModel> progression}): _unlockedBadges = unlockedBadges,_titles = titles,_progression = progression;
  factory _ChildModel.fromJson(Map<String, dynamic> json) => _$ChildModelFromJson(json);

@override final  String id;
@override final  String name;
@override final  String lastName;
@override final  String age;
 final  List<String> _unlockedBadges;
@override List<String> get unlockedBadges {
  if (_unlockedBadges is EqualUnmodifiableListView) return _unlockedBadges;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_unlockedBadges);
}

 final  List<TitleModel> _titles;
@override List<TitleModel> get titles {
  if (_titles is EqualUnmodifiableListView) return _titles;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_titles);
}

 final  Map<String, ProgressionModel> _progression;
@override Map<String, ProgressionModel> get progression {
  if (_progression is EqualUnmodifiableMapView) return _progression;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_progression);
}


/// Create a copy of ChildModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ChildModelCopyWith<_ChildModel> get copyWith => __$ChildModelCopyWithImpl<_ChildModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ChildModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ChildModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.lastName, lastName) || other.lastName == lastName)&&(identical(other.age, age) || other.age == age)&&const DeepCollectionEquality().equals(other._unlockedBadges, _unlockedBadges)&&const DeepCollectionEquality().equals(other._titles, _titles)&&const DeepCollectionEquality().equals(other._progression, _progression));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,lastName,age,const DeepCollectionEquality().hash(_unlockedBadges),const DeepCollectionEquality().hash(_titles),const DeepCollectionEquality().hash(_progression));

@override
String toString() {
  return 'ChildModel(id: $id, name: $name, lastName: $lastName, age: $age, unlockedBadges: $unlockedBadges, titles: $titles, progression: $progression)';
}


}

/// @nodoc
abstract mixin class _$ChildModelCopyWith<$Res> implements $ChildModelCopyWith<$Res> {
  factory _$ChildModelCopyWith(_ChildModel value, $Res Function(_ChildModel) _then) = __$ChildModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String lastName, String age, List<String> unlockedBadges, List<TitleModel> titles, Map<String, ProgressionModel> progression
});




}
/// @nodoc
class __$ChildModelCopyWithImpl<$Res>
    implements _$ChildModelCopyWith<$Res> {
  __$ChildModelCopyWithImpl(this._self, this._then);

  final _ChildModel _self;
  final $Res Function(_ChildModel) _then;

/// Create a copy of ChildModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? lastName = null,Object? age = null,Object? unlockedBadges = null,Object? titles = null,Object? progression = null,}) {
  return _then(_ChildModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,lastName: null == lastName ? _self.lastName : lastName // ignore: cast_nullable_to_non_nullable
as String,age: null == age ? _self.age : age // ignore: cast_nullable_to_non_nullable
as String,unlockedBadges: null == unlockedBadges ? _self._unlockedBadges : unlockedBadges // ignore: cast_nullable_to_non_nullable
as List<String>,titles: null == titles ? _self._titles : titles // ignore: cast_nullable_to_non_nullable
as List<TitleModel>,progression: null == progression ? _self._progression : progression // ignore: cast_nullable_to_non_nullable
as Map<String, ProgressionModel>,
  ));
}


}

// dart format on
