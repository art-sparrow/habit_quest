import 'package:flutter/material.dart';
import 'package:habit_quest/features/auth/presentation/views/reset_pwd_screen.dart';
import 'package:habit_quest/features/auth/presentation/views/signin_screen.dart';
import 'package:habit_quest/features/auth/presentation/views/signup_screen.dart';
import 'package:habit_quest/features/decision/presentation/views/decision_screen.dart';
import 'package:habit_quest/features/landing/presentation/views/landing_screen.dart';
import 'package:habit_quest/features/profile/presentation/views/change_theme.dart';
import 'package:page_transition/page_transition.dart';

class HabitQuestRouter {
  static const String changeThemeScreenRoute = 'select-theme';
  static const String decisionScreenRoute = 'decision-screen';
  static const String landingScreenRoute = 'landing-screen';
  static const String signInScreenRoute = 'signIn-screen';
  static const String signUpScreenRoute = 'signUp-screen';
  static const String resetPwdScreenRoute = 'resetPwd-screen';

  static Route<dynamic>? handleRoute(RouteSettings settings) {
    switch (settings.name) {
      case changeThemeScreenRoute:
        return PageTransition(
          type: PageTransitionType.rightToLeft,
          child: const ChangeThemeScreen(),
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
    }
    return null;
  }
}
