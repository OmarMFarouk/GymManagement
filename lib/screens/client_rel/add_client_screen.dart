import 'package:gymmanagement/blocs/clients_bloc/Clients_states.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gymmanagement/components/add_client_screen/dropdown_button.dart';
import 'package:gymmanagement/components/general/my_formfield.dart';
import 'package:gymmanagement/components/general/my_snackbar.dart';
import 'package:gymmanagement/src/app_colors.dart';

import '../../blocs/clients_bloc/clients_cubit.dart';
import '../../components/general/my_button.dart';

class AddClientScreen extends StatefulWidget {
  const AddClientScreen({super.key});

  @override
  State<AddClientScreen> createState() => _AddClientScreenState();
}

class _AddClientScreenState extends State<AddClientScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ClientsCubit, ClientsStates>(
      listener: (context, state) {
        if (state is ClientsSuccess) {
          MySnackbar.show(context: context, isError: false, msg: state.msg);
        }
        if (state is ClientsError) {
          MySnackbar.show(context: context, isError: true, msg: state.msg);
        }
      },
      builder: (context, state) {
        var cubit = ClientsCubit.get(context);
        final formKey = GlobalKey<FormState>();
        return Scaffold(
          appBar: AppBar(
            title: const Row(
              children: [
                Spacer(),
                Text(
                  'إضافة مشترك',
                  style: TextStyle(color: AppColors.white),
                ),
              ],
            ),
            backgroundColor: AppColors.teal[800],
          ),
          body: Padding(
            padding: const EdgeInsets.all(40),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MyFormField(
                      icon: CupertinoIcons.person_alt,
                      controller: cubit.nameCont,
                      title: 'الأسم',
                      validator: (value) {
                        if (value!.isEmpty) {
                          return '*فارغ';
                        }
                        return null;
                      }),
                  const SizedBox(height: 20),
                  MyFormField(
                      icon: CupertinoIcons.phone_circle_fill,
                      controller: cubit.phoneCont,
                      title: 'رقم الهاتف',
                      validator: (value) {
                        if (value!.isEmpty) {
                          return '*فارغ';
                        }
                        return null;
                      }),
                  const SizedBox(height: 20),
                  MyFormField(
                      icon: Icons.attach_money,
                      controller: cubit.amountCont,
                      title: 'قيمة الأشتراك',
                      validator: (value) {
                        if (value!.isEmpty) {
                          return '*فارغ';
                        }
                        return null;
                      }),
                  const SizedBox(height: 20),
                  MyFormField(
                      icon: Icons.calendar_month_outlined,
                      controller: cubit.durationCont,
                      title: 'عدد الشهور',
                      validator: (value) {
                        if (value!.isEmpty) {
                          return '*فارغ';
                        }
                        return null;
                      }),
                  const SizedBox(height: 30),
                  MyDropDownButton(
                      value: cubit.type,
                      onChanged: (value) {
                        setState(() {
                          cubit.type = value!;
                        });
                      },
                      items: const ['حديد', 'حديد و فيتنس'],
                      title: 'نوع الاشتراك'),
                  const SizedBox(height: 30),
                  MyButton(
                      onTap: () {
                        if (formKey.currentState!.validate()) {
                          cubit.addClient();
                        }
                      },
                      title: 'أضافة'),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
