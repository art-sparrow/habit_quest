import 'package:equatable/equatable.dart';
import 'package:habit_quest/features/habit/data/models/habit_model.dart';
import 'package:habit_quest/features/habit/data/models/progress_model.dart';

abstract class HabitEvent extends Equatable {
  const HabitEvent();

  @override
  List<Object> get props => [];
}

class CreateHabitRequested extends HabitEvent {
  const CreateHabitRequested(this.habitModel);

  final HabitModel habitModel;

  @override
  List<Object> get props => [habitModel];
}

class UpdateHabitRequested extends HabitEvent {
  const UpdateHabitRequested(this.habitModel);

  final HabitModel habitModel;

  @override
  List<Object> get props => [habitModel];
}

class DeleteHabitRequested extends HabitEvent {
  const DeleteHabitRequested(this.habitId, this.uid);

  final int habitId;
  final String uid;

  @override
  List<Object> get props => [habitId, uid];
}

class FetchHabitsRequested extends HabitEvent {
  const FetchHabitsRequested(this.uid);

  final String uid;

  @override
  List<Object> get props => [uid];
}

class CreateProgressRequested extends HabitEvent {
  const CreateProgressRequested(this.progressModel);

  final ProgressModel progressModel;

  @override
  List<Object> get props => [progressModel];
}

class FetchProgressRequested extends HabitEvent {
  const FetchProgressRequested(this.habitId, this.uid);

  final int habitId;
  final String uid;

  @override
  List<Object> get props => [habitId, uid];
}

class SyncHabitRequested extends HabitEvent {
  const SyncHabitRequested(this.habitModel);

  final HabitModel habitModel;

  @override
  List<Object> get props => [habitModel];
}

class SyncProgressRequested extends HabitEvent {
  const SyncProgressRequested(this.progressModel);

  final ProgressModel progressModel;

  @override
  List<Object> get props => [progressModel];
}
