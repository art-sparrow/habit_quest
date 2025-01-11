import 'package:freezed_annotation/freezed_annotation.dart';

part 'habit_model.freezed.dart';
part 'habit_model.g.dart';

@freezed
class HabitModel with _$HabitModel {
  const factory HabitModel({
    required int habitId, // Unique ID
    required String name,
    required String description,
    required String frequency,
    required DateTime startDate,
    required DateTime endDate,
    required bool synced,
    required String uid, // User ID
    required String email,
  }) = _HabitModel;

  factory HabitModel.fromJson(Map<String, dynamic> json) =>
      _$HabitModelFromJson(json);
}
