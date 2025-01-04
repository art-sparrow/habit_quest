// ignore_for_file: lines_longer_than_80_chars

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:habit_quest/app/view/app.dart';
import 'package:habit_quest/features/decision/presentation/views/decision_screen.dart';
import 'package:habit_quest/features/profile/presentation/blocs/theme_bloc/theme_bloc.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Generate the Mock class for SharedPreferences
// Run the following to generate the mock file:
// flutter pub run build_runner build --delete-conflicting-outputs
// After `app_test.mocks.dart` is generated run the following:
// flutter test test/app/view/app_test.dart
// You may also run all the tests with the following:
// flutter test
// Output:
// $ flutter test test/app/view/app_test.dart
// 00:06 +1: All tests passed!

import 'app_test.mocks.dart';

@GenerateMocks([SharedPreferences])
void main() {
  group('App with SharedPreferences', () {
    // Test if DecisionScreen loads correctly
    testWidgets(
        'renders DecisionScreen successfully with SharedPreferences and ThemeBloc',
        (tester) async {
      // Create a mock SharedPreferences instance
      final mockSharedPreferences = MockSharedPreferences();

      // Mock SharedPreferences behavior
      when(mockSharedPreferences.getBool(any))
          .thenReturn(false); // Default to light theme

      // Initialize the ThemeBloc with the mocked SharedPreferences
      final themeBloc = ThemeBloc(sharedPreferences: mockSharedPreferences);

      // Build the app with the ThemeBloc and mocked SharedPreferences
      await tester.pumpWidget(
        BlocProvider.value(
          value: themeBloc,
          child: App(sharedPreferences: mockSharedPreferences),
        ),
      );

      // Verify that the DecisionScreen renders
      expect(find.byType(DecisionScreen), findsOneWidget);
    });
  });
}
