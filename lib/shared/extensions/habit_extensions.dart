import 'package:habit_quest/features/habit/data/models/habit_model.dart';
import 'package:habit_quest/features/habit/data/models/progress_model.dart';
import 'package:habit_quest/features/habit/domain/entities/habit_entity.dart';
import 'package:habit_quest/features/habit/domain/entities/progress_entity.dart';

// Extension to convert HabitModel to HabitEntity
extension HabitModelToEntity on HabitModel {
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

// Extension to convert HabitEntity to HabitModel
extension HabitEntityToModel on HabitEntity {
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

// Extension to convert ProgressModel to ProgressEntity
extension ProgressModelToEntity on ProgressModel {
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

// Extension to convert ProgressEntity to ProgressModel
extension ProgressEntityToModel on ProgressEntity {
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
