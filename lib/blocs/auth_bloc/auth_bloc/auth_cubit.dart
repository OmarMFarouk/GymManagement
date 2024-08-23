import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gymmanagement/src/app_db.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import '../../../src/app_shared.dart';
import 'auth_states.dart';

class AuthCubit extends Cubit<AuthStates> {
  AuthCubit() : super(AuthInitial());
  static AuthCubit get(context) => BlocProvider.of(context);

  Database? dbInstance = AppDB.database;
  TextEditingController usernameCont = TextEditingController();
  TextEditingController passwordCont = TextEditingController();
  String selectedRole = 'admin';
  loginUser() async {
    emit(AuthLoading());
    List authList = await dbInstance!.rawQuery(
        'SELECT * FROM employees WHERE username = ? AND password =? AND role =? ',
        [usernameCont.text, passwordCont.text, selectedRole]);

    if (authList.isEmpty) {
      emit(AuthError(msg: 'اعد التحقق من البيانات'));
    } else {
      List todayLoginChecker = await dbInstance!.rawQuery(
          'SELECT * FROM attendance WHERE username = ? AND date = ?',
          [usernameCont.text, DateTime.now().toString().split(' ').first]);
      if (todayLoginChecker.isEmpty) {
        await dbInstance!
            .execute('INSERT INTO attendance(date,username) VALUES (?,?)', [
          DateTime.now().toString().split(' ').first,
          usernameCont.text,
        ]);
      }

      emit(AuthSuccess(msg: 'تم تسجيل الدخول بنجاح'));
      clearAndSave();
    }
  }

  initialSignUp() async {
    emit(AuthLoading());
    dbInstance!.execute(
        'INSERT INTO employees(username,password,last_access,date_created,role,salary,phone) VALUES (?,?,?,?,?,?,?)',
        [
          usernameCont.text,
          passwordCont.text,
          '${DateTime.now()}',
          '${DateTime.now()}',
          'admin',
          0,
          0
        ]).then((value) {
      emit(AuthSuccess(msg: 'تم تسجيل الأدمن بنجاح'));
      clearAndSave();
    }).catchError((error) {
      emit(AuthError(msg: error.toString()));
    });
  }

  clearAndSave() async {
    await AppShared.localStorage.setBool('active', true);
    await AppShared.localStorage.setBool('onboarded', true);
    await AppShared.localStorage.setString('username', usernameCont.text);
    passwordCont.clear();
    usernameCont.clear();
  }
}
