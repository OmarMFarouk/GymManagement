import 'package:flutter/material.dart';

import '../../src/app_colors.dart';

class MyButton extends StatelessWidget {
  const MyButton({
    super.key,
    required this.onTap,
    required this.title,
  });

  final VoidCallback onTap;
  final String title;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onTap,
      child: Container(
        padding: const EdgeInsets.all(7),
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: AppColors.teal[800],
        ),
        child: Center(
          child: Text(
            title,
            style: const TextStyle(color: AppColors.white, fontSize: 25),
          ),
        ),
      ),
    );
  }
}
