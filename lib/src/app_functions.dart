import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gymmanagement/src/app_shared.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

import '../models/treasury_model.dart';
import 'app_db.dart';

class AppFunctions {
  static void statusCheckup(
      {required Widget destination, required BuildContext context}) async {
    var queryList = (await AppDB.database!.rawQuery('SELECT * FROM employees '))
        .toList() as List<Map<String, dynamic>>;
    if (queryList.isEmpty) {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => destination,
          ));
    }
  }

  static void setAppLogo() async {
    final imagePicker = ImagePicker();
    final XFile? image = await imagePicker.pickImage(
      source: ImageSource.gallery,
    );

    final appDirectory = await getApplicationDocumentsDirectory();
    final imageDirectory = Directory('${appDirectory.path}/logo');

    if (!await imageDirectory.exists()) {
      await imageDirectory.create(recursive: true);
    }

    final newImagePath = '${appDirectory.path}/logo/main.png';
    if (image != null) {
      await image.saveTo(newImagePath);
      await AppShared.localStorage.setString('logo', newImagePath);
    }
  }

  static String treasuryCalculator(List<Treasury> treasuryList) {
    int total = 0;
    for (var i = 0; i < treasuryList.length; i++) {
      int price = treasuryList[i].amount!;
      if (treasuryList[i].type == 'إيداع') {
        total = total + price;
      } else {
        total = total - price;
      }
    }
    return total.toString();
  }

  static List attendanceCalculator(
      {required List<Map<String, dynamic>> allAttendance,
      required String username}) {
    List employeeAttendance = [];
    for (var i = 0; i < allAttendance.length; i++) {
      if (allAttendance[i]['username'] == username) {
        employeeAttendance.add(allAttendance[i]);
      }
    }
    return employeeAttendance;
  }

  static String durationCalculator(lastRenew, currentDuration) {
    var formattedTime = DateTime.parse(lastRenew.split(' ').first);

    var expiryTime = formattedTime.add(Duration(days: (currentDuration * 30)));
    var difference = expiryTime.difference(DateTime.now()).inDays;
    if (difference.isNegative) {
      return 'منتهي';
    } else if (difference == 0) {
      return 'اقل من 24 ساعة';
    } else {
      return '$difference : الأيام';
    }
  }
}
