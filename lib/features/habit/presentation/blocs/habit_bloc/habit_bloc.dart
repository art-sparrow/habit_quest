import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_quest/features/habit/domain/usecases/create_habit.dart';
import 'package:habit_quest/features/habit/domain/usecases/create_progress.dart';
import 'package:habit_quest/features/habit/domain/usecases/delete_habit.dart';
import 'package:habit_quest/features/habit/domain/usecases/fetch_habits.dart';
import 'package:habit_quest/features/habit/domain/usecases/fetch_progress.dart';
import 'package:habit_quest/features/habit/domain/usecases/sync_habit.dart';
import 'package:habit_quest/features/habit/domain/usecases/sync_progress.dart';
import 'package:habit_quest/features/habit/domain/usecases/update_habit.dart';
import 'package:habit_quest/features/habit/presentation/blocs/habit_bloc/habit_event.dart';
import 'package:habit_quest/features/habit/presentation/blocs/habit_bloc/habit_state.dart';

class HabitBloc extends Bloc<HabitEvent, HabitState> {
  HabitBloc({
    required this.createHabit,
    required this.updateHabit,
    required this.deleteHabit,
    required this.fetchHabits,
    required this.createProgress,
    required this.fetchProgress,
    required this.syncHabit,
    required this.syncProgress,
  }) : super(HabitInitial()) {
    on<CreateHabitRequested>(_onCreateHabit);
    on<UpdateHabitRequested>(_onUpdateHabit);
    on<DeleteHabitRequested>(_onDeleteHabit);
    on<FetchHabitsRequested>(_onFetchHabits);
    on<CreateProgressRequested>(_onCreateProgress);
    on<FetchProgressRequested>(_onFetchProgress);
    on<SyncHabitRequested>(_onSyncHabit);
    on<SyncProgressRequested>(_onSyncProgress);
  }

  final CreateHabit createHabit;
  final UpdateHabit updateHabit;
  final DeleteHabit deleteHabit;
  final FetchHabits fetchHabits;
  final CreateProgress createProgress;
  final FetchProgress fetchProgress;
  final SyncHabit syncHabit;
  final SyncProgress syncProgress;

  Future<void> _onCreateHabit(
    CreateHabitRequested event,
    Emitter<HabitState> emit,
  ) async {
    emit(HabitLoading());
    try {
      await createHabit(event.habitModel);
      final habits = await fetchHabits(event.habitModel.uid);
      emit(HabitsLoaded(habits));
    } catch (e) {
      emit(HabitFailure(e.toString()));
    }
  }

  Future<void> _onUpdateHabit(
    UpdateHabitRequested event,
    Emitter<HabitState> emit,
  ) async {
    emit(HabitLoading());
    try {
      await updateHabit(event.habitModel);
      final habits = await fetchHabits(event.habitModel.uid);
      emit(HabitsLoaded(habits));
    } catch (e) {
      emit(HabitFailure(e.toString()));
    }
  }

  Future<void> _onDeleteHabit(
    DeleteHabitRequested event,
    Emitter<HabitState> emit,
  ) async {
    emit(HabitLoading());
    try {
      await deleteHabit(event.habitId, event.uid);
      final habits = await fetchHabits(event.uid);
      emit(HabitsLoaded(habits));
    } catch (e) {
      emit(HabitFailure(e.toString()));
    }
  }

  Future<void> _onFetchHabits(
    FetchHabitsRequested event,
    Emitter<HabitState> emit,
  ) async {
    emit(HabitLoading());
    try {
      final habits = await fetchHabits(event.uid);
      emit(HabitsLoaded(habits));
    } catch (e) {
      emit(HabitFailure(e.toString()));
    }
  }

  Future<void> _onCreateProgress(
    CreateProgressRequested event,
    Emitter<HabitState> emit,
  ) async {
    emit(HabitLoading());
    try {
      await createProgress(event.progressModel);
      final progress = await fetchProgress(
        event.progressModel.habitId,
        event.progressModel.uid,
      );
      emit(ProgressLoaded(progress));
    } catch (e) {
      emit(HabitFailure(e.toString()));
    }
  }

  Future<void> _onFetchProgress(
    FetchProgressRequested event,
    Emitter<HabitState> emit,
  ) async {
    emit(HabitLoading());
    try {
      final progress = await fetchProgress(
        event.habitId,
        event.uid,
      );
      emit(ProgressLoaded(progress));
    } catch (e) {
      emit(HabitFailure(e.toString()));
    }
  }

  Future<void> _onSyncHabit(
    SyncHabitRequested event,
    Emitter<HabitState> emit,
  ) async {
    emit(HabitLoading());
    try {
      await syncHabit(event.habitModel);
      final habits = await fetchHabits(event.habitModel.uid);
      emit(HabitsLoaded(habits));
    } catch (e) {
      emit(HabitFailure(e.toString()));
    }
  }

  Future<void> _onSyncProgress(
    SyncProgressRequested event,
    Emitter<HabitState> emit,
  ) async {
    emit(HabitLoading());
    try {
      await syncProgress(event.progressModel);
      final progress = await fetchProgress(
        event.progressModel.habitId,
        event.progressModel.uid,
      );
      emit(ProgressLoaded(progress));
    } catch (e) {
      emit(HabitFailure(e.toString()));
    }
  }
}
