import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gymmanagement/blocs/employee_bloc/employee_cubit.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../src/app_colors.dart';

class EmployeesTile extends StatelessWidget {
  const EmployeesTile(
      {super.key,
      required this.id,
      required this.attendance,
      required this.name,
      required this.phone,
      required this.salary});
  final String id, name, phone, salary;
  final List attendance;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.grey.shade300),
        borderRadius: BorderRadius.circular(10),
        color: AppColors.white,
        boxShadow: [
          BoxShadow(
            color: AppColors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Center(
              child: IconButton(
                icon: const Icon(Icons.delete, color: AppColors.red),
                onPressed: () {
                  // if (currentEmployee.role != 'admin') {
                  //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  //     content: Text(
                  //       'خارج صلاحيات الحساب',
                  //       textAlign: TextAlign.center,
                  //     ),
                  //   ));
                  // } else
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('تنبيه'),
                        content: const Text('هل تريد ان تحذف هذا الموظف'),
                        actions: <Widget>[
                          TextButton(
                            child: const Text('نعم'),
                            onPressed: () {
                              BlocProvider.of<EmployeeCubit>(context)
                                  .deleteEmployee(id: int.parse(id));
                              Navigator.of(context).pop();
                            },
                          ),
                          TextButton(
                            child: const Text('لا'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
            ),
          ),
          Expanded(
            child: Center(
              child: IconButton(
                icon: const Icon(Icons.edit, color: AppColors.blue),
                onPressed: () {
                  // if (currentEmployee.role != 'admin') {
                  //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  //     content: Text(
                  //       'خارج صلاحيات الحساب',
                  //       textAlign: TextAlign.center,
                  //     ),
                  //   ));
                  // } else
                  showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      final formKey = GlobalKey<FormState>();
                      TextEditingController nameCont =
                          TextEditingController(text: name);
                      TextEditingController salaryCont =
                          TextEditingController(text: salary);
                      TextEditingController phoneCont =
                          TextEditingController(text: phone);
                      return Padding(
                        padding: const EdgeInsets.all(20),
                        child: SingleChildScrollView(
                          child: Builder(builder: (context) {
                            return Form(
                              key: formKey,
                              child: Column(
                                children: [
                                  const Center(
                                    child: Text(
                                      'تعديل',
                                      style: TextStyle(fontSize: 25),
                                    ),
                                  ),
                                  TextFormField(
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return '*فارغ';
                                      }
                                      return null;
                                    },
                                    enabled: false,
                                    controller: nameCont,
                                    textAlign: TextAlign.right,
                                    decoration: const InputDecoration(
                                      label: Row(
                                        children: [Spacer(), Text('إلاسم')],
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  TextFormField(
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return '*فارغ';
                                      } else if (value.length >= 12) {
                                        return '*خطأ';
                                      }
                                      return null;
                                    },
                                    controller: phoneCont,
                                    textAlign: TextAlign.right,
                                    decoration: const InputDecoration(
                                      label: Row(
                                        children: [
                                          Spacer(),
                                          Text('رقم الهاتف')
                                        ],
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  TextField(
                                    controller: salaryCont,
                                    enabled: true,
                                    textAlign: TextAlign.right,
                                    decoration: const InputDecoration(
                                      label: Row(
                                        children: [Spacer(), Text('المرتب')],
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  const SizedBox(height: 20),
                                  TextButton(
                                    onPressed: () {
                                      if (formKey.currentState!.validate()) {
                                        BlocProvider.of<EmployeeCubit>(context)
                                            .updateEmployee(
                                          salary: int.parse(salaryCont.text),
                                          phone: int.parse(phoneCont.text),
                                          id: int.parse(id),
                                        );
                                        Navigator.pop(context);
                                      }
                                    },
                                    child: Container(
                                      width: double.infinity,
                                      height: 40,
                                      decoration: BoxDecoration(
                                        color: AppColors.blue[800],
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: const Center(
                                        child: Text(
                                          'تعديل',
                                          style: TextStyle(
                                              fontSize: 20,
                                              color: AppColors.white),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ),
          Expanded(
              child: Center(
                  child: IconButton(
                      icon: const Icon(Icons.calendar_month_outlined,
                          color: AppColors.blue),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return Dialog(
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width * 0.5,
                                height:
                                    MediaQuery.of(context).size.height * 0.5,
                                child: TableCalendar(
                                  firstDay: DateTime.utc(2024, 1, 1),
                                  lastDay: DateTime.utc(2050, 12, 31),
                                  focusedDay: DateTime.now(),
                                  calendarBuilders: CalendarBuilders(
                                    markerBuilder: (context, date, events) {
                                      final attendanceForDate =
                                          attendance.where((event) {
                                        // Parse the 'date' string to a DateTime object
                                        final eventDate =
                                            DateTime.parse(event['date']);
                                        return isSameDay(eventDate, date);
                                      }).toList();

                                      if (attendanceForDate.isNotEmpty) {
                                        // Handle multiple attendance entries for the same day (optional)
                                        return Stack(
                                          children: attendanceForDate
                                              .asMap()
                                              .entries
                                              .map((entry) {
                                            return Container(
                                              alignment: Alignment.center,
                                              width: 35,
                                              height: 50,
                                              padding: const EdgeInsets.all(5),
                                              decoration: const BoxDecoration(
                                                color: Colors.green,
                                                shape: BoxShape.circle,
                                              ),
                                              child: Text(date.day.toString()),
                                            );
                                          }).toList(),
                                        );
                                      }
                                      return null;
                                    },
                                  ),
                                  // Other calendar properties (optional)
                                ),
                              ),
                            );
                          },
                        );
                      }))),
          Expanded(
            child: Center(
              child: SelectableText(
                attendance.length.toString(),
                style:
                    const TextStyle(fontWeight: FontWeight.w500, fontSize: 22),
              ),
            ),
          ),
          Expanded(
            child: Center(
              child: SelectableText(
                salary,
                style:
                    const TextStyle(fontWeight: FontWeight.w500, fontSize: 22),
              ),
            ),
          ),
          Expanded(
            child: Center(
              child: SelectableText(
                phone,
                style:
                    const TextStyle(fontWeight: FontWeight.w500, fontSize: 22),
              ),
            ),
          ),
          Expanded(
            child: Center(
              child: SelectableText(
                name,
                style:
                    const TextStyle(fontWeight: FontWeight.w500, fontSize: 22),
              ),
            ),
          ),
          Expanded(
            child: Center(
              child: SelectableText(
                id,
                style:
                    const TextStyle(fontWeight: FontWeight.w500, fontSize: 22),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
