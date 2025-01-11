import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_quest/features/auth/data/models/signup_objectbox.dart';
import 'package:habit_quest/features/profile/presentation/blocs/signout_bloc/signout_bloc.dart';
import 'package:habit_quest/features/profile/presentation/blocs/signout_bloc/signout_event.dart';
import 'package:habit_quest/features/profile/presentation/blocs/signout_bloc/signout_state.dart';
import 'package:habit_quest/features/profile/presentation/blocs/theme_bloc/theme_bloc.dart';
import 'package:habit_quest/features/profile/presentation/blocs/theme_bloc/theme_state.dart';
import 'package:habit_quest/main_production.dart';
import 'package:habit_quest/shared/constants/assets_path.dart';
import 'package:habit_quest/shared/utils/app_colors.dart';
import 'package:habit_quest/shared/utils/router.dart';
import 'package:habit_quest/shared/widgets/error_message.dart';
import 'package:habit_quest/shared/widgets/menu_option.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late final SignUpEntity? user;

  @override
  void initState() {
    // Fetch the first user in signUpBox
    user = objectbox.signUpBox.getAll().firstOrNull;
    super.initState();
  }

  void _signOut() {
    // Trigger sign out event
    context.read<SignOutBloc>().add(const SignOutRequested());
  }

  @override
  Widget build(BuildContext context) {
    //set the status bar color to transparent
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: AppColors.transparent,
      ),
    );
    //define gradient
    final linearGradient = const LinearGradient(
      colors: <Color>[AppColors.primaryColorLight, AppColors.primaryColor],
    ).createShader(const Rect.fromLTWH(0, 0, 200, 70));
    return Scaffold(
      body: BlocConsumer<SignOutBloc, SignOutState>(
        listener: (context, state) {
          if (state is SignOutInitial) {}
          if (state is SignOutFailure) {
            ErrorMessage.show(context, state.errorMessage);
          }
          if (state is SignOutSuccess) {
            // Navigate to the sign in screen
            Navigator.pushNamed(
              context,
              HabitQuestRouter.signInScreenRoute,
            );
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Center(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 20,
                      right: 20,
                      top: 50,
                      bottom: 100,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        //profile picture
                        const CircleAvatar(
                          backgroundColor: AppColors.transparent,
                          radius: 40,
                          backgroundImage: AssetImage(
                            AssetsPath.profilePicture,
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        //username
                        SizedBox(
                          width: 120,
                          child: Text(
                            user?.name ?? 'Username',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              foreground: Paint()..shader = linearGradient,
                              overflow: TextOverflow.ellipsis,
                            ),
                            maxLines: 1,
                          ),
                        ),
                        //menus
                        const SizedBox(
                          height: 60,
                        ),
                        //theme selection
                        BlocBuilder<ThemeBloc, ThemeState>(
                          builder: (context, state) {
                            // Switch icon based on the theme
                            final isDarkTheme =
                                state.themeData.brightness == Brightness.dark;
                            return MenuOption(
                              title: 'Change theme',
                              leadingIcon: Icon(
                                isDarkTheme
                                    ? LineAwesomeIcons.moon_solid
                                    : LineAwesomeIcons.lightbulb,
                                color: AppColors.primaryColor,
                              ),
                              trailingIcon: const Icon(
                                LineAwesomeIcons.angle_right_solid,
                                color: AppColors.primaryColor,
                              ),
                              trailing: true,
                              onTap: () async {
                                await Navigator.pushNamed(
                                  context,
                                  HabitQuestRouter.changeThemeScreenRoute,
                                );
                              },
                            );
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        //notifications
                        MenuOption(
                          title: 'Notifications',
                          leadingIcon: const Icon(
                            LineAwesomeIcons.bell_solid,
                            color: AppColors.primaryColor,
                          ),
                          trailingIcon: const Icon(
                            LineAwesomeIcons.angle_right_solid,
                            color: AppColors.primaryColor,
                          ),
                          trailing: true,
                          onTap: state is SignOutLoading
                              ? () {}
                              : () async {
                                  await Navigator.pushNamed(
                                    context,
                                    HabitQuestRouter.notificationsScreenRoute,
                                  );
                                },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        //logout
                        MenuOption(
                          title: 'Sign out',
                          leadingIcon: const Icon(
                            LineAwesomeIcons.sign_out_alt_solid,
                            color: AppColors.primaryColor,
                          ),
                          trailingIcon: const Icon(
                            LineAwesomeIcons.angle_right_solid,
                            color: AppColors.primaryColor,
                          ),
                          trailing: false,
                          isLoading: state is SignOutLoading,
                          onTap: state is SignOutLoading ? () {} : _signOut,
                        ),
                      ],
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
