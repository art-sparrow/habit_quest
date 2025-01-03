// ignore_for_file: lines_longer_than_80_chars

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_quest/features/auth/data/models/signup_model.dart';
import 'package:habit_quest/features/auth/presentation/blocs/signup_bloc/signup_bloc.dart';
import 'package:habit_quest/features/auth/presentation/blocs/signup_bloc/signup_event.dart';
import 'package:habit_quest/features/auth/presentation/blocs/signup_bloc/signup_state.dart';
import 'package:habit_quest/shared/constants/assets_path.dart';
import 'package:habit_quest/shared/utils/app_colors.dart';
import 'package:habit_quest/shared/utils/router.dart';
import 'package:habit_quest/shared/widgets/custom_button.dart';
import 'package:habit_quest/shared/widgets/custom_pwd_textfield.dart';
import 'package:habit_quest/shared/widgets/custom_textfield.dart';
import 'package:habit_quest/shared/widgets/error_message.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  // Text editing controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  // Form key
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool isPasswordVisible = false;

  // Focus nodes
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  final FocusNode _nameFocusNode = FocusNode();
  final FocusNode _phoneFocusNode = FocusNode();

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
    _nameFocusNode.addListener(_onFocusChange);
    _phoneFocusNode.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    // Remove listeners
    _emailFocusNode.removeListener(_onFocusChange);
    _passwordFocusNode.removeListener(_onFocusChange);
    _nameFocusNode.removeListener(_onFocusChange);
    _phoneFocusNode.removeListener(_onFocusChange);
    // Dispose listeners
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    _nameFocusNode.dispose();
    _phoneFocusNode.dispose();
    super.dispose();
  }

  void _signUp() {
    if (_formKey.currentState!.validate()) {
      if (passwordController.text.length < 8) {
        ErrorMessage.show(context, 'Password should be at least 8 characters');
        return;
      }
      // Create sign up model with form data
      final signUpModel = SignUpModel(
        name: nameController.text.trim(),
        phone: phoneController.text.trim(),
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
        joinedOn: '',
        uid: '',
        fcmToken: '',
      );
      // Trigger sign up event
      context.read<SignUpBloc>().add(SignUpRequested(signUpModel));
    }
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
      body: BlocConsumer<SignUpBloc, SignUpState>(
        listener: (context, state) {
          if (state is SignUpInitial) {}
          if (state is SignUpFailure) {
            ErrorMessage.show(context, state.errorMessage);
          }
          if (state is SignUpSuccess) {
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
                            'Sign up',
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
                    // Name textfield
                    CustomTextField(
                      controller: nameController,
                      labelText: 'Name*',
                      prefixIcon: LineAwesomeIcons.user,
                      focusNode: _nameFocusNode,
                      keyboardType: TextInputType.text,
                      isLoading: state is SignUpLoading,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "What's your name?";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    // phone textfield
                    CustomTextField(
                      controller: phoneController,
                      labelText: 'Phone*',
                      prefixIcon: LineAwesomeIcons.phone_alt_solid,
                      focusNode: _phoneFocusNode,
                      keyboardType: TextInputType.number,
                      isLoading: state is SignUpLoading,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "What's your phone?";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    // Email textfield
                    CustomTextField(
                      controller: emailController,
                      labelText: 'Email*',
                      prefixIcon: LineAwesomeIcons.envelope_solid,
                      focusNode: _emailFocusNode,
                      keyboardType: TextInputType.text,
                      isLoading: state is SignUpLoading,
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
                      isLoading: state is SignUpLoading,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "What's your password?";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 15),
                    // Sign up button
                    CustomButton(
                      onPressed: _signUp,
                      buttonText: 'Sign up',
                      isLoading: state is SignUpLoading,
                    ),
                    const SizedBox(height: 15),
                    // Sign in link
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Do you have an account?',
                          style: TextStyle(
                            color: AppColors.grey,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(width: 4),
                        GestureDetector(
                          // navigate to the sign in screen
                          onTap: state is SignUpLoading
                              ? null
                              : () async {
                                  await Navigator.pushNamed(
                                    context,
                                    HabitQuestRouter.signInScreenRoute,
                                  );
                                },
                          child: const Text(
                            'Sign in',
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
