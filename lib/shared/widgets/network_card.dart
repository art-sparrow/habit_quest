import 'package:flutter/material.dart';
import 'package:habit_quest/shared/constants/assets_path.dart';
import 'package:habit_quest/shared/utils/app_colors.dart';

class NetworkCard extends StatelessWidget {
  const NetworkCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 80,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: AppColors.primaryColor.withOpacity(
          0.1,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryColor.withOpacity(
              0.1,
            ),
            blurRadius: 12,
            spreadRadius: 3,
          ),
        ],
        borderRadius: BorderRadius.circular(15),
        border: Border.fromBorderSide(
          BorderSide(
            width: 0.1,
            color: AppColors.primaryColor.withOpacity(
              0.1,
            ),
          ),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  top: 10,
                  right: 20,
                ),
                child: Image.asset(
                  AssetsPath.noNetworkIcon,
                  height: 24,
                  width: 24,
                ),
              ),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      'No Network',
                      style: TextStyle(
                        color: AppColors.primaryColor,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Check your connection',
                      style: TextStyle(
                        color: AppColors.white,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
