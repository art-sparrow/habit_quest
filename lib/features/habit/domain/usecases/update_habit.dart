import 'package:habit_quest/features/habit/data/models/habit_model.dart';
import 'package:habit_quest/features/habit/domain/repositories/habit_repository.dart';

class UpdateHabit {
  UpdateHabit({required this.repository});

  final HabitRepository repository;

  Future<void> call(HabitModel habitModel) async {
    await repository.updateHabit(habitModel);
  }
}
