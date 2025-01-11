import 'package:habit_quest/features/habit/data/datasources/habit_firebase.dart';
import 'package:habit_quest/features/habit/data/datasources/habit_objectbox.dart';
import 'package:habit_quest/features/habit/data/models/habit_model.dart';
import 'package:habit_quest/features/habit/data/models/habit_objectbox.dart';
import 'package:habit_quest/features/habit/data/models/progress_model.dart';
import 'package:habit_quest/features/habit/data/models/progress_objectbox.dart';
import 'package:habit_quest/features/habit/domain/repositories/habit_repository.dart';
import 'package:habit_quest/features/network/presentation/bloc/network_bloc.dart';
import 'package:habit_quest/features/network/presentation/bloc/network_state.dart';
import 'package:habit_quest/shared/extensions/habit_extensions.dart'
    as habit_ext;
import 'package:habit_quest/shared/extensions/sync_extensions.dart' as sync_ext;

class HabitRepositoryImpl implements HabitRepository {
  HabitRepositoryImpl({
    required this.habitFirebase,
    required this.habitObjectbox,
    required this.networkBloc,
  });

  final HabitFirebase habitFirebase;
  final HabitObjectbox habitObjectbox;
  final NetworkBloc networkBloc;

  @override
  Future<void> createHabit(HabitModel habitModel) async {
    // Check online state
    final currentState = networkBloc.state;
    // Convert HabitModel to HabitEntity
    final entityHabit = habit_ext.HabitModelToEntity(habitModel).toEntity();

    // Online: Sync with Firestore and ObjectBox
    if (currentState is NetworkConnected) {
      //Update `synced` flag to `true`
      final syncedHabitModel = habitModel.copyWith(synced: true);
      // Save to Firestore
      await habitFirebase.createHabit(syncedHabitModel);
      // Save to ObjectBox
      final habitEntity = HabitEntity(
        habitId: entityHabit.habitId,
        name: entityHabit.name,
        description: entityHabit.description,
        frequency: entityHabit.frequency,
        startDate: entityHabit.startDate,
        endDate: entityHabit.endDate,
        synced: true,
        uid: entityHabit.uid,
        email: entityHabit.email,
      );
      await habitObjectbox.createHabit(habitEntity);
    } else {
      // Offline: Save only to ObjectBox
      await habitObjectbox.createHabit(
        HabitEntity(
          habitId: entityHabit.habitId,
          name: entityHabit.name,
          description: entityHabit.description,
          frequency: entityHabit.frequency,
          startDate: entityHabit.startDate,
          endDate: entityHabit.endDate,
          uid: entityHabit.uid,
          email: entityHabit.email,
        ),
      );
    }
  }

  @override
  Future<void> updateHabit(HabitModel habitModel) async {
    // Check online state
    final currentState = networkBloc.state;
    // Convert HabitModel to HabitEntity
    final entityHabit = habit_ext.HabitModelToEntity(habitModel).toEntity();

    if (currentState is NetworkConnected) {
      // Update `synced` flag to `true`
      final syncedHabitModel = habitModel.copyWith(synced: true);
      // Update in Firestore
      await habitFirebase.updateHabit(syncedHabitModel);

      // Update in ObjectBox
      final habitEntity = HabitEntity(
        habitId: entityHabit.habitId,
        name: entityHabit.name,
        description: entityHabit.description,
        frequency: entityHabit.frequency,
        startDate: entityHabit.startDate,
        endDate: entityHabit.endDate,
        synced: true,
        uid: entityHabit.uid,
        email: entityHabit.email,
      );
      await habitObjectbox.updateHabit(habitEntity);
    } else {
      // Update in ObjectBox
      await habitObjectbox.updateHabit(
        HabitEntity(
          habitId: entityHabit.habitId,
          name: entityHabit.name,
          description: entityHabit.description,
          frequency: entityHabit.frequency,
          startDate: entityHabit.startDate,
          endDate: entityHabit.endDate,
          uid: entityHabit.uid,
          email: entityHabit.email,
        ),
      );
    }
  }

  @override
  Future<void> deleteHabit(int habitId, String uid) async {
    final currentState = networkBloc.state;

    if (currentState is NetworkConnected) {
      // Delete from Firestore
      await habitFirebase.deleteHabit(habitId, uid);
    }

    // Delete from ObjectBox
    await habitObjectbox.deleteHabit(habitId);
  }

