import 'dart:async';
import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:habit_quest/features/habit/data/datasources/habit_firebase.dart';
import 'package:habit_quest/features/habit/data/datasources/habit_objectbox.dart';
import 'package:habit_quest/features/habit/data/models/habit_model.dart';
import 'package:habit_quest/features/habit/data/models/progress_model.dart';
import 'package:habit_quest/features/habit/data/repositories/habit_repository_impl.dart';
import 'package:habit_quest/features/network/data/repository/network_repository.dart';
import 'package:habit_quest/features/network/presentation/bloc/network_bloc.dart';
import 'package:habit_quest/main_production.dart';
import 'package:habit_quest/shared/services/notification_service.dart';

class SyncService {
  static Future<void> initialize() async {
    final service = FlutterBackgroundService();
    await service.configure(
      androidConfiguration: AndroidConfiguration(
        onStart: _onStart,
        isForegroundMode: true,
        notificationChannelId: 'sync_channel',
        initialNotificationTitle: 'Sync Service',
        initialNotificationContent: 'Syncing habits and progress...',
      ),
      iosConfiguration: IosConfiguration(
        onForeground: _onStart,
      ),
    );
  }

  static Future<void> _onStart(ServiceInstance service) async {
    try {
      // Initialize authFirebase and authObjectBox
      final firebaseAuth = FirebaseAuth.instance;
      final firestore = FirebaseFirestore.instance;
      final habitRepository = HabitRepositoryImpl(
        habitFirebase: HabitFirebase(
          firebaseAuth: firebaseAuth,
          firestore: firestore,
        ),
        habitObjectbox: HabitObjectbox(
          objectBox: objectbox,
        ),
        networkBloc: NetworkBloc(
          networkCheckRepository: NetworkRepository(),
        ),
      );

      Timer.periodic(const Duration(minutes: 15), (timer) async {
        final unsyncedHabits = await habitRepository.getUnSyncedHabits();
        final unsyncedProgress = await habitRepository.getUnSyncedProgress();

        // Sync habits
        await _syncItems<HabitModel>(
          items: unsyncedHabits,
          syncFunction: habitRepository.syncHabit,
          itemName: (habit) => 'Habit ${habit.name}',
        );

        // Sync progress
        await _syncItems<ProgressModel>(
          items: unsyncedProgress,
          syncFunction: habitRepository.syncProgress,
          itemName: (progress) => 'Progress for habit ID ${progress.habitId}',
        );
      });
    } catch (e) {
      log('Initialization error: $e');
      return;
    }
  }

  static Future<void> _syncItems<T>({
    required List<T> items,
    required Future<void> Function(T item) syncFunction,
    required String Function(T item) itemName,
  }) async {
    for (final item in items) {
      try {
        await syncFunction(item);
        await NotificationService().showNotification(
          id: DateTime.now().millisecondsSinceEpoch % 10000,
          title: 'Sync Successful',
          message: '${itemName(item)} synced successfully.',
        );
      } catch (e) {
        await NotificationService().showNotification(
          id: DateTime.now().millisecondsSinceEpoch % 10000,
          title: 'Sync Failed',
          message: '${itemName(item)} failed to sync.',
        );
      }
    }
  }
}
