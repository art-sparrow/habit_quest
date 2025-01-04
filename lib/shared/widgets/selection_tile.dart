// ignore_for_file: prefer_const_constructors, file_names, use_super_parameters

import 'package:flutter/material.dart';

class SelectionTile extends StatelessWidget {
  const SelectionTile({
    required this.onTap,
    required this.icon,
    required this.title,
    Key? key,
  }) : super(key: key);

  final VoidCallback onTap;
  final Icon icon;
  final Text title;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          icon,
          const SizedBox(
            width: 10,
          ),
          title,
        ],
      ),
    );
  }
}
