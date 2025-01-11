import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_quest/features/profile/presentation/blocs/theme_bloc/theme_bloc.dart';
import 'package:habit_quest/features/profile/presentation/blocs/theme_bloc/theme_state.dart';
import 'package:habit_quest/shared/services/notification_settings_service.dart';
import 'package:habit_quest/shared/utils/app_colors.dart';
import 'package:habit_quest/shared/widgets/selection_tile.dart';
import 'package:habit_quest/shared/widgets/success_message.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class NotificationSettingsScreen extends StatefulWidget {
  const NotificationSettingsScreen({super.key});

  @override
  State<NotificationSettingsScreen> createState() =>
      _NotificationSettingsScreenState();
}

class _NotificationSettingsScreenState
    extends State<NotificationSettingsScreen> {
  // Notification status boolean
  bool _areNotificationsEnabled = false;

  @override
  void initState() {
    super.initState();
    _checkNotificationStatus();
  }

  Future<void> _checkNotificationStatus() async {
    final enabled = await NotificationSettingsService.areNotificationsEnabled();
    setState(() {
      _areNotificationsEnabled = enabled;
    });
  }

  Future<void> _openSettings() async {
    Navigator.of(context).pop();
    await NotificationSettingsService.openNotificationSettings();
    // Re-check status after returning from settings
    await _checkNotificationStatus();
  }

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
                  // Settings
                  const Text(
                    'Notification settings',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryColor,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  // Enable option
                  SelectionTile(
                    onTap: _areNotificationsEnabled
                        ? () {
                            SuccessMessage.show(
                              context,
                              'Notifications are enabled',
                            );
                            Navigator.of(context).pop();
                          }
                        : _openSettings,
                    icon: Icon(
                      _areNotificationsEnabled
                          ? Icons.check_circle
                          : Icons.circle_outlined,
                      color: AppColors.primaryColor,
                    ),
                    title: Text(
                      'Enable',
                      style: state.themeData.textTheme.titleMedium,
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  // Disable option
                  SelectionTile(
                    onTap: !_areNotificationsEnabled
                        ? () {
                            SuccessMessage.show(
                              context,
                              'Notifications are disabled',
                            );
                            Navigator.of(context).pop();
                          }
                        : _openSettings,
                    icon: Icon(
                      !_areNotificationsEnabled
                          ? Icons.check_circle
                          : Icons.circle_outlined,
                      color: AppColors.primaryColor,
                    ),
                    title: Text(
                      'Disable',
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
