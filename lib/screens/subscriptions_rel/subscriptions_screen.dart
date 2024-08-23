import 'package:gymmanagement/blocs/subscriptions_bloc/subscriptions_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gymmanagement/components/subscriptions_screen/subscriptions_header.dart';
import 'package:gymmanagement/components/subscriptions_screen/subscriptions_tile.dart';
import 'package:gymmanagement/models/subscriptions_model.dart';
import 'package:intl/intl.dart';

import '../../blocs/subscriptions_bloc/subscriptions_cubit.dart';
import '../../src/app_colors.dart';

class SubscriptionsScreen extends StatefulWidget {
  const SubscriptionsScreen({super.key});

  @override
  _SubscriptionsScreenState createState() => _SubscriptionsScreenState();
}

class _SubscriptionsScreenState extends State<SubscriptionsScreen> {
  final TextEditingController _dateController = TextEditingController();
  final List<Subscription> _salesByDate = [];
  double _totalPrice = 0.0;
  DateTime? pickedDate;

  int mode = 0;
  void _fetchSalesData(List<Subscription> subscriptionsList) {
    setState(() {
      mode = 1;
    });
    _salesByDate.clear();
    _totalPrice = 0.0;

    for (var subscription in subscriptionsList) {
      var saleDate = DateTime.parse(subscription.dateCreated!.split(' ').first);
      if (pickedDate != null && saleDate == pickedDate) {
        _salesByDate.add(subscription);
        _totalPrice += double.tryParse(subscription.amount.toString().isEmpty
                ? '0.0'
                : subscription.amount.toString()) ??
            0.0;
      }
    }
  }

  @override
  void initState() {
    BlocProvider.of<SubscriptionsCubit>(context).fetchSubscriptions();
    pickedDate =
        DateTime.parse(DateFormat('yyyy-MM-dd').format(DateTime.now()));
    _fetchSalesData(
        BlocProvider.of<SubscriptionsCubit>(context).subscriptionsList);
    mode = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SubscriptionsCubit, SubscriptionsStates>(
      listener: (context, state) {
        if (state is SubscriptionsFailure) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
              state.msg,
              textAlign: TextAlign.center,
            ),
          ));
        }
      },
      builder: (context, state) {
        var cubit = SubscriptionsCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            backgroundColor: AppColors.teal[800],
            title: const Row(
              children: [
                Spacer(),
                Text(
                  'المبيعات',
                  style: TextStyle(color: AppColors.white),
                ),
              ],
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _salesByDate.isEmpty
                        ? const SizedBox()
                        : Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Text(
                              'إجمالي الأسعار: $_totalPrice جنية',
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                    Expanded(
                      child: TextField(
                        controller: _dateController,
                        readOnly: true,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.calendar_today),
                          labelText: 'التاريخ',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        onTap: () async {
                          pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2020),
                            lastDate: DateTime.now(),
                          );

                          if (pickedDate != null) {
                            _dateController.text =
                                DateFormat('yyyy-MM-dd').format(pickedDate!);
                            _fetchSalesData(cubit.subscriptionsList);
                          }
                        },
                      ),
                    ),
                    const SizedBox(width: 20),
                    mode == 1
                        ? ElevatedButton(
                            onPressed: () {
                              setState(() {
                                _salesByDate.clear();
                                mode = 0;
                              });
                            },
                            child: const Text('الغاء'),
                          )
                        : const SizedBox(),
                  ],
                ),
                const SizedBox(height: 20),
                mode == 1 && _salesByDate.isEmpty ||
                        mode == 0 && cubit.subscriptionsList.isEmpty
                    ? const SizedBox()
                    : const SubscriptionsHeader(),
                const SizedBox(height: 20),
                Expanded(
                  child: mode == 1 && _salesByDate.isNotEmpty
                      ? ListView.builder(
                          itemCount: _salesByDate.length,
                          itemBuilder: (context, index) {
                            var subscriptions = _salesByDate[index];
                            return SubcriptionsTile(
                                hour: subscriptions.dateCreated!
                                    .split(' ')
                                    .last
                                    .split('.')
                                    .first,
                                date:
                                    subscriptions.dateCreated!.split(' ').first,
                                duration: subscriptions.duration.toString(),
                                clientId: subscriptions.clientId.toString(),
                                subId: subscriptions.id.toString(),
                                type: subscriptions.type!,
                                amount: subscriptions.amount.toString());
                          },
                        )
                      : mode == 1 && _salesByDate.isEmpty
                          ? const Center(
                              child: Text(
                                'لا توجد اشتراكات لهذا التاريخ',
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                            )
                          : mode == 0 && cubit.subscriptionsList.isNotEmpty
                              ? ListView.builder(
                                  itemCount: cubit.subscriptionsList.length,
                                  itemBuilder: (context, index) {
                                    var subscriptions =
                                        cubit.subscriptionsList[index];
                                    return SubcriptionsTile(
                                        hour: subscriptions.dateCreated!
                                            .split(' ')
                                            .last
                                            .split('.')
                                            .first,
                                        date: subscriptions.dateCreated!
                                            .split(' ')
                                            .first,
                                        duration:
                                            subscriptions.duration.toString(),
                                        clientId:
                                            subscriptions.clientId.toString(),
                                        subId: subscriptions.id.toString(),
                                        type: subscriptions.type!,
                                        amount:
                                            subscriptions.amount.toString());
                                  },
                                )
                              : const Center(
                                  child: Text(
                                    'لا توجد اشتراكات',
                                    style: TextStyle(fontSize: 18),
                                  ),
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
