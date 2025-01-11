import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_quest/features/auth/data/models/signup_objectbox.dart';
import 'package:habit_quest/features/habit/data/models/habit_model.dart';
import 'package:habit_quest/features/habit/data/models/habit_objectbox.dart';
import 'package:habit_quest/features/habit/data/models/progress_model.dart';
import 'package:habit_quest/features/habit/data/models/progress_objectbox.dart';
import 'package:habit_quest/features/habit/presentation/blocs/habit_bloc/habit_bloc.dart';
import 'package:habit_quest/features/habit/presentation/blocs/habit_bloc/habit_event.dart';
import 'package:habit_quest/main_production.dart';
import 'package:habit_quest/objectbox.g.dart';
import 'package:habit_quest/shared/utils/app_colors.dart';

class GamificationScreen extends StatefulWidget {
  const GamificationScreen({super.key});

  @override
  State<GamificationScreen> createState() => _GamificationScreenState();
}

class _GamificationScreenState extends State<GamificationScreen> {
  late final SignUpEntity? user;
  late List<HabitModel> localHabits = [];
  late List<HabitEntity> habitEntities = [];
  late List<ProgressModel> localProgress = [];
  late List<ProgressEntity> progressEntities = [];
  late List<Map<String, dynamic>> habitXPList = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();

    // Fetch the first user in signUpBox
    user = objectbox.signUpBox.getAll().firstOrNull;

    // Fetch habits and compute XP
    _initializeGamification();
  }

  Future<void> _initializeGamification() async {
    setState(() {
      isLoading = true; // Start loading
    });

    await _fetchHabits();
    await _computeXP();

    setState(() {
      isLoading = false; // Stop loading
    });
  }

  Future<void> _fetchHabits() async {
    localHabits.clear();
    habitEntities.clear();
    // Debugging: Log fetched user
    log('User model (initial fetch): ${user?.email ?? 'null'}');

    if (user != null) {
      // Fetch habits from local storage for the current user
      habitEntities = objectbox.habitBox
          .query(HabitEntity_.uid.equals(user!.uid))
          .build()
          .find();

      // Debugging: Log habit entities
      log('Local habits: ${habitEntities.toList()}');

      // Convert HabitEntity to HabitModel
      localHabits = habitEntities
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

      log('Local habits after conversion: $localHabits');

      if (localHabits.isEmpty) {
        // Fetch from Firestore if no local habits exist
        log('Fetching habits');
        context.read<HabitBloc>().add(FetchHabitsRequested(user!.uid));
      }
    }
  }

  Future<List<ProgressModel>> _fetchProgress(HabitModel habit) async {
    localProgress.clear();

    final progressEntities = objectbox.progressBox
        .query(ProgressEntity_.habitId.equals(habit.habitId))
        .build()
        .find();

    final progressList = progressEntities
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

    return progressList;
  }

  Future<void> _computeXP() async {
    habitXPList.clear();

    for (final habit in localHabits) {
      // Skip if the habit already exists in the habitXPList
      if (habitXPList.any(
        (entry) => (entry['habit'] as HabitModel).habitId == habit.habitId,
      )) {
        continue;
      }

      final progressList = await _fetchProgress(habit);

      // Calculate total days between start and end date
      final startDate = habit.startDate;
      final endDate = habit.endDate;
      final totalDays = endDate.difference(startDate).inDays + 1;

      // Compute XP
      var totalXP = 0.0;
      for (final progress in progressList) {
        if (progress.completed) {
          final progressDate = progress.date;
          final progressFraction =
              (progressDate.difference(startDate).inDays + 1) / totalDays;
          totalXP += progressFraction * 100;
        }
      }

      // Store habit and XP
      habitXPList.add({
        'habit': habit,
        'xp': totalXP,
      });
    }

    setState(() {}); // Update the UI with the computed data
  }

  @override
  Widget build(BuildContext context) {
    //set the status bar color to transparent
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: AppColors.transparent,
      ),
    );
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(
          left: 20,
          right: 20,
          top: 40,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Gamification',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                GestureDetector(
                  onTap: () async {
                    await _initializeGamification();
                  },
                  child: const Text(
                    'Refresh XP',
                    style: TextStyle(
                      color: AppColors.primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            // XP list view
            if (isLoading)
              const Center(
                child: CircularProgressIndicator(
                  color: AppColors.primaryColor,
                  strokeWidth: 2,
                ),
              ),
            if (!isLoading)
              Flexible(
                child: ListView.builder(
                  itemCount: habitXPList.length,
                  itemBuilder: (context, index) {
                    final habitData = habitXPList[index];
                    final habit = habitData['habit'] as HabitModel;
                    final xp = habitData['xp'] as double;

                    // Determine badge based on progress
                    final startDate = habit.startDate;
                    final endDate = habit.endDate;
                    final frequencyInDays =
                        habit.frequency.toLowerCase() == 'daily'
                            ? 1
                            : habit.frequency.toLowerCase() == 'weekly'
                                ? 7
                                : 30;

                    final totalDays = endDate.difference(startDate).inDays + 1;
                    final totalExpectedEntries =
                        (totalDays / frequencyInDays).ceil();
                    final recordedEntries = xp / 100.0 * totalExpectedEntries;

                    // Dynamic badge assignment
                    var badge = '';
                    if (recordedEntries < totalExpectedEntries / 2) {
                      badge = '❄️'; // Freeze emoji
                    } else if (recordedEntries == totalExpectedEntries / 2) {
                      badge = '😊'; // Smile emoji
                    } else if (recordedEntries > totalExpectedEntries / 2) {
                      badge = '🔥'; // Flame emoji
                    }

                    return ListTile(
                      leading: CircleAvatar(
                        radius: 18,
                        backgroundColor: AppColors.primaryColor.withOpacity(
                          0.2,
                        ),
                        child: Center(
                          child: Text(
                            habit.name.substring(0, 1).toUpperCase(),
                            style: const TextStyle(
                              color: AppColors.primaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      title: SizedBox(
                        width: 90,
                        child: Text(
                          habit.name,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      subtitle: SizedBox(
                        width: 90,
                        child: Text(
                          '${xp.toStringAsFixed(2)} XP',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: AppColors.primaryColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      trailing: Text(
                        badge,
                        style: const TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}
