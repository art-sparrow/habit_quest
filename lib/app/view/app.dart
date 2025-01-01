import 'package:flutter/material.dart';
import 'package:habit_quest/features/decision/presentation/decision_screen.dart';
import 'package:habit_quest/l10n/l10n.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: DecisionScreen(),
    );
  }
}
