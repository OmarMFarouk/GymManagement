import 'package:gymmanagement/blocs/employee_bloc/employee_cubit.dart';
import 'package:gymmanagement/blocs/employee_bloc/employee_states.dart';
import 'package:gymmanagement/components/general/my_snackbar.dart';
import 'package:gymmanagement/components/treasury_screen/treasury_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gymmanagement/src/app_functions.dart';

import '../../components/treasury_screen/treasury_header.dart';
import '../../src/app_colors.dart';

class TreasuryScreen extends StatefulWidget {
  const TreasuryScreen({super.key});

  @override
  State<TreasuryScreen> createState() => _TreasuryScreenState();
}

class _TreasuryScreenState extends State<TreasuryScreen> {
  @override
  void initState() {
    BlocProvider.of<EmployeeCubit>(context).fetchTreasury();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<EmployeeCubit, EmployeeStates>(
        listener: (context, state) {
      if (state is EmployeeSuccess) {
        MySnackbar.show(context: context, isError: false, msg: state.msg);
      }
      if (state is EmployeeFailure) {
        MySnackbar.show(context: context, isError: true, msg: state.msg);
      }
    }, builder: (context, state) {
      final formKey = GlobalKey<FormState>();
      var cubit = EmployeeCubit.get(context);
      return Scaffold(
        backgroundColor: AppColors.grey[200],
        appBar: AppBar(
          title: const Text(
            'الخزينة',
            style:
                TextStyle(color: AppColors.white, fontWeight: FontWeight.bold),
          ),
          backgroundColor: AppColors.teal[800],
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.grey.withOpacity(0.3),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        const Text(
                          'المبلغ المتوفر بلخزنة',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: AppColors.teal,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          AppFunctions.treasuryCalculator(cubit.treasuryList) +
                              '\tجنية', // Example balance, should be dynamically loaded

                          textDirection: TextDirection.rtl,
                          style: const TextStyle(
                            fontSize: 36,
                            fontWeight: FontWeight.bold,
                            color: AppColors.black,
                          ),
                        ),
                        const SizedBox(height: 30),
                        TextFormField(
                          controller: cubit.amountController,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(RegExp('[0-9]'))
                          ],
                          validator: (value) {
                            if (value!.isEmpty) {
                              return '*فارغ';
                            } else if (int.parse(value) == 0) {
                              return '*المبلغ غير صحيح';
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.attach_money_outlined,
                                color: AppColors.teal, size: 28),
                            label: Row(
                              children: [Spacer(), Text('المبلغ')],
                            ),
                            labelStyle: TextStyle(color: AppColors.teal),
                            border: OutlineInputBorder(),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: AppColors.teal),
                            ),
                          ),
                          textDirection: TextDirection.rtl,
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          controller: cubit.usernameController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return '*فارغ';
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.comment,
                                color: AppColors.teal, size: 28),
                            label: Row(
                              children: [Spacer(), Text('ملاحظات')],
                            ),
                            labelStyle: TextStyle(color: AppColors.teal),
                            border: OutlineInputBorder(),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: AppColors.teal),
                            ),
                          ),
                          textDirection: TextDirection.rtl,
                        ),
                        const SizedBox(height: 20),
                        Row(
                          children: [
                            Expanded(
                              child: SizedBox(
                                width: double.infinity,
                                child: ElevatedButton.icon(
                                  onPressed: () {
                                    if (formKey.currentState!.validate()) {
                                      cubit.addTreasuryRequest(isIncome: true);
                                    }
                                  },
                                  icon: const Icon(
                                    Icons.arrow_upward_rounded,
                                    color: AppColors.white,
                                  ),
                                  label: const Text(
                                    'إيداع',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.white),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 15),
                                    backgroundColor: AppColors.teal[800],
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 20),
                            Expanded(
                              child: SizedBox(
                                width: double.infinity,
                                child: ElevatedButton.icon(
                                  onPressed: () {
                                    if (int.parse(
                                            AppFunctions.treasuryCalculator(
                                                cubit.treasuryList)) <
                                        int.parse(
                                            cubit.amountController.text)) {
                                      MySnackbar.show(
                                          context: context,
                                          isError: true,
                                          msg: 'المبلغ اكبر من المتاح');
                                    } else if (formKey.currentState!
                                        .validate()) {
                                      cubit.addTreasuryRequest(isIncome: false);
                                    }
                                  },
                                  icon: const Icon(
                                    Icons.arrow_downward_rounded,
                                    color: AppColors.white,
                                  ),
                                  label: const Text(
                                    'سحب',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.white),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 15),
                                    backgroundColor: AppColors.teal[800],
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                Container(
                  alignment: Alignment.center,
                  width: double.infinity,
                  height: 300,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.grey.withOpacity(0.3),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      const TreasuryHeader(),
                      const SizedBox(
                        height: 20,
                      ),
                      Expanded(
                        child: ListView.separated(
                            itemBuilder: (context, index) => TreasuryTile(
                                createdBy: cubit.treasuryList[index].createdby!,
                                amount: cubit.treasuryList[index].amount!
                                    .toString(),
                                type: cubit.treasuryList[index].type!,
                                dateCreated: cubit
                                    .treasuryList[index].datecreated!
                                    .split(' ')
                                    .first,
                                comment: cubit.treasuryList[index].comment!),
                            separatorBuilder: (context, index) =>
                                const SizedBox(
                                  height: 15,
                                ),
                            itemCount: cubit.treasuryList.length),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      );
    });
  }
}
