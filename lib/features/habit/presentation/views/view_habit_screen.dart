// ignore_for_file: lines_longer_than_80_chars

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_quest/features/habit/data/models/habit_model.dart';
import 'package:habit_quest/features/habit/data/models/progress_model.dart';
import 'package:habit_quest/features/habit/data/models/progress_objectbox.dart';
import 'package:habit_quest/features/habit/presentation/blocs/habit_bloc/habit_bloc.dart';
import 'package:habit_quest/features/habit/presentation/blocs/habit_bloc/habit_event.dart';
import 'package:habit_quest/features/habit/presentation/blocs/habit_bloc/habit_state.dart';
import 'package:habit_quest/main_production.dart';
import 'package:habit_quest/objectbox.g.dart';
import 'package:habit_quest/shared/utils/app_colors.dart';
import 'package:habit_quest/shared/utils/router.dart';
import 'package:habit_quest/shared/widgets/custom_button.dart';
import 'package:habit_quest/shared/widgets/custom_outline_button.dart';
import 'package:habit_quest/shared/widgets/error_message.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class ViewHabitScreen extends StatefulWidget {
  const ViewHabitScreen({required this.habitModel, super.key});

  final HabitModel habitModel;
  @override
  State<ViewHabitScreen> createState() => _ViewHabitScreenState();
}

class _ViewHabitScreenState extends State<ViewHabitScreen> {
  late List<ProgressModel> localProgress = [];
  late List<ProgressEntity> progressEntities = [];
  //calendar variables
  DateTime _selectedDate = DateTime.now();
  // list of progress dates
  late List<DateTime> progressDates = [];

