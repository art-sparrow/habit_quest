import 'package:habit_quest/features/habit/data/models/habit_objectbox.dart';
import 'package:habit_quest/features/habit/data/models/progress_objectbox.dart';
import 'package:habit_quest/objectbox.g.dart';
import 'package:habit_quest/shared/helpers/objectbox.dart';

class HabitObjectbox {
  HabitObjectbox({required this.objectBox});

  final ObjectBox objectBox;

  // Create a new habit in ObjectBox
  Future<void> createHabit(HabitEntity habit) async {
    objectBox.habitBox.put(habit);
  }

  // Update an existing habit in ObjectBox
  Future<void> updateHabit(HabitEntity habit) async {
    final query = objectBox.habitBox
        .query(
          HabitEntity_.habitId.equals(habit.habitId) &
              HabitEntity_.uid.equals(habit.uid),
        )
        .build();

    final existingHabit = query.findFirst();

    if (existingHabit != null) {
      // Update the fields of the existing habit
      existingHabit.name = habit.name;
      existingHabit.description = habit.description;
      existingHabit.frequency = habit.frequency;
      existingHabit.startDate = habit.startDate;
      existingHabit.endDate = habit.endDate;
      existingHabit.synced = habit.synced;

      // Save updated habit
      objectBox.habitBox.put(existingHabit);
    } else {
      throw Exception('Habit not found for update.');
    }

    query.close();
  }

  // Delete a habit from ObjectBox
  Future<void> deleteHabit(int habitId) async {
    objectBox.habitBox
        .query(HabitEntity_.habitId.equals(habitId))
        .build()
        .remove();
  }

  // Delete all habits from ObjectBox
  Future<void> deleteAllHabits() async {
    objectBox.habitBox.removeAll();
  }

  // Fetch all habits
  List<HabitEntity> fetchHabits(String uid) {
    return objectBox.habitBox
        .query(HabitEntity_.uid.equals(uid))
        .build()
        .find();
  }

  // Create a new progress entry in ObjectBox
  Future<void> createProgress(ProgressEntity progress) async {
    objectBox.progressBox.put(progress);
  }

  // Fetch progress for a specific habit
  List<ProgressEntity> fetchProgress(int habitId) {
    return objectBox.progressBox
        .query(ProgressEntity_.habitId.equals(habitId))
        .build()
        .find();
  }

  // Delete all progress from ObjectBox
  Future<void> deleteAllProgress() async {
    objectBox.progressBox.removeAll();
  }

  // Update an existing progress in ObjectBox
  Future<void> updateProgress(ProgressEntity progress) async {
    final query = objectBox.progressBox
        .query(
          ProgressEntity_.habitId.equals(progress.habitId) &
              ProgressEntity_.uid.equals(progress.uid),
        )
        .build();

    final existingProgress = query.findFirst();

    if (existingProgress != null) {
      // Update the fields of the existing progress
      existingProgress.habitId = progress.habitId;
      existingProgress.date = progress.date;
      existingProgress.uid = progress.uid;
      existingProgress.email = progress.email;
      existingProgress.synced = progress.synced;
      existingProgress.completed = progress.completed;

      // Save updated progress
      objectBox.progressBox.put(existingProgress);
    } else {
      throw Exception('Progress not found for update.');
    }

    query.close();
  }

  List<HabitEntity> fetchUnsyncedHabits() {
    return objectBox.habitBox
        .query(HabitEntity_.synced.equals(false))
        .build()
        .find();
  }

  List<ProgressEntity> fetchUnsyncedProgress() {
    return objectBox.progressBox
        .query(ProgressEntity_.synced.equals(false))
        .build()
        .find();
  }
}
