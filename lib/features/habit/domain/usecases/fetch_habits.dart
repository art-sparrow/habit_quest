import 'package:habit_quest/features/habit/data/models/habit_model.dart';
import 'package:habit_quest/features/habit/domain/repositories/habit_repository.dart';

class FetchHabits {
  FetchHabits({required this.repository});

  final HabitRepository repository;

  Future<List<HabitModel>> call(String uid) async {
    final habits = await repository.fetchHabits(uid);
    return habits;
  }
}
