import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/analytics_bloc/analytics_cubit.dart';
import '../../blocs/analytics_bloc/analytics_states.dart';
import '../../components/analytics_screen/chart.dart';
import '../../models/chart_model.dart';
import '../../src/app_colors.dart';

class AnalyticsScreen extends StatefulWidget {
  const AnalyticsScreen({super.key});

  @override
  State<AnalyticsScreen> createState() => _AnalyticsScreenState();
}

class _AnalyticsScreenState extends State<AnalyticsScreen> {
  @override
  void initState() {
    BlocProvider.of<AnalyticsCubit>(context).fetchUsersAnalytics();
    BlocProvider.of<AnalyticsCubit>(context).fetchProfitAnalytics();
    super.initState();
  }

  Widget build(BuildContext context) {
    return BlocConsumer<AnalyticsCubit, AnalyticsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = AnalyticsCubit.get(context);

        return Scaffold(
          backgroundColor: AppColors.grey[200],
          appBar: AppBar(
            title: const Text('إحصائيات عامة',
                style: TextStyle(color: AppColors.white)),
            backgroundColor: AppColors.teal[800],
          ),
          body: ListView(
            children: [
              MyChart(
                isTransposed: true,
                title: 'إحصائيات المشتركين',
                xTitle: 'التاريخ',
                yTitle: 'العدد',
                dataSource: ChartModel.getColumnsData(cubit.usersAnalytics),
              ),
              MyChart(
                isTransposed: false,
                title: 'إحصائيات الأرباح',
                xTitle: 'التاريخ',
                yTitle: 'المبلغ',
                dataSource: ChartModel.getColumnsData(cubit.profitAnalytics),
              ),
            ],
          ),
        );
      },
    );
  }
}

final List<Map> profits = [
  {"date": "1/7/2024", "value": double.parse('900')},
  {"date": "2/7/2024", "value": double.parse('600')},
  {"date": "3/7/2024", "value": double.parse('1200')},
  {"date": "4/7/2024", "value": double.parse('1800')},
  {"date": "5/7/2024", "value": double.parse('300')}
];
