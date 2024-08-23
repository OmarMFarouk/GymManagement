import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../src/app_colors.dart';

class MyDropDownButton extends StatelessWidget {
  const MyDropDownButton(
      {super.key,
      required this.value,
      required this.onChanged,
      required this.items,
      required this.title});
  final String value, title;
  final Function onChanged;
  final List<String> items;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: value,
      items: items.map((type) {
        return DropdownMenuItem(
          value: type,
          child: Row(
            children: [
              Icon(
                type != items[0]
                    ? FontAwesomeIcons.personRunning
                    : FontAwesomeIcons.weightHanging,
                size: 20,
                color: AppColors.teal[800],
              ),
              const SizedBox(width: 10),
              Text(type),
            ],
          ),
        );
      }).toList(),
      onChanged: (value) => onChanged(value),
      decoration: InputDecoration(
        labelText: title,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
