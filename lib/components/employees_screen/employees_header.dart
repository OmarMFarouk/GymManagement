import 'package:flutter/material.dart';

class EmployeesHeader extends StatelessWidget {
  const EmployeesHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Expanded(
          child: Center(
            child: Text(
              'مسح',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
            ),
          ),
        ),
        Expanded(
          child: Center(
            child: Text(
              'تعديل',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
            ),
          ),
        ),
        Expanded(
          child: Center(
            child: Text(
              'الحضور',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
            ),
          ),
        ),
        Expanded(
          child: Center(
            child: Text(
              'ايام الحضور',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
            ),
          ),
        ),
        Expanded(
          child: Center(
            child: Text(
              'المرتب',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
            ),
          ),
        ),
        Expanded(
          child: Center(
            child: Text(
              'الموبيل',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
            ),
          ),
        ),
        Expanded(
          child: Center(
            child: Text(
              'الاسم',
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
