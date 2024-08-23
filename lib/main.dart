import 'package:gymmanagement/src/app_presets.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:gymmanagement/shared/bloc.dart';
import 'package:gymmanagement/src/app_db.dart';
import 'package:gymmanagement/src/app_root.dart';
import 'package:gymmanagement/src/app_shared.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppPresets.init();
  sqfliteFfiInit();
  databaseFactory = databaseFactoryFfi;
  await AppDB.createDatabase();
  await AppShared.init();
  Bloc.observer = MyBlocObserver();
  // await AppShared.localStorage.setBool('onboarded', false);
  // await AppShared.localStorage.setBool('active', false);

  runApp(const AppRoot());
}