  @override
  Future<List<HabitModel>> fetchHabits(String uid) async {
    final currentState = networkBloc.state;

    if (currentState is NetworkConnected) {
      try {
        // Fetch from Firestore
        final habits = await habitFirebase.fetchHabits(uid);

        // Update local storage
        for (final habit in habits) {
          final habitEntity = HabitEntity(
            habitId: habit.habitId,
            name: habit.name,
            description: habit.description,
            frequency: habit.frequency,
            startDate: habit.startDate,
            endDate: habit.endDate,
            synced: true,
            uid: habit.uid,
            email: habit.email,
          );
          await habitObjectbox.createHabit(habitEntity);
        }

        return habits;
      } catch (e) {
        // Fallback to local storage in case of error
        final entities = habitObjectbox.fetchHabits(uid);
        return entities
            .map(
              (entity) => HabitModel(
                habitId: entity.habitId,
                name: entity.name,
                description: entity.description,
                frequency: entity.frequency,
                startDate: entity.startDate,
                endDate: entity.endDate,
                synced: entity.synced,
                uid: entity.uid,
                email: entity.email,
              ),
            )
            .toList();
      }
    } else {
      // Offline: Fetch from ObjectBox
      final entities = habitObjectbox.fetchHabits(uid);
      return entities
          .map(
            (entity) => HabitModel(
              habitId: entity.habitId,
              name: entity.name,
              description: entity.description,
              frequency: entity.frequency,
              startDate: entity.startDate,
              endDate: entity.endDate,
              synced: entity.synced,
              uid: entity.uid,
              email: entity.email,
            ),
          )
          .toList();
    }
  }

  @override
  Future<void> createProgress(ProgressModel progressModel) async {
    final currentState = networkBloc.state;
    // Convert ProgressModel to ProgressEntity
    final entityProgress =
        habit_ext.ProgressModelToEntity(progressModel).toEntity();

    if (currentState is NetworkConnected) {
      // Update `synced` flag to `true`
      final syncedProgressModel = progressModel.copyWith(synced: true);
      // Save to Firestore
      await habitFirebase.createProgress(syncedProgressModel);
      // Save to ObjectBox
      final progressEntity = ProgressEntity(
        habitId: entityProgress.habitId,
        date: entityProgress.date,
        completed: entityProgress.completed,
        synced: true,
        uid: entityProgress.uid,
        email: entityProgress.email,
      );
      await habitObjectbox.createProgress(progressEntity);
    } else {
      // Offline: Save to ObjectBox
      final progressEntity = ProgressEntity(
        habitId: entityProgress.habitId,
        date: entityProgress.date,
        completed: entityProgress.completed,
        uid: entityProgress.uid,
        email: entityProgress.email,
      );
      await habitObjectbox.createProgress(progressEntity);
    }
  }

  @override
  Future<List<ProgressModel>> fetchProgress(int habitId, String uid) async {
    final currentState = networkBloc.state;

    if (currentState is NetworkConnected) {
      try {
        // Fetch from Firestore
        final progress = await habitFirebase.fetchProgress(habitId, uid);

        // Update local storage
        for (final p in progress) {
          final progressEntity = ProgressEntity(
            habitId: p.habitId,
            date: p.date,
            completed: p.completed,
            synced: true,
            uid: p.uid,
            email: p.email,
          );
          await habitObjectbox.createProgress(progressEntity);
        }

        return progress;
      } catch (e) {
        // Fallback to local storage in case of error
        final entities = habitObjectbox.fetchProgress(habitId);
        return entities
            .map(
              (entity) => ProgressModel(
                habitId: entity.habitId,
                date: entity.date,
                completed: entity.completed,
                synced: entity.synced,
                uid: entity.uid,
                email: entity.email,
              ),
            )
            .toList();
      }
    } else {
      // Offline: Return local storage data
      final entities = habitObjectbox.fetchProgress(habitId);
      return entities
          .map(
            (entity) => ProgressModel(
              habitId: entity.habitId,
              date: entity.date,
              completed: entity.completed,
              synced: entity.synced,
              uid: entity.uid,
              email: entity.email,
            ),
          )
          .toList();
    }
  }

