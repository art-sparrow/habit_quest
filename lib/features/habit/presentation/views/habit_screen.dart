// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_quest/features/auth/data/models/signup_objectbox.dart';
import 'package:habit_quest/features/habit/data/models/habit_model.dart';
import 'package:habit_quest/features/habit/data/models/habit_objectbox.dart';
import 'package:habit_quest/features/habit/presentation/blocs/habit_bloc/habit_bloc.dart';
import 'package:habit_quest/features/habit/presentation/blocs/habit_bloc/habit_event.dart';
import 'package:habit_quest/features/habit/presentation/blocs/habit_bloc/habit_state.dart';
import 'package:habit_quest/main_production.dart';
import 'package:habit_quest/objectbox.g.dart'; // Import generated code for ObjectBox
import 'package:habit_quest/shared/utils/app_colors.dart';
import 'package:habit_quest/shared/utils/router.dart';
import 'package:habit_quest/shared/widgets/custom_button.dart';
import 'package:habit_quest/shared/widgets/custom_outline_button.dart';
import 'package:habit_quest/shared/widgets/error_message.dart';

class HabitScreen extends StatefulWidget {
  const HabitScreen({super.key});

  @override
  State<HabitScreen> createState() => _HabitScreenState();
}

class _HabitScreenState extends State<HabitScreen> {
  late final SignUpEntity? user;
  late List<HabitModel> localHabits = [];
  late List<HabitEntity> habitEntities = [];

  @override
  void initState() {
    super.initState();

    // Fetch the first user in signUpBox
    user = objectbox.signUpBox.getAll().firstOrNull;

    // Fetch habits
    _fetchHabits();
  }

  Future<void> _fetchHabits() async {
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

  @override
  Widget build(BuildContext context) {
    // Set the status bar color to transparent
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: AppColors.transparent,
      ),
    );

    return Scaffold(
      body: BlocConsumer<HabitBloc, HabitState>(
        listener: (context, state) {
          if (state is HabitFailure) {
            ErrorMessage.show(context, state.error);
          }
        },
        builder: (context, state) {
          if (state is HabitLoading) {
            return const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Center(
                  child: CircularProgressIndicator(
                    color: AppColors.primaryColor,
                    strokeWidth: 2,
                  ),
                ),
              ],
            );
          }

          if (state is HabitsLoaded) {
            // Assign fetched local habits
            localHabits = state.habits;

            // Debugging: Log the updated habits
            log('State habits: ${state.habits}');
            log('Updated local habits after assignment: $localHabits');

            if (localHabits.isEmpty) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 10,
                    right: 10,
                  ),
                  child: CustomOutlineButton(
                    onPressed: () async {
                      await Navigator.pushNamed(
                        context,
                        HabitQuestRouter.createHabitScreenRoute,
                        arguments: user,
                      );
                    },
                    buttonText: '+ Add habits',
                  ),
                ),
              );
            }

            if (localHabits.isNotEmpty) {
              return Padding(
                padding: const EdgeInsets.only(
                  left: 20,
                  top: 40,
                  right: 20,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Habits',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        GestureDetector(
                          onTap: () async {
                            await Navigator.pushNamed(
                              context,
                              HabitQuestRouter.createHabitScreenRoute,
                              arguments: user,
                            );
                          },
                          child: const Text(
                            'Add habits',
                            style: TextStyle(
                              color: AppColors.primaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    // Habits list view
                    Flexible(
                      child: ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        itemCount: localHabits.length,
                        itemBuilder: (context, index) {
                          final habit = localHabits[index];
                          return ListTile(
                            onTap: () async {
                              await Navigator.of(context).pushNamed(
                                HabitQuestRouter.viewHabitScreenRoute,
                                arguments: habit,
                              );
                            },
                            leading: CircleAvatar(
                              radius: 18,
                              backgroundColor:
                                  AppColors.primaryColor.withOpacity(
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
                                habit.description,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            trailing: Text(
                              habit.frequency,
                              style: const TextStyle(
                                color: AppColors.primaryColor,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              );
            }
          }

          return Center(
            child: Padding(
              padding: const EdgeInsets.only(
                left: 10,
                right: 10,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 25,
                    ),
                    child: CustomOutlineButton(
                      onPressed: () async {
                        await Navigator.pushNamed(
                          context,
                          HabitQuestRouter.createHabitScreenRoute,
                          arguments: user,
                        );
                      },
                      buttonText: '+ Add habits',
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  CustomButton(
                    onPressed: () async {
                      log('Fetching habits');
                      context
                          .read<HabitBloc>()
                          .add(FetchHabitsRequested(user!.uid));
                    },
                    buttonText: 'Reload',
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
