import 'package:flutter/material.dart';
import 'package:habit_quest/app/app.dart';
import 'package:habit_quest/bootstrap.dart';
import 'package:habit_quest/shared/helpers/objectbox.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Initialize ObjectBox
late final ObjectBox objectbox;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Initialize SharedPreferences
  final prefs = await SharedPreferences.getInstance();
  await bootstrap(
    () => App(
      sharedPreferences: prefs,
    ),
  );
}
