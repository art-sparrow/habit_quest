import 'package:habit_quest/features/habit/data/models/progress_model.dart';
import 'package:habit_quest/features/habit/domain/repositories/habit_repository.dart';

class SyncProgress {
  SyncProgress({required this.repository});

  final HabitRepository repository;

  Future<void> call(ProgressModel progressModel) async {
    await repository.syncProgress(progressModel);
  }
}