  @override
  Future<List<HabitModel>> getUnSyncedHabits() async {
    final entities = habitObjectbox.fetchUnsyncedHabits();
    return entities
        .map(
          (entity) => sync_ext.HabitEntityExtensions(entity).toModel(),
        )
        .toList();
  }

  @override
  Future<List<ProgressModel>> getUnSyncedProgress() async {
    final entities = habitObjectbox.fetchUnsyncedProgress();
    return entities
        .map(
          (entity) => sync_ext.ProgressEntityExtensions(entity).toModel(),
        )
        .toList();
  }

  @override
  Future<void> syncHabit(HabitModel habitModel) async {
    // Check online state
    final currentState = networkBloc.state;

    // Convert HabitModel to HabitEntity
    final entityHabit = habit_ext.HabitModelToEntity(habitModel).toEntity();

    // Online: Sync with Firestore and ObjectBox
    if (currentState is NetworkConnected) {
      // Update `synced` flag to `true`
      final syncedHabitModel = habitModel.copyWith(synced: true);

      // Fetch habits from Firestore
      final habits = await habitFirebase.fetchHabits(syncedHabitModel.uid);

      // Default habit to signify not found
      final defaultHabit = HabitModel(
        habitId: -1, // Use an invalid ID to identify default case
        name: '',
        description: '',
        frequency: '',
        startDate: DateTime.now(),
        endDate: DateTime.now(),
        synced: false,
        uid: '',
        email: '',
      );

      // Check if the habit exists
      final existingHabit = habits.firstWhere(
        (habit) => habit.habitId == syncedHabitModel.habitId,
        orElse: () => defaultHabit,
      );

      if (existingHabit.habitId != -1) {
        // Update the existing habit in Firestore
        await habitFirebase.updateHabit(syncedHabitModel);
      } else {
        // Create the habit in Firestore
        await habitFirebase.createHabit(syncedHabitModel);
      }

      // Update on ObjectBox
      final habitEntity = HabitEntity(
        habitId: entityHabit.habitId,
        name: entityHabit.name,
        description: entityHabit.description,
        frequency: entityHabit.frequency,
        startDate: entityHabit.startDate,
        endDate: entityHabit.endDate,
        synced: true,
        uid: entityHabit.uid,
        email: entityHabit.email,
      );
      // Update optional `synced` flag to `true`
      await habitObjectbox.updateHabit(habitEntity);
    } else {
      // Offline: Update optional `synced` flag to `false`
      await habitObjectbox.updateHabit(
        HabitEntity(
          habitId: entityHabit.habitId,
          name: entityHabit.name,
          description: entityHabit.description,
          frequency: entityHabit.frequency,
          startDate: entityHabit.startDate,
          endDate: entityHabit.endDate,
          uid: entityHabit.uid,
          email: entityHabit.email,
        ),
      );
    }
  }

  @override
  Future<void> syncProgress(ProgressModel progressModel) async {
    // Check online state
    final currentState = networkBloc.state;

    // Convert ProgressModel to ProgressEntity
    final entityProgress =
        habit_ext.ProgressModelToEntity(progressModel).toEntity();

    // Online: Sync with Firestore and ObjectBox
    if (currentState is NetworkConnected) {
      // Update `synced` flag to `true`
      final syncedProgress = progressModel.copyWith(synced: true);

      // Create the progress in Firestore
      await habitFirebase.createProgress(syncedProgress);
      // Update on ObjectBox
      final progressEntity = ProgressEntity(
        habitId: syncedProgress.habitId,
        date: syncedProgress.date,
        uid: syncedProgress.uid,
        email: syncedProgress.email,
        completed: syncedProgress.completed,
        synced: true,
      );
      // Update optional `synced` flag to `true`
      await habitObjectbox.updateProgress(progressEntity);
    } else {
      // Offline: Update optional `synced` flag to `true`
      await habitObjectbox.updateProgress(
        ProgressEntity(
          habitId: entityProgress.habitId,
          date: entityProgress.date,
          uid: entityProgress.uid,
          email: entityProgress.email,
          completed: entityProgress.completed,
        ),
      );
    }
  }
}
