// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of '../subject/subject_progress.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SubjectProgress {

 String get progress;@JsonKey(name: 'time_spent') String get timeSpent;
/// Create a copy of SubjectProgress
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SubjectProgressCopyWith<SubjectProgress> get copyWith => _$SubjectProgressCopyWithImpl<SubjectProgress>(this as SubjectProgress, _$identity);

  /// Serializes this SubjectProgress to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SubjectProgress&&(identical(other.progress, progress) || other.progress == progress)&&(identical(other.timeSpent, timeSpent) || other.timeSpent == timeSpent));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,progress,timeSpent);

@override
String toString() {
  return 'SubjectProgress(progress: $progress, timeSpent: $timeSpent)';
}


}

/// @nodoc
abstract mixin class $SubjectProgressCopyWith<$Res>  {
  factory $SubjectProgressCopyWith(SubjectProgress value, $Res Function(SubjectProgress) _then) = _$SubjectProgressCopyWithImpl;
@useResult
$Res call({
 String progress,@JsonKey(name: 'time_spent') String timeSpent
});




}
/// @nodoc
class _$SubjectProgressCopyWithImpl<$Res>
    implements $SubjectProgressCopyWith<$Res> {
  _$SubjectProgressCopyWithImpl(this._self, this._then);

  final SubjectProgress _self;
  final $Res Function(SubjectProgress) _then;

/// Create a copy of SubjectProgress
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? progress = null,Object? timeSpent = null,}) {
  return _then(_self.copyWith(
progress: null == progress ? _self.progress : progress // ignore: cast_nullable_to_non_nullable
as String,timeSpent: null == timeSpent ? _self.timeSpent : timeSpent // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [SubjectProgress].
extension SubjectProgressPatterns on SubjectProgress {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SubjectProgress value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SubjectProgress() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SubjectProgress value)  $default,){
final _that = this;
switch (_that) {
case _SubjectProgress():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SubjectProgress value)?  $default,){
final _that = this;
switch (_that) {
case _SubjectProgress() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String progress, @JsonKey(name: 'time_spent')  String timeSpent)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SubjectProgress() when $default != null:
return $default(_that.progress,_that.timeSpent);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String progress, @JsonKey(name: 'time_spent')  String timeSpent)  $default,) {final _that = this;
switch (_that) {
case _SubjectProgress():
return $default(_that.progress,_that.timeSpent);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String progress, @JsonKey(name: 'time_spent')  String timeSpent)?  $default,) {final _that = this;
switch (_that) {
case _SubjectProgress() when $default != null:
return $default(_that.progress,_that.timeSpent);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SubjectProgress implements SubjectProgress {
  const _SubjectProgress({required this.progress, @JsonKey(name: 'time_spent') required this.timeSpent});
  factory _SubjectProgress.fromJson(Map<String, dynamic> json) => _$SubjectProgressFromJson(json);

@override final  String progress;
@override@JsonKey(name: 'time_spent') final  String timeSpent;

/// Create a copy of SubjectProgress
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SubjectProgressCopyWith<_SubjectProgress> get copyWith => __$SubjectProgressCopyWithImpl<_SubjectProgress>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SubjectProgressToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SubjectProgress&&(identical(other.progress, progress) || other.progress == progress)&&(identical(other.timeSpent, timeSpent) || other.timeSpent == timeSpent));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,progress,timeSpent);

@override
String toString() {
  return 'SubjectProgress(progress: $progress, timeSpent: $timeSpent)';
}


}

/// @nodoc
abstract mixin class _$SubjectProgressCopyWith<$Res> implements $SubjectProgressCopyWith<$Res> {
  factory _$SubjectProgressCopyWith(_SubjectProgress value, $Res Function(_SubjectProgress) _then) = __$SubjectProgressCopyWithImpl;
@override @useResult
$Res call({
 String progress,@JsonKey(name: 'time_spent') String timeSpent
});




}
/// @nodoc
class __$SubjectProgressCopyWithImpl<$Res>
    implements _$SubjectProgressCopyWith<$Res> {
  __$SubjectProgressCopyWithImpl(this._self, this._then);

  final _SubjectProgress _self;
  final $Res Function(_SubjectProgress) _then;

/// Create a copy of SubjectProgress
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? progress = null,Object? timeSpent = null,}) {
  return _then(_SubjectProgress(
progress: null == progress ? _self.progress : progress // ignore: cast_nullable_to_non_nullable
as String,timeSpent: null == timeSpent ? _self.timeSpent : timeSpent // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
