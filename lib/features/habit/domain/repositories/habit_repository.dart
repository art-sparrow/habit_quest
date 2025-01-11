import 'package:habit_quest/features/habit/data/models/habit_model.dart';
import 'package:habit_quest/features/habit/data/models/progress_model.dart';

abstract class HabitRepository {
  Future<void> createHabit(HabitModel habitModel);
  Future<void> updateHabit(HabitModel habitModel);
  Future<void> deleteHabit(int habitId, String uid);
  Future<List<HabitModel>> fetchHabits(String uid);
  Future<void> syncHabit(HabitModel habitModel); // SyncService
  Future<void> createProgress(ProgressModel progressModel);
  Future<List<ProgressModel>> fetchProgress(int habitId, String uid);
  Future<void> syncProgress(ProgressModel progressModel); // SyncService
  Future<List<HabitModel>> getUnSyncedHabits(); // SyncService
  Future<List<ProgressModel>> getUnSyncedProgress(); // SyncService
}
