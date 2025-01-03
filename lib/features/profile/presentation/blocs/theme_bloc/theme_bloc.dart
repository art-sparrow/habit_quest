import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_quest/features/profile/presentation/blocs/theme_bloc/theme_event.dart';
import 'package:habit_quest/features/profile/presentation/blocs/theme_bloc/theme_state.dart';
import 'package:habit_quest/shared/utils/theme_colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc({required this.sharedPreferences})
      : super(_getInitialTheme(sharedPreferences)) {
    on<SwitchToLightTheme>(_onSwitchToLightTheme);
    on<SwitchToDarkTheme>(_onSwitchToDarkTheme);
    on<SwitchToDeviceTheme>(_onSwitchToDeviceTheme);
  }
  final SharedPreferences sharedPreferences;

  // Define a key for storing theme preference
  static const String prefKey = 'theme_preference';

  // Get the initial theme from SharedPreferences and update the isDeviceTheme
  static ThemeState _getInitialTheme(SharedPreferences prefs) {
    final isDeviceTheme = prefs.getBool('isDeviceTheme') ?? false;
    final deviceBrightness = PlatformDispatcher.instance.platformBrightness;
    final isDarkTheme = prefs.getBool(prefKey) ?? false;
    final themeData = isDeviceTheme
        ? deviceBrightness == Brightness.dark
            ? _buildDarkTheme()
            : _buildLightTheme()
        : isDarkTheme
            ? _buildDarkTheme()
            : _buildLightTheme();
    return ThemeState(themeData: themeData, isDeviceTheme: isDeviceTheme);
  }

  // Event handler for switching to light theme
  Future<void> _onSwitchToLightTheme(
    SwitchToLightTheme event,
    Emitter<ThemeState> emit,
  ) async {
    emit(ThemeState(themeData: _buildLightTheme()));
    // Save preference
    await sharedPreferences.setBool(prefKey, false);
    //Reset device theme
    await sharedPreferences.setBool('isDeviceTheme', false);
  }

  // Event handler for switching to dark theme
  Future<void> _onSwitchToDarkTheme(
    SwitchToDarkTheme event,
    Emitter<ThemeState> emit,
  ) async {
    emit(ThemeState(themeData: _buildDarkTheme()));
    // Save preference
    await sharedPreferences.setBool(prefKey, true);
    //Reset device theme
    await sharedPreferences.setBool('isDeviceTheme', false);
  }

  // Event handler for switching to device theme
  Future<void> _onSwitchToDeviceTheme(
    SwitchToDeviceTheme event,
    Emitter<ThemeState> emit,
  ) async {
    final deviceBrightness = PlatformDispatcher.instance.platformBrightness;
    final isDarkMode = deviceBrightness == Brightness.dark;
    emit(
      ThemeState(
        themeData: isDarkMode ? _buildDarkTheme() : _buildLightTheme(),
        isDeviceTheme: true,
      ),
    );
    await sharedPreferences.setBool('isDeviceTheme', true);
  }

  // Light theme
  static ThemeData _buildLightTheme() {
    final colors = ThemeColors.lightThemeColors;
    return ThemeData(
      // set ThemeData brightness to light
      brightness: Brightness.light,
      // Scaffold colors
      scaffoldBackgroundColor: colors.backgroundColor,
      primaryColor: colors.primaryColor,
      // Appbar colors
      appBarTheme: AppBarTheme(
        backgroundColor: colors.backgroundColor,
        surfaceTintColor: colors.transparentColor,
        elevation: 0,
        iconTheme: IconThemeData(color: colors.greyColor),
      ),
      // Text colors
      textTheme: TextTheme(
        displayLarge: TextStyle(
          color: colors.textColor,
          fontSize: 36,
          fontWeight: FontWeight.bold,
        ),
        displayMedium: TextStyle(color: colors.textColor, fontSize: 32),
        displaySmall: TextStyle(color: colors.textColor, fontSize: 28),
        headlineLarge: TextStyle(
          color: colors.textColor,
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
        headlineMedium: TextStyle(color: colors.textColor, fontSize: 22),
        headlineSmall: TextStyle(color: colors.textColor, fontSize: 20),
        titleLarge: TextStyle(
          color: colors.textColor,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
        titleMedium: TextStyle(color: colors.textColor, fontSize: 16),
        titleSmall: TextStyle(color: colors.textColor, fontSize: 14),
        bodyLarge: TextStyle(color: colors.textColor, fontSize: 16),
        bodyMedium: TextStyle(color: colors.textColor, fontSize: 14),
        bodySmall: TextStyle(color: colors.textColor, fontSize: 12),
        labelLarge: TextStyle(
          color: colors.textColor,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
        labelMedium: TextStyle(color: colors.textColor, fontSize: 14),
        labelSmall: TextStyle(color: colors.textColor, fontSize: 12),
      ),
      // Bottomsheet colors
      bottomSheetTheme: BottomSheetThemeData(
        modalBarrierColor: colors.transparentColor,
        elevation: 7,
        backgroundColor: colors.backgroundColor,
      ),
    );
  }

  // Dark theme
  static ThemeData _buildDarkTheme() {
    final colors = ThemeColors.darkThemeColors;
    return ThemeData(
      // Set ThemeData brightness to dark
      brightness: Brightness.dark,
      // Scaffold colors
      scaffoldBackgroundColor: colors.backgroundColor,
      primaryColor: colors.primaryColor,
      // Appbar colors
      appBarTheme: AppBarTheme(
        backgroundColor: colors.backgroundColor,
        surfaceTintColor: colors.transparentColor,
        elevation: 0,
        iconTheme: IconThemeData(color: colors.greyColor),
      ),
      // Text colors
      textTheme: TextTheme(
        displayLarge: TextStyle(
          color: colors.textColor,
          fontSize: 36,
          fontWeight: FontWeight.bold,
        ),
        displayMedium: TextStyle(color: colors.textColor, fontSize: 32),
        displaySmall: TextStyle(color: colors.textColor, fontSize: 28),
        headlineLarge: TextStyle(
          color: colors.textColor,
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
        headlineMedium: TextStyle(color: colors.textColor, fontSize: 22),
        headlineSmall: TextStyle(color: colors.textColor, fontSize: 20),
        titleLarge: TextStyle(
          color: colors.textColor,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
        titleMedium: TextStyle(color: colors.textColor, fontSize: 16),
        titleSmall: TextStyle(color: colors.textColor, fontSize: 14),
        bodyLarge: TextStyle(color: colors.textColor, fontSize: 16),
        bodyMedium: TextStyle(color: colors.textColor, fontSize: 14),
        bodySmall: TextStyle(color: colors.textColor, fontSize: 12),
        labelLarge: TextStyle(
          color: colors.textColor,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
        labelMedium: TextStyle(color: colors.textColor, fontSize: 14),
        labelSmall: TextStyle(color: colors.textColor, fontSize: 12),
      ),
      // Bottomsheet colors
      bottomSheetTheme: BottomSheetThemeData(
        modalBarrierColor: colors.transparentColor,
        elevation: 7,
        backgroundColor: colors.backgroundColor,
      ),
    );
  }
}
