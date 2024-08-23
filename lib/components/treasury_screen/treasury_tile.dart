import 'package:flutter/material.dart';

class TreasuryTile extends StatelessWidget {
  const TreasuryTile({
    super.key,
    required this.createdBy,
    required this.amount,
    required this.type,
    required this.dateCreated,
    required this.comment,
  });
  final String createdBy, amount, type, dateCreated, comment;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Center(
            child: Text(
              createdBy,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
          ),
        ),
        Expanded(
          child: Center(
            child: Text(
              amount,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
          ),
        ),
        Expanded(
          child: Center(
            child: Text(
              type,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
          ),
        ),
        Expanded(
          child: Center(
            child: Text(
              comment,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
          ),
        ),
        Expanded(
          child: Center(
            child: SelectableText(
              dateCreated,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
          ),
        ),
      ],
    );
  }
}
