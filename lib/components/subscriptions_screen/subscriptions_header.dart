import 'package:flutter/material.dart';

class SubscriptionsHeader extends StatelessWidget {
  const SubscriptionsHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Expanded(
          child: Center(
            child: Text(
              'التوقيت',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
            ),
          ),
        ),
        Expanded(
          child: Center(
            child: Text(
              'التاريخ',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
            ),
          ),
        ),
        Expanded(
          child: Center(
            child: Text(
              'المدة',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
            ),
          ),
        ),
        Expanded(
          child: Center(
            child: Text(
              'النوع',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
            ),
          ),
        ),
        Expanded(
          child: Center(
            child: Text(
              'المبلغ',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
            ),
          ),
        ),
        Expanded(
          child: Center(
            child: Text(
              'رقم العضوية',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
            ),
          ),
        ),
        Expanded(
          child: Center(
            child: Text(
              'التسلسل',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
            ),
          ),
        ),
      ],
    );
  }
}
