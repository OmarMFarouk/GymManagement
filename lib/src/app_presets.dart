import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';

class AppPresets {
  static late WindowManager instance;
  static init() async {
    await windowManager.ensureInitialized();
    instance = WindowManager.instance;
    await instance.setMinimumSize(const Size(1300, 1000));
    await instance.setTitle('سيستيم مستر أوليمبيا');
    await instance.setAlignment(Alignment.center);
    await instance.setAsFrameless();
  }
}
