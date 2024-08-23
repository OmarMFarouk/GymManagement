import 'package:gymmanagement/models/employee_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:gymmanagement/models/treasury_model.dart';
import 'package:gymmanagement/src/app_db.dart';
import 'package:gymmanagement/src/app_shared.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'employee_states.dart';

class EmployeeCubit extends Cubit<EmployeeStates> {
  EmployeeCubit() : super(EmployeeInitial());
  static EmployeeCubit get(context) => BlocProvider.of(context);
  List<Treasury> treasuryList = [];
  List<Employee> employeeList = [];
  List<Map<String, dynamic>> attendanceList = [];
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  final TextEditingController phoneCont = TextEditingController();
  Database? dbInstance = AppDB.database;

  fetchCurrentEmployeeData() async {
    emit(EmployeeLoaded());
    currentEmployee = Employee.fromJson((await dbInstance!.rawQuery(
            'SELECT * FROM employees WHERE username = ?  LIMIT 1',
            [AppShared.localStorage.getString('username')]))
        .toList()[0] as Map<String, dynamic>);
  }

  fetchEmployees() async {
    if (employeeList.isNotEmpty) {
      employeeList.clear();
    }
    emit(EmployeeLoaded());
    var queryList = (await dbInstance!
            .rawQuery('SELECT * FROM employees ORDER BY id DESC '))
        .toList() as List<Map<String, dynamic>>;
    for (var i = 0; i < queryList.length; i++) {
      employeeList.add(Employee.fromJson(queryList[i]));
    }
    emit(EmployeeInitial());
  }

  createEmployee() async {
    emit(EmployeeLoaded());
    if (employeeList.indexWhere((e) => e.username == usernameController.text) ==
        -1) {
      dbInstance!.execute(
          'INSERT INTO employees(username,password,last_access,date_created,role,salary,phone) VALUES (?,?,?,?,?,?,?)',
          [
            usernameController.text,
            passwordController.text,
            '${DateTime.now()}',
            '${DateTime.now()}',
            'employee',
            int.parse(amountController.text),
            int.parse(phoneCont.text)
          ]).then((value) {
        emit(EmployeeSuccess(msg: 'تم تسجيل الموظف بنجاح'));
        clearControllers();
        fetchEmployees();
      }).catchError((error) {
        emit(EmployeeFailure(msg: error.toString()));
      });
    } else {
      emit(EmployeeFailure(msg: 'أسم المستخدم موجود بلفعل'));
    }
  }

  deleteEmployee({required int id}) async {
    emit(EmployeeLoaded());

    await dbInstance!
        .execute('DELETE FROM employees WHERE id = ?', [id]).then((value) {
      emit(EmployeeSuccess(msg: ' نم مسح الموظف بنجاح'));
      clearControllers();
      fetchEmployees();
    }).catchError((error) {
      emit(EmployeeFailure(msg: error.toString()));
    });
  }

  updateEmployee(
      {required int id, required int salary, required int phone}) async {
    emit(EmployeeLoaded());

    await dbInstance!.execute(
        'UPDATE employees SET salary = ? , phone = ? WHERE id = ?',
        [salary, phone, id]).then((value) {
      emit(EmployeeSuccess(msg: 'تم تعديل الموظف بنجاح'));
      clearControllers();
      fetchEmployees();
      ;
    }).catchError((error) {
      emit(EmployeeFailure(msg: error.toString()));
    });
  }

  fetchTreasury() async {
    if (treasuryList.isNotEmpty) {
      treasuryList.clear();
    }
    emit(EmployeeLoaded());
    var queryList =
        (await dbInstance!.rawQuery('SELECT * FROM treasury ORDER BY id DESC '))
            .toList() as List<Map<String, dynamic>>;
    for (var i = 0; i < queryList.length; i++) {
      treasuryList.add(Treasury.fromJson(queryList[i]));
    }
    emit(EmployeeInitial());
  }

  addTreasuryRequest({required bool isIncome}) async {
    emit(EmployeeLoaded());
    await dbInstance!.execute(
        'INSERT INTO treasury(comment,amount,type,date_created,created_by) VALUES (?,?,?,?,?)',
        [
          usernameController.text,
          int.parse(amountController.text),
          isIncome ? 'إيداع' : 'سحب',
          DateTime.now().toString(),
          currentEmployee.username,
        ]).then((value) async {
      emit(EmployeeSuccess(msg: 'تم اضافة العملية بنجاح'));
      clearControllers();
      fetchTreasury();
    }).catchError((error) {
      emit(EmployeeFailure(msg: error.toString()));
    });
  }

  clearControllers() {
    usernameController.clear();
    passwordController.clear();
    amountController.clear();
    phoneCont.clear();
  }
  // updateClient(
  //     {required int id, required String name, required String phone}) async {
  //   emit(EmployeeLoaded());

  //   await dbInstance!.execute(
  //       'UPDATE employees SET name = ? , phone = ? WHERE id = ?',
  //       [name, phone, id]).then((value) {
  //     emit(EmployeeSuccess(msg: 'تم تعديل المشترك بنجاح'));
  //     clearControllers();
  //     fetchEmployees();
  //   }).catchError((error) {
  //     emit(EmployeeFailure(msg: error.toString()));
  //   });
  // }
  fetchEmployeeAttendance() async {
    if (attendanceList.isNotEmpty) {
      attendanceList.clear();
    }
    emit(EmployeeLoaded());
    var queryList = (await dbInstance!
            .rawQuery('SELECT * FROM attendance ORDER BY id DESC '))
        .toList() as List<Map<String, dynamic>>;
    attendanceList = queryList;
    emit(EmployeeInitial());
  }
}

late Employee currentEmployee;
