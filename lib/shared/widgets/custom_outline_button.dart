// ignore_for_file: prefer_const_constructors, file_names, use_super_parameters

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_quest/features/profile/presentation/blocs/theme_bloc/theme_bloc.dart';
import 'package:habit_quest/features/profile/presentation/blocs/theme_bloc/theme_state.dart';
import 'package:habit_quest/shared/utils/app_colors.dart';

class CustomOutlineButton extends StatelessWidget {
  const CustomOutlineButton({
    required this.onPressed,
    required this.buttonText,
    this.isLoading = false,
    this.buttonColor = AppColors.red,
    this.useButtonColor = false,
    Key? key,
  }) : super(key: key);

  final VoidCallback onPressed;
  final String buttonText;
  final bool isLoading;
  final bool useButtonColor;
  final Color buttonColor;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        // Switch color based on the theme
        final isDarkTheme = state.themeData.brightness == Brightness.dark;
        return ElevatedButton(
          onPressed: isLoading ? () {} : onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: !isDarkTheme ? AppColors.white : AppColors.black,
            foregroundColor:
                useButtonColor ? buttonColor : AppColors.primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
              side: BorderSide(
                color: useButtonColor ? buttonColor : AppColors.primaryColor,
              ),
            ),
            minimumSize: Size(350, 60),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (isLoading)
                SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(
                    color:
                        useButtonColor ? buttonColor : AppColors.primaryColor,
                    strokeWidth: 2,
                  ),
                )
              else
                Text(
                  buttonText,
                  style: TextStyle(
                    color:
                        useButtonColor ? buttonColor : AppColors.primaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
