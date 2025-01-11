import 'package:equatable/equatable.dart';
import 'package:habit_quest/features/habit/data/models/habit_model.dart';
import 'package:habit_quest/features/habit/data/models/progress_model.dart';

abstract class HabitState extends Equatable {
  const HabitState();

  @override
  List<Object> get props => [];
}

class HabitInitial extends HabitState {}

class HabitLoading extends HabitState {}

class HabitSuccess extends HabitState {}

class HabitFailure extends HabitState {
  const HabitFailure(this.error);

  final String error;
}

class HabitsLoaded extends HabitState {
  const HabitsLoaded(this.habits);

  final List<HabitModel> habits;

  @override
  List<Object> get props => [habits];
}

class ProgressLoaded extends HabitState {
  const ProgressLoaded(this.progress);

  final List<ProgressModel> progress;

  @override
  List<Object> get props => [progress];
}
