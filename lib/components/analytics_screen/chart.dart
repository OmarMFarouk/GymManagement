import 'package:flutter/material.dart';
import 'package:gymmanagement/models/chart_model.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../src/app_colors.dart';

class MyChart extends StatelessWidget {
  const MyChart(
      {super.key,
      required this.isTransposed,
      required this.title,
      required this.xTitle,
      required this.yTitle,
      this.dataSource});
  final bool isTransposed;
  final String title, xTitle, yTitle;
  final dynamic dataSource;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      height: MediaQuery.of(context).size.height * 0.4,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppColors.teal[800],
        boxShadow: [
          BoxShadow(
            color: AppColors.grey.withOpacity(0.5),
            spreadRadius: 4,
            blurRadius: 1,
            offset: const Offset(0, 3),
          ),
        ],
        borderRadius: BorderRadius.circular(15),
      ),
      child: SfCartesianChart(
          isTransposed: isTransposed,
          title: ChartTitle(
              text: title,
              textStyle: const TextStyle(color: AppColors.white, fontSize: 22)),
          primaryXAxis: CategoryAxis(
              title: AxisTitle(
                  text: xTitle,
                  textStyle: const TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: AppColors.white)),
              labelStyle: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColors.white)),
          primaryYAxis: NumericAxis(
              interval: isTransposed == false ? 300 : 2,
              title: AxisTitle(
                  text: yTitle,
                  textStyle: const TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: AppColors.white)),
              labelStyle: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColors.white)),
          tooltipBehavior: TooltipBehavior(
              header: title,
              enable: true,
              activationMode: ActivationMode.singleTap),
          series: [
            ColumnSeries<ChartModel, String>(
              color: Colors.cyanAccent.withAlpha(100),
              xValueMapper: (users, index) => users.x,
              yValueMapper: (users, index) => users.y,
              enableTooltip: true,
              dataSource: dataSource,
            )
          ]),
    );
  }
}
