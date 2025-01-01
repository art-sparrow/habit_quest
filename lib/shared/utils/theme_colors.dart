import 'package:flutter/material.dart';
import 'package:habit_quest/shared/utils/app_colors.dart';

class ThemeColors {
  ThemeColors({
    required this.whiteColor,
    required this.blackColor,
    required this.greyColor,
    required this.backgroundColor,
    required this.textColor,
    required this.transparentColor,
    required this.primaryColor,
    required this.errorColor,
    required this.successColor,
  });

  final Color whiteColor;
  final Color blackColor;
  final Color greyColor;
  final Color backgroundColor;
  final Color textColor;
  final Color transparentColor;
  final Color primaryColor;
  final Color errorColor;
  final Color successColor;

  // Light color theme
  static final lightThemeColors = ThemeColors(
    whiteColor: AppColors.white,
    blackColor: AppColors.black,
    greyColor: AppColors.grey,
    backgroundColor: AppColors.white,
    textColor: AppColors.black,
    transparentColor: AppColors.transparent,
    primaryColor: AppColors.primaryColor,
    successColor: AppColors.primaryColorLight,
    errorColor: AppColors.red,
  );

  // Dark color theme
  static final darkThemeColors = ThemeColors(
    whiteColor: AppColors.black,
    blackColor: AppColors.black,
    greyColor: AppColors.grey,
    backgroundColor: AppColors.black,
    textColor: AppColors.white,
    transparentColor: AppColors.transparent,
    primaryColor: AppColors.primaryColor,
    successColor: AppColors.primaryColorLight,
    errorColor: AppColors.red,
  );
}
