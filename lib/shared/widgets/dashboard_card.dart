import 'package:flutter/material.dart';

class DashboardCard extends StatelessWidget {
  const DashboardCard({
    required this.height,
    required this.cardColor,
    required this.cardIcon,
    required this.cardTitle,
    required this.cardSubtitle,
    super.key,
  });

  final double height;
  final Color cardColor;
  final String cardIcon;
  final String cardTitle;
  final String cardSubtitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: height,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: cardColor.withOpacity(
          0.1,
        ),
        boxShadow: [
          BoxShadow(
            color: cardColor.withOpacity(
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
            color: cardColor.withOpacity(
              0.1,
            ),
          ),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // card icon
          Padding(
            padding: const EdgeInsets.only(
              top: 10,
            ),
            child: Image.asset(
              cardIcon,
              height: 24,
              width: 24,
            ),
          ),
          // card title
          Padding(
            padding: const EdgeInsets.only(
              top: 10,
            ),
            child: Text(
              cardTitle,
              style: TextStyle(
                color: cardColor,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          // card subtitle
          Padding(
            padding: const EdgeInsets.only(
              top: 10,
              bottom: 10,
            ),
            child: Text(
              cardSubtitle,
              style: TextStyle(
                color: cardColor,
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
