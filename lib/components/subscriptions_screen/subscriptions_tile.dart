import 'package:flutter/material.dart';

import '../../src/app_colors.dart';

class SubcriptionsTile extends StatelessWidget {
  const SubcriptionsTile(
      {super.key,
      required this.date,
      required this.duration,
      required this.clientId,
      required this.subId,
      required this.type,
      required this.hour,
      required this.amount});
  final String date, duration, clientId, subId, type, amount, hour;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.grey.shade300),
        borderRadius: BorderRadius.circular(10),
        color: AppColors.white,
        boxShadow: [
          BoxShadow(
            color: AppColors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Center(
              child: SelectableText(
                hour,
                style:
                    const TextStyle(fontWeight: FontWeight.w500, fontSize: 22),
              ),
            ),
          ),
          Expanded(
            child: Center(
              child: SelectableText(
                date,
                style:
                    const TextStyle(fontWeight: FontWeight.w500, fontSize: 22),
              ),
            ),
          ),
          Expanded(
            child: Center(
              child: SelectableText(
                duration,
                style:
                    const TextStyle(fontWeight: FontWeight.w500, fontSize: 22),
              ),
            ),
          ),
          Expanded(
            child: Center(
              child: SelectableText(
                type,
                style:
                    const TextStyle(fontWeight: FontWeight.w500, fontSize: 22),
              ),
            ),
          ),
          Expanded(
            child: Center(
              child: Center(
                child: SelectableText(
                  amount,
                  style: const TextStyle(
                      fontWeight: FontWeight.w500, fontSize: 22),
                ),
              ),
            ),
          ),
          Expanded(
            child: Center(
              child: SelectableText(
                clientId,
                style:
                    const TextStyle(fontWeight: FontWeight.w500, fontSize: 22),
              ),
            ),
          ),
          Expanded(
            child: Center(
              child: SelectableText(
                subId,
                style:
                    const TextStyle(fontWeight: FontWeight.w500, fontSize: 22),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
