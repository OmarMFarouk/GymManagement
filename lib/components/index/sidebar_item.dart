import 'package:flutter/material.dart';

import '../../src/app_colors.dart';

class SideBarItem extends StatelessWidget {
  const SideBarItem({
    super.key,
    required this.onTap,
    required this.title,
    required this.icon,
    required this.isCurrent,
  });
  final VoidCallback onTap;
  final String title;
  final IconData icon;
  final bool isCurrent;
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
          borderRadius: BorderRadius.circular(10),
          onTap: onTap,
          child: Ink(
            padding: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(
                  icon,
                  color: isCurrent ? AppColors.white : AppColors.grey,
                ),
                Text(
                  title,
                  style: TextStyle(
                      color: AppColors.white, fontSize: isCurrent ? 23 : 18),
                )
              ],
            ),
          )),
    );
  }
}
