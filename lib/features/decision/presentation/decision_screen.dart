import 'package:flutter/material.dart';
import 'package:habit_quest/features/network/presentation/views/network_status_container.dart';
import 'package:habit_quest/shared/themes/app_colors.dart';

class DecisionScreen extends StatefulWidget {
  const DecisionScreen({super.key});

  @override
  State<DecisionScreen> createState() => _DecisionScreenState();
}

class _DecisionScreenState extends State<DecisionScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.white,
      body: Padding(
        padding: EdgeInsets.only(
          left: 10,
          right: 10,
          top: 30,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Home or Login'),
            SizedBox(
              height: 20,
            ),
            NetworkStatusContainer(),
          ],
        ),
      ),
    );
  }
}
