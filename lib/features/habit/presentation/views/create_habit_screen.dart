// ignore_for_file: lines_longer_than_80_chars

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_quest/features/auth/data/models/signup_objectbox.dart';
import 'package:habit_quest/features/habit/data/models/habit_model.dart';
import 'package:habit_quest/features/habit/presentation/blocs/habit_bloc/habit_bloc.dart';
import 'package:habit_quest/features/habit/presentation/blocs/habit_bloc/habit_event.dart';
import 'package:habit_quest/features/habit/presentation/blocs/habit_bloc/habit_state.dart';
import 'package:habit_quest/features/profile/presentation/blocs/theme_bloc/theme_bloc.dart';
import 'package:habit_quest/features/profile/presentation/blocs/theme_bloc/theme_state.dart';
import 'package:habit_quest/shared/services/notification_service.dart';
import 'package:habit_quest/shared/utils/app_colors.dart';
import 'package:habit_quest/shared/utils/router.dart';
import 'package:habit_quest/shared/widgets/custom_button.dart';
import 'package:habit_quest/shared/widgets/custom_textfield.dart';
import 'package:habit_quest/shared/widgets/error_message.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class CreateHabitScreen extends StatefulWidget {
  const CreateHabitScreen({required this.user, super.key});

  final SignUpEntity user;
  @override
  State<CreateHabitScreen> createState() => _CreateHabitScreenState();
}

class _CreateHabitScreenState extends State<CreateHabitScreen> {
  // Text editing controllers
  final nameController = TextEditingController();
  final descriptionController = TextEditingController();
  // Form key
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  // Selected end date
  DateTime _selectedEndDate = DateTime.now();
  // Selected frequency
  String selectedFrequency = 'Daily';
  final List<String> frequencies = ['Daily', 'Weekly', 'Monthly'];

  // Focus nodes
  final FocusNode _nameFocusNode = FocusNode();
  final FocusNode _descriptionFocusNode = FocusNode();

  void _onFocusChange() {
    setState(() {
      // Trigger rebuild
    });
  }

  @override
  void initState() {
    _nameFocusNode.addListener(_onFocusChange);
    _descriptionFocusNode.addListener(_onFocusChange);
    super.initState();
  }

  @override
  void dispose() {
    // Remove listeners
    _nameFocusNode.removeListener(_onFocusChange);
    _descriptionFocusNode.removeListener(_onFocusChange);
    // Dispose listeners
    _nameFocusNode.dispose();
    _descriptionFocusNode.dispose();
    super.dispose();
  }

  // Create habit
  void _createHabit() {
    if (_formKey.currentState!.validate()) {
      // date validation
      if (_selectedEndDate.isBefore(DateTime.now())) {
        ErrorMessage.show(context, 'End date should be after today');
        return;
      }

      // Create habit model with form data
      final habitModel = HabitModel(
        habitId: DateTime.now().millisecondsSinceEpoch % 10000,
        name: nameController.text.trim(),
        description: descriptionController.text.trim(),
        frequency: selectedFrequency,
        startDate: DateTime.now(),
        endDate: _selectedEndDate,
        synced: false,
        uid: widget.user.uid,
        email: widget.user.email,
      );
      // Trigger create habit event
      context.read<HabitBloc>().add(CreateHabitRequested(habitModel));
    }
  }

