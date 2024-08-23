import 'package:flutter/material.dart';

class ClientsHeader extends StatelessWidget {
  const ClientsHeader({
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
              'تجديد',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
            ),
          ),
        ),
        Expanded(
          child: Center(
            child: Text(
              'المتبقي',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
            ),
          ),
        ),
        Expanded(
          child: Center(
            child: Text(
              'الصورة',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
            ),
          ),
        ),
        Expanded(
          child: Center(
            child: Text(
              'الاشهر',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
            ),
          ),
        ),
        Expanded(
          child: Center(
            child: Text(
              'العضوية',
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
