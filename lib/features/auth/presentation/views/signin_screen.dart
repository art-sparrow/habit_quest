// ignore_for_file: lines_longer_than_80_chars

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_quest/features/auth/data/models/signin_model.dart';
import 'package:habit_quest/features/auth/presentation/blocs/signin_bloc/signin_bloc.dart';
import 'package:habit_quest/features/auth/presentation/blocs/signin_bloc/signin_event.dart';
import 'package:habit_quest/features/auth/presentation/blocs/signin_bloc/signin_state.dart';
import 'package:habit_quest/shared/constants/assets_path.dart';
import 'package:habit_quest/shared/utils/app_colors.dart';
import 'package:habit_quest/shared/utils/router.dart';
import 'package:habit_quest/shared/widgets/custom_button.dart';
import 'package:habit_quest/shared/widgets/custom_pwd_textfield.dart';
import 'package:habit_quest/shared/widgets/custom_textfield.dart';
import 'package:habit_quest/shared/widgets/error_message.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  // Text editing controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  // Form key
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool isPasswordVisible = false;

  // Focus nodes
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();

  void _onFocusChange() {
    setState(() {
      // Trigger rebuild
    });
  }

  @override
  void initState() {
    super.initState();
    _emailFocusNode.addListener(_onFocusChange);
    _passwordFocusNode.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    // Remove listeners
    _emailFocusNode.removeListener(_onFocusChange);
    _passwordFocusNode.removeListener(_onFocusChange);
    // Dispose listeners
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  void _signIn() {
    if (_formKey.currentState!.validate()) {
      // Create SignIn model with form data
      final signInModel = SignInModel(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
      // Trigger sign in event
      context.read<SignInBloc>().add(SignInRequested(signInModel));
    }
  }

  void _signInViaGoogle() {
    // Trigger sign in event
    context.read<SignInBloc>().add(GoogleSignInRequested());
  }

  @override
  Widget build(BuildContext context) {
    //set the status bar color to transparent
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: AppColors.transparent,
      ),
    );

    return Scaffold(
      body: BlocConsumer<SignInBloc, SignInState>(
        listener: (context, state) {
          if (state is SignInInitial) {}
          if (state is SignInFailure) {
            // Show error message only if the snackbar is not already visible
            if (!ScaffoldMessenger.of(context).mounted) {
              ErrorMessage.show(context, state.errorMessage);
            }
          }
          if (state is SignInSuccess) {
            // Navigate to the login screen
            Navigator.pushNamed(
              context,
              HabitQuestRouter.landingScreenRoute,
            );
          }
        },
        builder: (context, state) {
          return Center(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Logo
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: Row(
                        children: [
                          Image.asset(
                            AssetsPath.habitQuestLogo,
                            height: 100,
                            width: 100,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 5),
                    // Heading
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 25),
                      child: Row(
                        children: [
                          Text(
                            'Sign in',
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: AppColors.primaryColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 5),
                    // Sub heading
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 25),
                      child: Text(
                        'Fill out the form below',
                        style: TextStyle(
                          color: AppColors.grey,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Email textfield
                    CustomTextField(
                      controller: emailController,
                      labelText: 'Email*',
                      prefixIcon: LineAwesomeIcons.envelope_solid,
                      focusNode: _emailFocusNode,
                      keyboardType: TextInputType.text,
                      isLoading: state is SignInLoading,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "What's your email?";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 15),
                    // Password textfield
                    CustomPwdTextField(
                      controller: passwordController,
                      labelText: 'Password*',
                      prefixIcon: LineAwesomeIcons.key_solid,
                      focusNode: _passwordFocusNode,
                      keyboardType: TextInputType.text,
                      suffixIcon: LineAwesomeIcons.eye,
                      isLoading: state is SignInLoading,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "What's your password?";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 15),
                    // Reset password link
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: GestureDetector(
                        onTap: state is SignInLoading
                            ? () {}
                            : () async {
                                await Navigator.pushNamed(
                                  context,
                                  HabitQuestRouter.resetPwdScreenRoute,
                                );
                              },
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              'Trouble signing in?',
                              style: TextStyle(
                                color: AppColors.primaryColor,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    // Sign in button
                    CustomButton(
                      onPressed: _signIn,
                      buttonText: 'Sign in',
                      isLoading: state is SignInLoading,
                    ),
                    const SizedBox(height: 25),
                    // Google sign in
                    const Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 25,
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Divider(
                              color: AppColors.grey,
                              thickness: 0.2,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 10,
                            ),
                            child: Text(
                              'Or continue with',
                              style: TextStyle(
                                color: AppColors.grey,
                                fontSize: 16,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Divider(
                              color: AppColors.grey,
                              thickness: 0.2,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 25),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Google sign in button
                        GestureDetector(
                          onTap: _signInViaGoogle,
                          child: const CircleAvatar(
                            backgroundColor: AppColors.transparent,
                            radius: 20,
                            backgroundImage: AssetImage(
                              AssetsPath.googleLogo,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 25),
                    // Sign up link
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Are you new here?',
                          style: TextStyle(
                            color: AppColors.grey,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(width: 4),
                        GestureDetector(
                          // navigate to the sign up screen
                          onTap: state is SignInLoading
                              ? () {}
                              : () async {
                                  await Navigator.pushNamed(
                                    context,
                                    HabitQuestRouter.signUpScreenRoute,
                                  );
                                },
                          child: const Text(
                            'Sign up',
                            style: TextStyle(
                              color: AppColors.primaryColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
