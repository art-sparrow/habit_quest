import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_quest/features/decision/presentation/views/decision_screen.dart';
import 'package:habit_quest/features/profile/presentation/blocs/theme_bloc/theme_bloc.dart';
import 'package:habit_quest/features/profile/presentation/blocs/theme_bloc/theme_state.dart';
import 'package:habit_quest/l10n/l10n.dart';
import 'package:habit_quest/shared/utils/router.dart';
import 'package:shared_preferences/shared_preferences.dart';

class App extends StatelessWidget {
  const App({required this.sharedPreferences, super.key});
  // Initialize shared preferences for themes
  final SharedPreferences sharedPreferences;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          theme: state.themeData,
          onGenerateRoute: HabitQuestRouter.handleRoute,
          home: const DecisionScreen(),
        );
      },
    );
  }
}
