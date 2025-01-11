import 'package:flutter/material.dart';
import 'package:habit_quest/features/auth/data/models/signup_objectbox.dart';
import 'package:habit_quest/features/auth/presentation/views/reset_pwd_screen.dart';
import 'package:habit_quest/features/auth/presentation/views/signin_screen.dart';
import 'package:habit_quest/features/auth/presentation/views/signup_screen.dart';
import 'package:habit_quest/features/decision/presentation/views/decision_screen.dart';
import 'package:habit_quest/features/habit/data/models/habit_model.dart';
import 'package:habit_quest/features/habit/presentation/views/create_habit_screen.dart';
import 'package:habit_quest/features/habit/presentation/views/create_progress_screen.dart';
import 'package:habit_quest/features/habit/presentation/views/update_habit_screen.dart';
import 'package:habit_quest/features/habit/presentation/views/view_habit_screen.dart';
import 'package:habit_quest/features/landing/presentation/views/landing_screen.dart';
import 'package:habit_quest/features/profile/presentation/views/change_theme.dart';
import 'package:habit_quest/features/profile/presentation/views/notification_settings.dart';
import 'package:page_transition/page_transition.dart';

class HabitQuestRouter {
  static const String changeThemeScreenRoute = 'select-theme';
  static const String createHabitScreenRoute = 'create-habit';
  static const String createProgressScreenRoute = 'create-progress';
  static const String decisionScreenRoute = 'decision-screen';
  static const String landingScreenRoute = 'landing-screen';
  static const String notificationsScreenRoute = 'notifications-screen';
  static const String signInScreenRoute = 'signIn-screen';
  static const String signUpScreenRoute = 'signUp-screen';
  static const String resetPwdScreenRoute = 'resetPwd-screen';
  static const String viewHabitScreenRoute = 'viewHabit-screen';
  static const String updateHabitScreenRoute = 'updateHabit-screen';

  static Route<dynamic>? handleRoute(RouteSettings settings) {
    switch (settings.name) {
      case changeThemeScreenRoute:
        return PageTransition(
          type: PageTransitionType.rightToLeft,
          child: const ChangeThemeScreen(),
        );
      case createHabitScreenRoute:
        final user = settings.arguments as SignUpEntity?;
        return PageTransition(
          type: PageTransitionType.rightToLeft,
          child: CreateHabitScreen(user: user!),
        );
      case createProgressScreenRoute:
        final habitModel = settings.arguments as HabitModel?;
        return PageTransition(
          type: PageTransitionType.rightToLeft,
          child: CreateProgressScreen(habitModel: habitModel!),
        );
      case decisionScreenRoute:
        return PageTransition(
          type: PageTransitionType.rightToLeft,
          child: const DecisionScreen(),
        );
      case landingScreenRoute:
        return PageTransition(
          type: PageTransitionType.rightToLeft,
          child: const LandingScreen(),
        );
      case notificationsScreenRoute:
        return PageTransition(
          type: PageTransitionType.rightToLeft,
          child: const NotificationSettingsScreen(),
        );
      case signInScreenRoute:
        return PageTransition(
          type: PageTransitionType.bottomToTop,
          child: const SignInScreen(),
        );
      case signUpScreenRoute:
        return PageTransition(
          type: PageTransitionType.bottomToTop,
          child: const SignUpScreen(),
        );
      case resetPwdScreenRoute:
        return PageTransition(
          type: PageTransitionType.rightToLeft,
          child: const ResetPwdScreen(),
        );
      case updateHabitScreenRoute:
        final habitModel = settings.arguments as HabitModel?;
        return PageTransition(
          type: PageTransitionType.rightToLeft,
          child: UpdateHabitScreen(habitModel: habitModel!),
        );
      case viewHabitScreenRoute:
        final habitModel = settings.arguments as HabitModel?;
        return PageTransition(
          type: PageTransitionType.rightToLeft,
          child: ViewHabitScreen(habitModel: habitModel!),
        );
    }
    return null;
  }
}
