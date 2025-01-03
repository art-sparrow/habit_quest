// ignore_for_file: file_names, must_be_immutable, prefer_null_aware_method_calls, lines_longer_than_80_chars

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_quest/features/profile/presentation/blocs/theme_bloc/theme_bloc.dart';
import 'package:habit_quest/shared/utils/app_colors.dart';

class CustomTextField extends StatefulWidget {
  CustomTextField({
    required this.controller,
    required this.labelText,
    required this.prefixIcon,
    required this.focusNode,
    required this.keyboardType,
    this.isLoading = false,
    this.enabled,
    this.validator,
    this.suffixIcon,
    this.onChanged,
    super.key,
  });

  final TextEditingController controller;
  final String labelText;
  final IconData prefixIcon;
  final FocusNode focusNode;
  final TextInputType keyboardType;
  final bool isLoading;
  final bool? enabled;
  IconData? suffixIcon;
  final String? Function(String?)? validator;
  final String? Function(String?)? onChanged;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
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
        onChanged: (value) {
          //rebuild clear icon
          setState(() {});
          if (widget.onChanged != null) {
            widget.onChanged!(value);
          }
        },
        obscureText: isTextVisible,
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
          suffixIcon:
              widget.controller.text.isNotEmpty && widget.focusNode.hasFocus
                  ? IconButton(
                      onPressed: () {
                        setState(() {
                          widget.controller.clear();
                        });
                      },
                      icon: Icon(
                        Icons.clear,
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
