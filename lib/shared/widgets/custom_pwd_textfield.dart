// ignore_for_file: prefer_const_constructors, file_names, must_be_immutable, use_super_parameters, lines_longer_than_80_chars

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_quest/features/profile/presentation/blocs/theme_bloc/theme_bloc.dart';
import 'package:habit_quest/shared/utils/app_colors.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class CustomPwdTextField extends StatefulWidget {
  CustomPwdTextField({
    required this.controller,
    required this.labelText,
    required this.prefixIcon,
    required this.focusNode,
    required this.keyboardType,
    this.isLoading = false,
    this.enabled,
    this.validator,
    this.suffixIcon,
    this.onchanged,
    Key? key,
  }) : super(key: key);

  final TextEditingController controller;
  final String labelText;
  final IconData prefixIcon;
  final FocusNode focusNode;
  final TextInputType keyboardType;
  final bool isLoading;
  final bool? enabled;
  IconData? suffixIcon;
  final String? Function(String?)? validator;
  final String? Function(String?)? onchanged;

  @override
  State<CustomPwdTextField> createState() => _CustomPwdTextFieldState();
}

class _CustomPwdTextFieldState extends State<CustomPwdTextField> {
  bool isTextVisible = false;

  @override
  Widget build(BuildContext context) {
    final isEnabled = widget.enabled ?? !widget.isLoading;
    // Access the current theme state directly
    final isDarkTheme =
        BlocProvider.of<ThemeBloc>(context).state.themeData.brightness ==
            Brightness.dark;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: TextFormField(
        autocorrect: false,
        enableSuggestions: false,
        enableInteractiveSelection: false,
        readOnly: !isEnabled,
        controller: widget.controller,
        onChanged: widget.onchanged,
        obscureText: !isTextVisible,
        obscuringCharacter: '*',
        style: TextStyle(
          color: !isEnabled
              ? AppColors.grey
              : (isDarkTheme ? AppColors.grey : AppColors.black),
        ),
        cursorColor:
            widget.focusNode.hasFocus ? AppColors.primaryColor : AppColors.grey,
        focusNode: widget.focusNode,
        decoration: InputDecoration(
          labelText: widget.labelText,
          labelStyle: TextStyle(
            color: widget.focusNode.hasFocus
                ? AppColors.primaryColor
                : AppColors.grey,
            fontWeight: FontWeight.normal,
            fontSize: 16,
          ),
          floatingLabelBehavior: FloatingLabelBehavior.auto,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: widget.focusNode.hasFocus
                  ? AppColors.primaryColor
                  : AppColors.grey,
              width: 0.5,
            ),
            borderRadius: BorderRadius.circular(15),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: AppColors.primaryColor,
              width: 0.5,
            ),
            borderRadius: BorderRadius.circular(15),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: AppColors.red,
              width: 0.5,
            ),
            borderRadius: BorderRadius.circular(15),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: AppColors.primaryColor,
              width: 0.5,
            ),
            borderRadius: BorderRadius.circular(15),
          ),
          prefixIcon: Icon(
            widget.prefixIcon,
            color: widget.focusNode.hasFocus
                ? AppColors.primaryColor
                : AppColors.grey,
          ),
          suffixIcon: widget.suffixIcon != null
              ? GestureDetector(
                  onTap: () {
                    setState(() {
                      isTextVisible = !isTextVisible;
                    });
                  },
                  child: Icon(
                    isTextVisible
                        ? LineAwesomeIcons.eye_slash
                        : widget.suffixIcon,
                    color: widget.focusNode.hasFocus
                        ? AppColors.primaryColor
                        : AppColors.grey,
                  ),
                )
              : null,
          errorStyle: const TextStyle(
            color: AppColors.red,
            fontSize: 12,
          ),
        ),
        keyboardType: widget.keyboardType,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: widget.validator,
      ),
    );
  }
}