  @override
  void initState() {
    super.initState();

    // Fetch progress
    _fetchProgress();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> _fetchProgress() async {
    // Debugging: Log current progress model
    log('Local habits after conversion: ${widget.habitModel}');

    progressEntities = objectbox.progressBox
        .query(
          ProgressEntity_.habitId.equals(
            widget.habitModel.habitId,
          ),
        )
        .build()
        .find();

    // Debugging: Log progress entities
    log('Local entities: ${progressEntities.toList()}');

    // Convert ProgressEntity to ProgressModel
    localProgress = progressEntities
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

    log('Local progress after conversion: $localProgress');

    // Extract progress dates
    progressDates = localProgress.map((progress) => progress.date).toList();
    log('Progress dates: $progressDates');

    if (localProgress.isEmpty) {
      // Fetch from Firestore if no local progress exist
      log('Fetching progress');
      context.read<HabitBloc>().add(
            FetchProgressRequested(
              widget.habitModel.habitId,
              widget.habitModel.uid,
            ),
          );
    }
  }

  // Function to build the day initials cell
  Widget buildDayInitialCell(String dayInitial) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      alignment: Alignment.center,
      child: Text(
        dayInitial,
        style: const TextStyle(fontSize: 16),
      ),
    );
  }

  // Function to build the calendar cell
  Widget buildProgressCalendarCell(DateTime dateTime, int? day) {
    if (day == null) {
      return Container(); // Empty cell for padding
    }

    final cellDate = DateTime(dateTime.year, dateTime.month, day);
    final isCurrentDay = _selectedDate.year == cellDate.year &&
        _selectedDate.month == cellDate.month &&
        _selectedDate.day == cellDate.day;

    final isProgressDay = progressDates.any(
      (progressDate) =>
          progressDate.year == cellDate.year &&
          progressDate.month == cellDate.month &&
          progressDate.day == cellDate.day,
    );

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedDate = cellDate;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: isCurrentDay
              ? AppColors.primaryColor
              : isProgressDay
                  ? AppColors.primaryColor
                  : AppColors.transparent,
        ),
        child: Text(
          day.toString(),
          style: TextStyle(
            fontSize: 16,
            color: isCurrentDay || isProgressDay
                ? AppColors.white
                : AppColors.grey,
          ),
        ),
      ),
    );
  }

  // Function to build the calendar
  Widget buildProgressCalendar(DateTime dateTime) {
    final daysInMonth = DateTime(dateTime.year, dateTime.month + 1, 0).day;
    var firstWeekDay = DateTime(dateTime.year, dateTime.month).weekday;

    // Adjust the value to start from Sunday (1) instead of Monday (2)
    firstWeekDay = firstWeekDay == 7 ? 1 : firstWeekDay + 1;

    final calendarDays = <List<int?>>[];
    var currentWeek = <int?>[];
    var currentDay = 1;

    // Add empty cells (null) for days before the first day of the month
    for (var i = 1; i < firstWeekDay; i++) {
      currentWeek.add(null);
    }

    // Add days of the month to the calendar
    for (var i = 1; i <= daysInMonth; i++) {
      currentWeek.add(currentDay);
      currentDay++;

      if (currentWeek.length == 7) {
        calendarDays.add(currentWeek);
        currentWeek = [];
      }
    }

    // Add empty cells (null) for days after the last day of the month
    while (currentWeek.length < 7) {
      currentWeek.add(null);
    }

    calendarDays.add(currentWeek);

    return Table(
      children: [
        TableRow(
          children: [
            for (final day in ['S', 'M', 'T', 'W', 'T', 'F', 'S'])
              buildDayInitialCell(day),
          ],
        ),
        for (final week in calendarDays)
          TableRow(
            children: [
              for (final day in week) buildProgressCalendarCell(dateTime, day),
            ],
          ),
      ],
    );
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
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () => Navigator.of(context).pop(),
          child: const Icon(
            LineAwesomeIcons.angle_left_solid,
          ),
        ),
        actions: [
          GestureDetector(
            onTap: () async {
              await Navigator.of(context).pushNamed(
                HabitQuestRouter.updateHabitScreenRoute,
                arguments: widget.habitModel,
              );
            },
            child: const Padding(
              padding: EdgeInsets.only(
                right: 20,
              ),
              child: Text(
                'Edit habit',
                style: TextStyle(
                  color: AppColors.primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
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

          if (state is ProgressLoaded) {
            localProgress = state.progress;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Text(
                    widget.habitModel.name,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                // calendar view
                buildProgressCalendar(_selectedDate),
                const SizedBox(
                  height: 15,
                ),
                /* if (localProgress.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: SizedBox(
                      height: 100,
                      child: ListView.builder(
                        itemCount: localProgress.length,
                        itemBuilder: (context, index) {
                          final progress = localProgress[index];
                          return ListTile(
                            leading: CircleAvatar(
                              radius: 18,
                              backgroundColor: AppColors.transparent,
                              child: Center(
                                child: Image.asset(
                                  AssetsPath.habitQuestLogo,
                                  height: 24,
                                  width: 24,
                                ),
                              ),
                            ),
                            title: SizedBox(
                              width: 90,
                              child: Text(
                                '${progress.habitId}',
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
                                '${progress.date}',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            trailing: GestureDetector(
                              onTap: progress.synced
                                  ? () {}
                                  : () async {
                                      context.read<HabitBloc>().add(
                                            SyncProgressRequested(
                                              progress,
                                            ),
                                          );
                                    },
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(right: 8),
                                    child: Text(
                                      progress.synced ? 'Synced' : 'Synced',
                                      style: TextStyle(
                                        color: progress.synced
                                            ? AppColors.primaryColor
                                            : AppColors.red,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ), */
                const SizedBox(height: 15),
                // start habit button
                CustomButton(
                  onPressed: () async {
                    await Navigator.of(context).pushNamed(
                      HabitQuestRouter.createProgressScreenRoute,
                      arguments: widget.habitModel,
                    );
                  },
                  buttonText: 'Start habit',
                  isLoading: state is HabitLoading,
                ),
              ],
            );
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
                        log('Reloading');
                        context.read<HabitBloc>().add(
                              FetchProgressRequested(
                                widget.habitModel.habitId,
                                widget.habitModel.uid,
                              ),
                            );
                      },
                      buttonText: 'Reload',
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  CustomButton(
                    onPressed: () async {
                      await Navigator.of(context).pushNamed(
                        HabitQuestRouter.createProgressScreenRoute,
                        arguments: widget.habitModel,
                      );
                    },
                    buttonText: 'Start habit',
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
