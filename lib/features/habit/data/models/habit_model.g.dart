// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'habit_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$HabitModelImpl _$$HabitModelImplFromJson(Map<String, dynamic> json) =>
    _$HabitModelImpl(
      habitId: (json['habitId'] as num).toInt(),
      name: json['name'] as String,
      description: json['description'] as String,
      frequency: json['frequency'] as String,
      startDate: DateTime.parse(json['startDate'] as String),
      endDate: DateTime.parse(json['endDate'] as String),
      synced: json['synced'] as bool,
      uid: json['uid'] as String,
      email: json['email'] as String,
    );

Map<String, dynamic> _$$HabitModelImplToJson(_$HabitModelImpl instance) =>
    <String, dynamic>{
      'habitId': instance.habitId,
      'name': instance.name,
      'description': instance.description,
      'frequency': instance.frequency,
      'startDate': instance.startDate.toIso8601String(),
      'endDate': instance.endDate.toIso8601String(),
      'synced': instance.synced,
      'uid': instance.uid,
      'email': instance.email,
    };
