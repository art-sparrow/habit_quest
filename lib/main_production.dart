import 'package:habit_quest/app/app.dart';
import 'package:habit_quest/bootstrap.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  // Initialize SharedPreferences
  final prefs = await SharedPreferences.getInstance();
  await bootstrap(
    () => App(
      sharedPreferences: prefs,
    ),
  );
}