  Future<void> _selectEndDate(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: AppColors.primaryColor,
            colorScheme: const ColorScheme.light(
              primary: AppColors.primaryColor,
            ),
            buttonTheme: const ButtonThemeData(
              textTheme: ButtonTextTheme.primary,
            ),
          ),
          child: child!,
        );
      },
      initialDate: _selectedEndDate,
      firstDate: DateTime(2007),
      lastDate: DateTime(2100),
      barrierDismissible: false,
    );
    if (picked != null && picked != _selectedEndDate) {
      setState(() {
        _selectedEndDate = picked;
      });
    }
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
      ),
      body: BlocConsumer<HabitBloc, HabitState>(
        listener: (context, state) {
          if (state is HabitFailure) {
            ErrorMessage.show(context, state.error);
          }
          if (state is HabitsLoaded) {
            // Show notification
            NotificationService().showNotification(
              id: 4,
              title: 'Habit created',
              message: 'Habit was added successfully!',
            );

            // Navigate to the landing screen
            Navigator.pushNamed(
              context,
              HabitQuestRouter.landingScreenRoute,
            );
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 25),
                    child: Text(
                      'Habit description',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  // habit name textfield
                  CustomTextField(
                    controller: nameController,
                    labelText: 'Habit name*',
                    prefixIcon: LineAwesomeIcons.swimmer_solid,
                    focusNode: _nameFocusNode,
                    keyboardType: TextInputType.text,
                    isLoading: state is HabitLoading,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "What's the habit name?";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 15),
                  // habit description textfield
                  CustomTextField(
                    controller: descriptionController,
                    labelText: 'Description*',
                    prefixIcon: LineAwesomeIcons.swimmer_solid,
                    focusNode: _descriptionFocusNode,
                    keyboardType: TextInputType.text,
                    isLoading: state is HabitLoading,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "What's the description?";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 15),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 25),
                    child: Text(
                      'End date',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  // end date
                  BlocBuilder<ThemeBloc, ThemeState>(
                    builder: (context, state) {
                      // Switch icon based on the theme
                      final isDarkTheme =
                          state.themeData.brightness == Brightness.dark;
                      return GestureDetector(
                        onTap: () async {
                          await _selectEndDate(context);
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 25,
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Stack(
                                  clipBehavior: Clip.none,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 12,
                                        vertical: 12,
                                      ),
                                      height: 60,
                                      decoration: BoxDecoration(
                                        color: isDarkTheme
                                            ? AppColors.black
                                            : AppColors.white,
                                        borderRadius: BorderRadius.circular(15),
                                        border: Border.fromBorderSide(
                                          BorderSide(
                                            color: AppColors.grey.withOpacity(
                                              0.5,
                                            ),
                                            width: 0.7,
                                          ),
                                        ),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            _selectedEndDate
                                                    .toString()
                                                    .isNotEmpty
                                                ? ('${_selectedEndDate.day}-'
                                                    '${_selectedEndDate.month}-'
                                                    '${_selectedEndDate.year}')
                                                : 'Add end date',
                                            style: const TextStyle(
                                              color: Colors.grey,
                                            ),
                                          ),
                                          const Padding(
                                            padding: EdgeInsets.only(
                                              left: 2,
                                              right: 2,
                                            ),
                                            child: Icon(
                                              LineAwesomeIcons.angle_down_solid,
                                              color: Colors.grey,
                                              size: 16,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Positioned(
                                      top: -9,
                                      left: 5,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: isDarkTheme
                                              ? AppColors.black
                                              : AppColors.white,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: Text(
                                          ' End date* ',
                                          style: TextStyle(
                                            color: isDarkTheme
                                                ? AppColors.grey
                                                : AppColors.grey,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 25),
                    child: Text(
                      'Frequency',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  // frequency
                  Flexible(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: frequencies.length,
                      itemBuilder: (context, index) {
                        final currentFrequency = frequencies[index];
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedFrequency = currentFrequency;
                            });
                          },
                          child: ListTile(
                            leading: selectedFrequency == currentFrequency
                                ? const Icon(
                                    Icons.radio_button_checked,
                                    color: AppColors.primaryColor,
                                  )
                                : const Icon(
                                    Icons.radio_button_off_outlined,
                                    color: AppColors.primaryColor,
                                  ),
                            title: Text(currentFrequency),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  // create habit button
                  CustomButton(
                    onPressed: _createHabit,
                    buttonText: 'Create',
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
