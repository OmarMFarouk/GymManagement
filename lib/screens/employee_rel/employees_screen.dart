import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gymmanagement/components/employees_screen/employees_tile.dart';
import 'package:gymmanagement/src/app_colors.dart';
import 'package:gymmanagement/src/app_functions.dart';
import '../../blocs/employee_bloc/employee_cubit.dart';
import '../../blocs/employee_bloc/employee_states.dart';
import '../../components/employees_screen/employees_header.dart';
import '../../models/employee_model.dart';

class EmployeeScreen extends StatelessWidget {
  const EmployeeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    return BlocConsumer<EmployeeCubit, EmployeeStates>(
        listener: (context, state) {
      if (state is EmployeeFailure) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: AppColors.red.shade400,
          content: Text(
            state.msg,
            textAlign: TextAlign.center,
          ),
        ));
      }
      if (state is EmployeeSuccess) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: AppColors.green.shade400,
          content: Text(
            state.msg,
            textAlign: TextAlign.center,
          ),
        ));
      }
    }, builder: (context, state) {
      var cubit = EmployeeCubit.get(context);
      return Scaffold(
        appBar: AppBar(
          title: const Text('ادارة الموظفين',
              style: TextStyle(color: AppColors.white)),
          backgroundColor: AppColors.teal[800],
        ),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return '*فارغ';
                          } else if (value.length < 6) {
                            return '*الرقم السري قصير';
                          }
                          return null;
                        },
                        controller: cubit.passwordController,
                        textDirection: TextDirection.rtl,
                        inputFormatters: [
                          FilteringTextInputFormatter.deny(' ')
                        ],
                        obscureText: true,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          label: Row(
                            children: [
                              Spacer(),
                              Text('كلمة المرور'),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return '*فارغ';
                          }
                          return null;
                        },
                        controller: cubit.usernameController,
                        inputFormatters: [
                          FilteringTextInputFormatter.deny(' ')
                        ],
                        textDirection: TextDirection.rtl,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          label: Row(
                            children: [
                              Spacer(),
                              Text('اسم المستخدم'),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return '*فارغ';
                          } else if (value.length < 6) {
                            return '*الرقم السري قصير';
                          }
                          return null;
                        },
                        controller: cubit.phoneCont,
                        textDirection: TextDirection.rtl,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          label: Row(
                            children: [
                              Spacer(),
                              Text('رقم الهاتف'),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return '*فارغ';
                          }
                          return null;
                        },
                        controller: cubit.amountController,
                        textDirection: TextDirection.rtl,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          label: Row(
                            children: [
                              Spacer(),
                              Text('المرتب'),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                TextButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      cubit.createEmployee();
                    }
                  },
                  child: Container(
                    height: 40,
                    width: 200,
                    decoration: BoxDecoration(
                      color: AppColors.teal[800],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Center(
                      child: Text(
                        'اضافة',
                        style: TextStyle(color: AppColors.white),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                Container(height: 1, color: AppColors.grey),
                const SizedBox(height: 20),
                Expanded(
                  child: Column(
                    children: [
                      const EmployeesHeader(),
                      Expanded(
                        child: ListView.builder(
                          itemCount: cubit.employeeList.length,
                          itemBuilder: (context, index) {
                            Employee employee = cubit.employeeList[index];
                            if (employee.role == 'admin') {
                              return null;
                            }
                            return EmployeesTile(
                                salary: employee.salary.toString(),
                                name: employee.username!,
                                attendance: AppFunctions.attendanceCalculator(
                                    allAttendance: cubit.attendanceList,
                                    username: employee.username!),
                                id: employee.id.toString(),
                                phone: employee.phone.toString());
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
