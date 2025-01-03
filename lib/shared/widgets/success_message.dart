// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:habit_quest/shared/utils/app_colors.dart';

class SuccessMessage {
  static void show(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Container(
          padding: const EdgeInsets.all(8),
          height: 80,
          decoration: BoxDecoration(
            color: AppColors.primaryColor.withOpacity(
              0.1,
            ),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Row(
            children: [
              //success icon
              const Icon(
                Icons.check_circle_outline_rounded,
                color: AppColors.primaryColor,
                size: 40,
              ),
              const SizedBox(
                width: 20,
              ),
              //success message
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Success',
                      style: TextStyle(
                        color: AppColors.primaryColor,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      message,
                      style: const TextStyle(
                        color: AppColors.primaryColor,
                        fontSize: 12,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(
          seconds: 2,
        ),
        backgroundColor: AppColors.transparent,
        elevation: 0,
      ),
    );
  }
}
