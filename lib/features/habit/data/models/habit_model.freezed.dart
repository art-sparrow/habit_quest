// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'habit_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

HabitModel _$HabitModelFromJson(Map<String, dynamic> json) {
  return _HabitModel.fromJson(json);
}

/// @nodoc
mixin _$HabitModel {
  int get habitId => throw _privateConstructorUsedError; // Unique ID
  String get name => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  String get frequency => throw _privateConstructorUsedError;
  DateTime get startDate => throw _privateConstructorUsedError;
  DateTime get endDate => throw _privateConstructorUsedError;
  bool get synced => throw _privateConstructorUsedError;
  String get uid => throw _privateConstructorUsedError; // User ID
  String get email => throw _privateConstructorUsedError;

  /// Serializes this HabitModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of HabitModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $HabitModelCopyWith<HabitModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HabitModelCopyWith<$Res> {
  factory $HabitModelCopyWith(
          HabitModel value, $Res Function(HabitModel) then) =
      _$HabitModelCopyWithImpl<$Res, HabitModel>;
  @useResult
  $Res call(
      {int habitId,
      String name,
      String description,
      String frequency,
      DateTime startDate,
      DateTime endDate,
      bool synced,
      String uid,
      String email});
}

/// @nodoc
class _$HabitModelCopyWithImpl<$Res, $Val extends HabitModel>
    implements $HabitModelCopyWith<$Res> {
  _$HabitModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of HabitModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? habitId = null,
    Object? name = null,
    Object? description = null,
    Object? frequency = null,
    Object? startDate = null,
    Object? endDate = null,
    Object? synced = null,
    Object? uid = null,
    Object? email = null,
  }) {
    return _then(_value.copyWith(
      habitId: null == habitId
          ? _value.habitId
          : habitId // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      frequency: null == frequency
          ? _value.frequency
          : frequency // ignore: cast_nullable_to_non_nullable
              as String,
      startDate: null == startDate
          ? _value.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      endDate: null == endDate
          ? _value.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
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
abstract class _$$HabitModelImplCopyWith<$Res>
    implements $HabitModelCopyWith<$Res> {
  factory _$$HabitModelImplCopyWith(
          _$HabitModelImpl value, $Res Function(_$HabitModelImpl) then) =
      __$$HabitModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int habitId,
      String name,
      String description,
      String frequency,
      DateTime startDate,
      DateTime endDate,
      bool synced,
      String uid,
      String email});
}

/// @nodoc
class __$$HabitModelImplCopyWithImpl<$Res>
    extends _$HabitModelCopyWithImpl<$Res, _$HabitModelImpl>
    implements _$$HabitModelImplCopyWith<$Res> {
  __$$HabitModelImplCopyWithImpl(
      _$HabitModelImpl _value, $Res Function(_$HabitModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of HabitModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? habitId = null,
    Object? name = null,
    Object? description = null,
    Object? frequency = null,
    Object? startDate = null,
    Object? endDate = null,
    Object? synced = null,
    Object? uid = null,
    Object? email = null,
  }) {
    return _then(_$HabitModelImpl(
      habitId: null == habitId
          ? _value.habitId
          : habitId // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      frequency: null == frequency
          ? _value.frequency
          : frequency // ignore: cast_nullable_to_non_nullable
              as String,
      startDate: null == startDate
          ? _value.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      endDate: null == endDate
          ? _value.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
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
class _$HabitModelImpl implements _HabitModel {
  const _$HabitModelImpl(
      {required this.habitId,
      required this.name,
      required this.description,
      required this.frequency,
      required this.startDate,
      required this.endDate,
      required this.synced,
      required this.uid,
      required this.email});

  factory _$HabitModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$HabitModelImplFromJson(json);

  @override
  final int habitId;
// Unique ID
  @override
  final String name;
  @override
  final String description;
  @override
  final String frequency;
  @override
  final DateTime startDate;
  @override
  final DateTime endDate;
  @override
  final bool synced;
  @override
  final String uid;
// User ID
  @override
  final String email;

  @override
  String toString() {
    return 'HabitModel(habitId: $habitId, name: $name, description: $description, frequency: $frequency, startDate: $startDate, endDate: $endDate, synced: $synced, uid: $uid, email: $email)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HabitModelImpl &&
            (identical(other.habitId, habitId) || other.habitId == habitId) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.frequency, frequency) ||
                other.frequency == frequency) &&
            (identical(other.startDate, startDate) ||
                other.startDate == startDate) &&
            (identical(other.endDate, endDate) || other.endDate == endDate) &&
            (identical(other.synced, synced) || other.synced == synced) &&
            (identical(other.uid, uid) || other.uid == uid) &&
            (identical(other.email, email) || other.email == email));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, habitId, name, description,
      frequency, startDate, endDate, synced, uid, email);

  /// Create a copy of HabitModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$HabitModelImplCopyWith<_$HabitModelImpl> get copyWith =>
      __$$HabitModelImplCopyWithImpl<_$HabitModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$HabitModelImplToJson(
      this,
    );
  }
}

abstract class _HabitModel implements HabitModel {
  const factory _HabitModel(
      {required final int habitId,
      required final String name,
      required final String description,
      required final String frequency,
      required final DateTime startDate,
      required final DateTime endDate,
      required final bool synced,
      required final String uid,
      required final String email}) = _$HabitModelImpl;

  factory _HabitModel.fromJson(Map<String, dynamic> json) =
      _$HabitModelImpl.fromJson;

  @override
  int get habitId; // Unique ID
  @override
  String get name;
  @override
  String get description;
  @override
  String get frequency;
  @override
  DateTime get startDate;
  @override
  DateTime get endDate;
  @override
  bool get synced;
  @override
  String get uid; // User ID
  @override
  String get email;

  /// Create a copy of HabitModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$HabitModelImplCopyWith<_$HabitModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
