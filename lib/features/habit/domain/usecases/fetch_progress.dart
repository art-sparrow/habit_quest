import 'package:habit_quest/features/habit/data/models/progress_model.dart';
import 'package:habit_quest/features/habit/domain/repositories/habit_repository.dart';

class FetchProgress {
  FetchProgress({required this.repository});

  final HabitRepository repository;

  Future<List<ProgressModel>> call(int habitId, String uid) async {
    final progress = await repository.fetchProgress(habitId, uid);
    return progress;
  }
}
