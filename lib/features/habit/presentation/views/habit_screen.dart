import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:habit_quest/shared/utils/app_colors.dart';

class HabitScreen extends StatefulWidget {
  const HabitScreen({super.key});

  @override
  State<HabitScreen> createState() => _HabitScreenState();
}

class _HabitScreenState extends State<HabitScreen> {
  @override
  Widget build(BuildContext context) {
    //set the status bar color to transparent
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: AppColors.transparent,
      ),
    );
    return const Scaffold(
      body: Padding(
        padding: EdgeInsets.only(
          left: 10,
          right: 10,
          top: 30,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Habits'),
          ],
        ),
      ),
    );
  }
}
