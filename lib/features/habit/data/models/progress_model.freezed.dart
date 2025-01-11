// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'progress_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ProgressModel _$ProgressModelFromJson(Map<String, dynamic> json) {
  return _ProgressModel.fromJson(json);
}

/// @nodoc
mixin _$ProgressModel {
  int get habitId => throw _privateConstructorUsedError; // Unique ID
  DateTime get date => throw _privateConstructorUsedError;
  bool get completed => throw _privateConstructorUsedError;
  bool get synced => throw _privateConstructorUsedError;
  String get uid => throw _privateConstructorUsedError; // User ID
  String get email => throw _privateConstructorUsedError;

  /// Serializes this ProgressModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ProgressModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ProgressModelCopyWith<ProgressModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProgressModelCopyWith<$Res> {
  factory $ProgressModelCopyWith(
          ProgressModel value, $Res Function(ProgressModel) then) =
      _$ProgressModelCopyWithImpl<$Res, ProgressModel>;
  @useResult
  $Res call(
      {int habitId,
      DateTime date,
      bool completed,
      bool synced,
      String uid,
      String email});
}

/// @nodoc
class _$ProgressModelCopyWithImpl<$Res, $Val extends ProgressModel>
    implements $ProgressModelCopyWith<$Res> {
  _$ProgressModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ProgressModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? habitId = null,
    Object? date = null,
    Object? completed = null,
    Object? synced = null,
    Object? uid = null,
    Object? email = null,
  }) {
    return _then(_value.copyWith(
      habitId: null == habitId
          ? _value.habitId
          : habitId // ignore: cast_nullable_to_non_nullable
              as int,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      completed: null == completed
          ? _value.completed
          : completed // ignore: cast_nullable_to_non_nullable
              as bool,
      synced: null == synced
          ? _value.synced
          : synced // ignore: cast_nullable_to_non_nullable
              as bool,
      uid: null == uid
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ProgressModelImplCopyWith<$Res>
    implements $ProgressModelCopyWith<$Res> {
  factory _$$ProgressModelImplCopyWith(
          _$ProgressModelImpl value, $Res Function(_$ProgressModelImpl) then) =
      __$$ProgressModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int habitId,
      DateTime date,
      bool completed,
      bool synced,
      String uid,
      String email});
}

/// @nodoc
class __$$ProgressModelImplCopyWithImpl<$Res>
    extends _$ProgressModelCopyWithImpl<$Res, _$ProgressModelImpl>
    implements _$$ProgressModelImplCopyWith<$Res> {
  __$$ProgressModelImplCopyWithImpl(
      _$ProgressModelImpl _value, $Res Function(_$ProgressModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of ProgressModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? habitId = null,
    Object? date = null,
    Object? completed = null,
    Object? synced = null,
    Object? uid = null,
    Object? email = null,
  }) {
    return _then(_$ProgressModelImpl(
      habitId: null == habitId
          ? _value.habitId
          : habitId // ignore: cast_nullable_to_non_nullable
              as int,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      completed: null == completed
          ? _value.completed
          : completed // ignore: cast_nullable_to_non_nullable
              as bool,
      synced: null == synced
          ? _value.synced
          : synced // ignore: cast_nullable_to_non_nullable
              as bool,
      uid: null == uid
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ProgressModelImpl implements _ProgressModel {
  const _$ProgressModelImpl(
      {required this.habitId,
      required this.date,
      required this.completed,
      required this.synced,
      required this.uid,
      required this.email});

  factory _$ProgressModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$ProgressModelImplFromJson(json);

  @override
  final int habitId;
// Unique ID
  @override
  final DateTime date;
  @override
  final bool completed;
  @override
  final bool synced;
  @override
  final String uid;
// User ID
  @override
  final String email;

  @override
  String toString() {
    return 'ProgressModel(habitId: $habitId, date: $date, completed: $completed, synced: $synced, uid: $uid, email: $email)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProgressModelImpl &&
            (identical(other.habitId, habitId) || other.habitId == habitId) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.completed, completed) ||
                other.completed == completed) &&
            (identical(other.synced, synced) || other.synced == synced) &&
            (identical(other.uid, uid) || other.uid == uid) &&
            (identical(other.email, email) || other.email == email));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, habitId, date, completed, synced, uid, email);

  /// Create a copy of ProgressModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ProgressModelImplCopyWith<_$ProgressModelImpl> get copyWith =>
      __$$ProgressModelImplCopyWithImpl<_$ProgressModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ProgressModelImplToJson(
      this,
    );
  }
}

abstract class _ProgressModel implements ProgressModel {
  const factory _ProgressModel(
      {required final int habitId,
      required final DateTime date,
      required final bool completed,
      required final bool synced,
      required final String uid,
      required final String email}) = _$ProgressModelImpl;

  factory _ProgressModel.fromJson(Map<String, dynamic> json) =
      _$ProgressModelImpl.fromJson;

  @override
  int get habitId; // Unique ID
  @override
  DateTime get date;
  @override
  bool get completed;
  @override
  bool get synced;
  @override
  String get uid; // User ID
  @override
  String get email;

  /// Create a copy of ProgressModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ProgressModelImplCopyWith<_$ProgressModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
