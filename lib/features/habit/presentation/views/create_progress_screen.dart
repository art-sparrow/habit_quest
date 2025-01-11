import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_quest/features/habit/data/models/habit_model.dart';
import 'package:habit_quest/features/habit/data/models/progress_model.dart';
import 'package:habit_quest/features/habit/presentation/blocs/habit_bloc/habit_bloc.dart';
import 'package:habit_quest/features/habit/presentation/blocs/habit_bloc/habit_event.dart';
import 'package:habit_quest/features/habit/presentation/blocs/habit_bloc/habit_state.dart';
import 'package:habit_quest/shared/services/notification_service.dart';
import 'package:habit_quest/shared/utils/app_colors.dart';
import 'package:habit_quest/shared/widgets/custom_button.dart';
import 'package:habit_quest/shared/widgets/error_message.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class CreateProgressScreen extends StatefulWidget {
  const CreateProgressScreen({required this.habitModel, super.key});

  final HabitModel habitModel;

  @override
  State<CreateProgressScreen> createState() => _CreateProgressScreenState();
}

class _CreateProgressScreenState extends State<CreateProgressScreen> {
  Timer? _timer;
  late int _elapsedSeconds = 0;
  bool _isTimerRunning = false;

  @override
  void initState() {
    super.initState();
    _timer = null;
    _elapsedSeconds = 0;
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startTimer() {
    setState(() {
      _isTimerRunning = true;
    });

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _elapsedSeconds++;
      });
    });
  }

  void _stopTimer() {
    _timer?.cancel();
    setState(() {
      _isTimerRunning = false;
    });
  }

  String _formatElapsedTime(int elapsedSeconds) {
    final hours = elapsedSeconds ~/ 3600;
    final minutes = (elapsedSeconds % 3600) ~/ 60;
    final seconds = elapsedSeconds % 60;
    return '${hours.toString().padLeft(2, '0')}:'
        '${minutes.toString().padLeft(2, '0')}:'
        '${seconds.toString().padLeft(2, '0')}';
  }

  Future<void> _completeProgress() async {
    _stopTimer();
    _elapsedSeconds = 0;

    final progressModel = ProgressModel(
      habitId: widget.habitModel.habitId,
      date: DateTime.now(),
      completed: true,
      synced: false,
      uid: widget.habitModel.uid,
      email: widget.habitModel.email,
    );
    context.read<HabitBloc>().add(CreateProgressRequested(progressModel));
    await NotificationService().showNotification(
      id: 9,
      title: widget.habitModel.name,
      message: 'Progress recorded successfully',
    );
  }

  @override
  Widget build(BuildContext context) {
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
      ),
      body: BlocConsumer<HabitBloc, HabitState>(
        listener: (context, state) {
          if (state is HabitFailure) {
            ErrorMessage.show(context, state.error);
          }
          if (state is HabitLoading) {
            _stopTimer(); // Stop the timer when loading starts
          }
        },
        builder: (context, state) {
          if (state is HabitLoading) {
            return const Center(
              child: CircularProgressIndicator(
                color: AppColors.primaryColor,
                strokeWidth: 2,
              ),
            );
          }

          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Timer display
                  Center(
                    child: Text(
                      _formatElapsedTime(_elapsedSeconds),
                      style: const TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primaryColor,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: Center(
                      child: Text(
                        widget.habitModel.name,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Start/Complete button
                  CustomButton(
                    onPressed: state is HabitLoading
                        ? () {}
                        : () {
                            if (_isTimerRunning) {
                              _completeProgress();
                            } else {
                              _startTimer();
                            }
                          },
                    buttonText: _isTimerRunning ? 'Complete' : 'Start',
                    isLoading: state is HabitLoading,
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
