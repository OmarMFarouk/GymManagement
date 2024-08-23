import 'dart:io';
import 'package:flutter/services.dart';
import 'package:gymmanagement/blocs/clients_bloc/Clients_states.dart';
import 'package:gymmanagement/blocs/clients_bloc/clients_cubit.dart';
import 'package:gymmanagement/components/general/my_snackbar.dart';
import 'package:gymmanagement/models/clients_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gymmanagement/src/app_functions.dart';

import '../../components/clients_screen/clients_header.dart';
import '../../components/general/my_image_preview.dart';
import '../../src/app_colors.dart';

class ClientsScreen extends StatefulWidget {
  const ClientsScreen({super.key});

  @override
  State<ClientsScreen> createState() => _ClientsScreenState();
}

class _ClientsScreenState extends State<ClientsScreen> {
  final _searchData = [];
  void getMatch({clientList, keyWord}) {
    _searchData.clear();
    for (Client item in clientList) {
      if (item.id!.toString() == keyWord ||
          item.clientName!.toLowerCase().contains(keyWord.toLowerCase()) &&
              !_searchData.contains(item)) {
        setState(() => _searchData.add(item));
      }
      if (keyWord == "") {
        setState(() {
          _searchData.clear();
        });
      }
    }
  }

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
        return Scaffold(
          appBar: AppBar(
            title: const Row(
              children: [
                Spacer(),
                Text(
                  'قائمة المشتركين',
                  style: TextStyle(color: AppColors.white),
                ),
              ],
            ),
            backgroundColor: AppColors.teal[800],
          ),
          body: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                TextField(
                  textDirection: TextDirection.rtl,
                  onChanged: (value) {
                    getMatch(clientList: cubit.clientsList, keyWord: value);
                  },
                  decoration: const InputDecoration(
                    label: Row(
                      children: [Spacer(), Text('بحث بالاسم او رقم العضوية')],
                    ),
                    prefixIcon: Icon(Icons.search),
                  ),
                ),
                const SizedBox(height: 20),
                const ClientsHeader(),
                const SizedBox(height: 30),
                Expanded(
                  child: _searchData.isEmpty
                      ? ListView.separated(
                          itemCount: cubit.clientsList.length,
                          itemBuilder: (context, index) => clients(
                            model: cubit.clientsList[index],
                            context: context,
                          ),
                          separatorBuilder: (context, index) =>
                              const SizedBox(height: 1),
                        )
                      : ListView.separated(
                          itemCount: _searchData.length,
                          itemBuilder: (context, index) => clients(
                            model: _searchData[index]!,
                            context: context,
                          ),
                          separatorBuilder: (context, index) =>
                              const SizedBox(height: 1),
                        ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

Widget clients({required Client model, context}) {
  var nameController = TextEditingController(text: model.clientName);
  var phoneController =
      TextEditingController(text: model.clientPhone.toString());
  var idController = TextEditingController(text: model.id.toString());
  var amountCont = TextEditingController();
  var durationCont = TextEditingController();
  var typeCont = TextEditingController(text: model.clientType);
  final formKey = GlobalKey<FormState>();
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
                      content: const Text('هل تريد ان تحذف هذا المشترك؟'),
                      actions: <Widget>[
                        TextButton(
                          child: const Text('نعم'),
                          onPressed: () {
                            BlocProvider.of<ClientsCubit>(context)
                                .deleteClient(id: model.id!);
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
                                const SizedBox(height: 30),
                                TextFormField(
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return '*فارغ';
                                    }
                                    return null;
                                  },
                                  controller: nameController,
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
                                  controller: phoneController,
                                  textAlign: TextAlign.right,
                                  decoration: const InputDecoration(
                                    label: Row(
                                      children: [Spacer(), Text('رقم الهاتف')],
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 20),
                                TextField(
                                  controller: idController,
                                  enabled: false,
                                  textAlign: TextAlign.right,
                                  decoration: const InputDecoration(
                                    label: Row(
                                      children: [Spacer(), Text('رقم العضوية')],
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 20),
                                const SizedBox(height: 20),
                                TextButton(
                                  onPressed: () {
                                    if (formKey.currentState!.validate()) {
                                      BlocProvider.of<ClientsCubit>(context)
                                          .updateClient(
                                        name: nameController.text,
                                        phone: phoneController.text,
                                        id: model.id!,
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
              icon: const Icon(Icons.replay_outlined, color: AppColors.green),
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
                                    'تجديد',
                                    style: TextStyle(fontSize: 25),
                                  ),
                                ),
                                const SizedBox(height: 30),
                                TextFormField(
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly
                                  ],
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return '*فارغ';
                                    }
                                    return null;
                                  },
                                  controller: amountCont,
                                  textAlign: TextAlign.right,
                                  decoration: const InputDecoration(
                                    label: Row(
                                      children: [Spacer(), Text('المبلغ')],
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 20),
                                TextFormField(
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return '*فارغ';
                                    } else if (value.length > 2) {
                                      return '*خطأ';
                                    }
                                    return null;
                                  },
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly
                                  ],
                                  controller: durationCont,
                                  textAlign: TextAlign.right,
                                  decoration: const InputDecoration(
                                    label: Row(
                                      children: [Spacer(), Text('عدد الشهور')],
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 20),
                                TextFormField(
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return '*فارغ';
                                    } else if (value != 'حديد' &&
                                        value != 'حديد و فيتنس') {
                                      return '*الاختيارات : (حديد) أو (حديد و فيتنس)';
                                    }
                                    return null;
                                  },
                                  controller: typeCont,
                                  textAlign: TextAlign.right,
                                  decoration: const InputDecoration(
                                    label: Row(
                                      children: [Spacer(), Text('نوع العضوية')],
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 20),
                                const SizedBox(height: 20),
                                TextButton(
                                  onPressed: () {
                                    if (formKey.currentState!.validate()) {
                                      BlocProvider.of<ClientsCubit>(context)
                                          .renewClient(
                                        cType: typeCont.text,
                                        duration: int.parse(durationCont.text),
                                        amount: int.parse(amountCont.text),
                                        id: model.id!,
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
                                        'تأكيد',
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
            child: SelectableText(
              AppFunctions.durationCalculator(
                  model.lastRenewal, model.duration),
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
          ),
        ),
        Expanded(
          child: Center(
            child: InkWell(
              onTap: () => model.image == ''
                  ? BlocProvider.of<ClientsCubit>(context)
                      .setClientImage(id: model.id!)
                  : MyImagePreview.previewImage(
                      context: context, path: model.image!),
              child: CircleAvatar(
                backgroundColor: AppColors.teal.shade800,
                foregroundImage:
                    model.image!.isEmpty ? null : FileImage(File(model.image!)),
                child: const Icon(
                  Icons.add_a_photo_outlined,
                  color: AppColors.white,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Center(
            child: SelectableText(
              model.duration.toString(),
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
          ),
        ),
        Expanded(
          child: Center(
            child: SelectableText(
              model.clientType!,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
          ),
        ),
        Expanded(
          child: Center(
            child: SelectableText(
              model.clientPhone.toString(),
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
          ),
        ),
        Expanded(
          child: Center(
            child: SelectableText(
              model.clientName!,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
          ),
        ),
        Expanded(
          child: Center(
            child: SelectableText(
              model.id.toString(),
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
          ),
        ),
      ],
    ),
  );
}
