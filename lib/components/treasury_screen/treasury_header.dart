import 'package:flutter/material.dart';

class TreasuryHeader extends StatelessWidget {
  const TreasuryHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Expanded(
          child: Center(
            child: Text(
              'بواسطة',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
            ),
          ),
        ),
        Expanded(
          child: Center(
            child: Text(
              'المبلغ',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
            ),
          ),
        ),
        Expanded(
          child: Center(
            child: Text(
              'النوع',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
            ),
          ),
        ),
        Expanded(
          child: Center(
            child: Text(
              'الملاحظة',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
            ),
          ),
        ),
        Expanded(
          child: Center(
            child: Text(
              'التاريخ',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
            ),
          ),
        ),
      ],
    );
  }
}
