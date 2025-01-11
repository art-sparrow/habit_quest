import 'package:habit_quest/features/habit/domain/repositories/habit_repository.dart';

class DeleteHabit {
  DeleteHabit({required this.repository});

  final HabitRepository repository;

  Future<void> call(int habitId, String uid) async {
    await repository.deleteHabit(habitId, uid);
  }
}
