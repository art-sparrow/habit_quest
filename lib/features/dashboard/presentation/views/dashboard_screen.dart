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
import 'package:habit_quest/features/habit/presentation/blocs/habit_bloc/habit_state.dart';
import 'package:habit_quest/features/network/presentation/views/network_status_container.dart';
import 'package:habit_quest/main_production.dart';
import 'package:habit_quest/objectbox.g.dart';
import 'package:habit_quest/shared/constants/assets_path.dart';
import 'package:habit_quest/shared/utils/app_colors.dart';
import 'package:habit_quest/shared/utils/router.dart';
import 'package:habit_quest/shared/widgets/dashboard_card.dart';
import 'package:habit_quest/shared/widgets/error_message.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  late final SignUpEntity? user;
  late List<HabitModel> localHabits = [];
  late List<HabitEntity> habitEntities = [];
  late List<ProgressModel> localProgress = [];
  late List<ProgressEntity> progressEntities = [];

  HabitModel? nextHabit;
  ProgressModel? lastProgress;

  @override
  void initState() {
    // Fetch the first user in signUpBox
    user = objectbox.signUpBox.getAll().firstOrNull;
    super.initState();
    // Initialize dashboard cards
    _initializeDashboard();
  }

  Future<void> _initializeDashboard() async {
    await _fetchHabits();
    await _fetchAndSetStats();
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

  Future<void> _fetchAndSetStats() async {
    lastProgress = null;
    nextHabit = null;

    for (final habit in localHabits) {
      final progressList = await _fetchProgress(habit);

      // Set last progress
      for (final progress in progressList) {
        if (lastProgress == null || progress.date.isAfter(lastProgress!.date)) {
          lastProgress = progress;
        }
      }

      // Calculate next habit date
      final now = DateTime.now();
      final frequencyDays = habit.frequency.toLowerCase() == 'daily'
          ? 1
          : habit.frequency.toLowerCase() == 'weekly'
              ? 7
              : 30;
      final nextDueDate = habit.startDate.add(Duration(days: frequencyDays));

      if (nextHabit == null ||
          (nextDueDate.isAfter(now) &&
              nextDueDate.isBefore(nextHabit!.startDate))) {
        nextHabit = habit;
      }
    }

    setState(() {}); // Update UI
  }

  @override
  Widget build(BuildContext context) {
    // Determine today's date
    final today = DateTime.now();
    final todayString = '${today.month}-${today.day}-${today.year}';
    //set the status bar color to transparent
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: AppColors.transparent,
      ),
    );
    return Scaffold(
      appBar: AppBar(
        leading: const Padding(
          padding: EdgeInsets.only(left: 20),
          child: CircleAvatar(
            backgroundColor: AppColors.transparent,
            radius: 10,
            backgroundImage: AssetImage(
              AssetsPath.profilePicture,
            ),
          ),
        ),
        centerTitle: false,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Padding(
              padding: EdgeInsets.only(
                bottom: 3,
              ),
              child: Text(
                'Hello! 👋',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
            SizedBox(
              width: 80,
              child: Text(
                user?.name ?? 'Username',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  overflow: TextOverflow.ellipsis,
                ),
                maxLines: 1,
              ),
            ),
          ],
        ),
        actions: [
          GestureDetector(
            onTap: () async {
              await Navigator.pushNamed(
                context,
                HabitQuestRouter.notificationsScreenRoute,
              );
            },
            child: const Padding(
              padding: EdgeInsets.only(right: 20),
              child: Stack(
                children: [
                  Icon(
                    LineAwesomeIcons.bell_solid,
                  ),
                  Positioned(
                    top: 0,
                    right: 6,
                    child: CircleAvatar(
                      backgroundColor: AppColors.primaryColor,
                      radius: 2,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          left: 20,
          right: 20,
          top: 40,
        ),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // network status container
              const NetworkStatusContainer(),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // date and habits count
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        DashboardCard(
                          height: 130,
                          cardColor: AppColors.orange,
                          cardIcon: AssetsPath.calendarLogo,
                          cardTitle: 'Today',
                          cardSubtitle: todayString,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        BlocConsumer<HabitBloc, HabitState>(
                          listener: (context, state) {
                            if (state is HabitFailure) {
                              ErrorMessage.show(context, state.error);
                            }
                          },
                          builder: (context, state) {
                            if (state is HabitsLoaded) {
                              localHabits = state.habits;
                            }

                            return DashboardCard(
                              height: 220,
                              cardColor: AppColors.primaryColor,
                              cardIcon: AssetsPath.habitQuestLogo,
                              cardTitle: 'All habits',
                              cardSubtitle: '${localHabits.length} habits',
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  // recent progress and next habit card
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        DashboardCard(
                          height: 220,
                          cardColor: AppColors.primaryColorLight,
                          cardIcon: AssetsPath.nextHabitLogo,
                          cardTitle: 'Next habit',
                          cardSubtitle:
                              nextHabit != null ? nextHabit!.name : 'None',
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        DashboardCard(
                          height: 130,
                          cardColor: AppColors.yellow,
                          cardIcon: AssetsPath.habitQuestLogo,
                          cardTitle: 'Last progress',
                          cardSubtitle: lastProgress != null
                              ? '${lastProgress!.date.month} '
                                  '- ${lastProgress!.date.day} '
                                  '- ${lastProgress!.date.year}'
                              : ' None',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
