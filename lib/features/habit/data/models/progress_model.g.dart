// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'progress_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ProgressModelImpl _$$ProgressModelImplFromJson(Map<String, dynamic> json) =>
    _$ProgressModelImpl(
      habitId: (json['habitId'] as num).toInt(),
      date: DateTime.parse(json['date'] as String),
      completed: json['completed'] as bool,
      synced: json['synced'] as bool,
      uid: json['uid'] as String,
      email: json['email'] as String,
    );

Map<String, dynamic> _$$ProgressModelImplToJson(_$ProgressModelImpl instance) =>
    <String, dynamic>{
      'habitId': instance.habitId,
      'date': instance.date.toIso8601String(),
      'completed': instance.completed,
      'synced': instance.synced,
      'uid': instance.uid,
      'email': instance.email,
    };
