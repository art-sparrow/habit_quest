import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_quest/features/profile/presentation/blocs/theme_bloc/theme_bloc.dart';
import 'package:habit_quest/features/profile/presentation/blocs/theme_bloc/theme_event.dart';
import 'package:habit_quest/features/profile/presentation/blocs/theme_bloc/theme_state.dart';
import 'package:habit_quest/shared/utils/app_colors.dart';
import 'package:habit_quest/shared/widgets/selection_tile.dart';
import 'package:habit_quest/shared/widgets/success_message.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class ChangeThemeScreen extends StatefulWidget {
  const ChangeThemeScreen({super.key});

  @override
  State<ChangeThemeScreen> createState() => _ChangeThemeScreenState();
}

class _ChangeThemeScreenState extends State<ChangeThemeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: Navigator.of(context).pop,
          child: const Icon(
            LineAwesomeIcons.angle_left_solid,
          ),
        ),
      ),
      body: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, state) {
          // Check if the current theme is dark or light
          final isDarkTheme = state.themeData.brightness == Brightness.dark;
          // Access the shared preference 'isDeviceTheme' boolean
          final isDeviceTheme = state.isDeviceTheme;

          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.only(
                left: 20,
                right: 20,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Theme options
                  const Text(
                    'Change theme',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryColor,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  // Light theme option
                  SelectionTile(
                    onTap: () {
                      if (isDeviceTheme || isDarkTheme) {
                        context.read<ThemeBloc>().add(SwitchToLightTheme());
                      }
                      SuccessMessage.show(context, 'Switched to light theme!');
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      isDeviceTheme
                          ? Icons.circle_outlined
                          : isDarkTheme
                              ? Icons.circle_outlined
                              : Icons.check_circle,
                      color: AppColors.primaryColor,
                    ),
                    title: Text(
                      'Lights on',
                      style: state.themeData.textTheme.titleMedium,
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  // Dark theme option
                  SelectionTile(
                    onTap: () {
                      if (isDeviceTheme || !isDarkTheme) {
                        context.read<ThemeBloc>().add(SwitchToDarkTheme());
                      }
                      SuccessMessage.show(context, 'Switched to dark theme!');
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      isDeviceTheme
                          ? Icons.circle_outlined
                          : isDarkTheme
                              ? Icons.check_circle
                              : Icons.circle_outlined,
                      color: AppColors.primaryColor,
                    ),
                    title: Text(
                      'Lights out',
                      style: state.themeData.textTheme.titleMedium,
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  // Device theme option
                  SelectionTile(
                    onTap: () {
                      context.read<ThemeBloc>().add(SwitchToDeviceTheme());
                      SuccessMessage.show(context, 'Switched to device theme!');
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      isDeviceTheme
                          ? Icons.check_circle
                          : Icons.circle_outlined,
                      color: AppColors.primaryColor,
                    ),
                    title: Text(
                      'Device theme',
                      style: state.themeData.textTheme.titleMedium,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
