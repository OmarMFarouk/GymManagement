import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyFormField extends StatelessWidget {
  const MyFormField(
      {super.key,
      required this.controller,
      required this.title,
      required this.icon,
      required this.validator});
  final TextEditingController controller;
  final String title;
  final FormFieldValidator validator;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      keyboardType: title == 'الأسم' ? null : TextInputType.number,
      inputFormatters:
          title == 'الأسم' ? null : [FilteringTextInputFormatter.digitsOnly],
      controller: controller,
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: Colors.teal),
        label: Row(
          children: [const Spacer(), Text(title)],
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      textAlign: TextAlign.right,
      textDirection: TextDirection.rtl,
    );
  }
}
