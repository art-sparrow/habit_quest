import 'package:habit_quest/features/habit/data/models/habit_model.dart';
import 'package:habit_quest/features/habit/data/models/habit_objectbox.dart';
import 'package:habit_quest/features/habit/data/models/progress_model.dart';
import 'package:habit_quest/features/habit/data/models/progress_objectbox.dart';

extension ProgressEntityExtensions on ProgressEntity {
  ProgressModel toModel() {
    return ProgressModel(
      habitId: habitId,
      date: date,
      completed: completed,
      synced: synced,
      uid: uid,
      email: email,
    );
  }
}

extension ProgressModelExtensions on ProgressModel {
  ProgressEntity toEntity() {
    return ProgressEntity(
      habitId: habitId,
      date: date,
      completed: completed,
      synced: synced,
      uid: uid,
      email: email,
    );
  }
}

extension HabitEntityExtensions on HabitEntity {
  HabitModel toModel() {
    return HabitModel(
      habitId: habitId,
      name: name,
      description: description,
      frequency: frequency,
      startDate: startDate,
      endDate: endDate,
      synced: synced,
      uid: uid,
      email: email,
    );
  }
}

extension HabitModelExtensions on HabitModel {
  HabitEntity toEntity() {
    return HabitEntity(
      habitId: habitId,
      name: name,
      description: description,
      frequency: frequency,
      startDate: startDate,
      endDate: endDate,
      synced: synced,
      uid: uid,
      email: email,
    );
  }
}
