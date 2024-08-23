import 'dart:async';

import 'package:gymmanagement/blocs/analytics_bloc/analytics_cubit.dart';
import 'package:gymmanagement/blocs/clients_bloc/clients_cubit.dart';
import 'package:gymmanagement/blocs/employee_bloc/employee_cubit.dart';
import 'package:gymmanagement/blocs/subscriptions_bloc/subscriptions_cubit.dart';
import 'package:gymmanagement/screens/index.dart';
import 'package:gymmanagement/src/app_db.dart';
import 'package:gymmanagement/src/app_shared.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'auth_rel/onboarding_screen.dart';
import '../src/app_colors.dart';
import '../src/app_functions.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Timer? _timer;
  double size = 50;
  @override
  void initState() {
    AppFunctions.statusCheckup(
        destination: const OnboardingScreen(), context: context);
    _timer = Timer.periodic(
        const Duration(milliseconds: 10),
        (s) => setState(() {
              size = size + 1;
            }));
    if (AppShared.localStorage.getBool('active') == true) {
      BlocProvider.of<AnalyticsCubit>(context).fetchUsersAnalytics();
      BlocProvider.of<AnalyticsCubit>(context).fetchProfitAnalytics();
      BlocProvider.of<SubscriptionsCubit>(context).fetchSubscriptions();
      BlocProvider.of<EmployeeCubit>(context).fetchEmployees();
      BlocProvider.of<EmployeeCubit>(context).fetchEmployeeAttendance();
      BlocProvider.of<EmployeeCubit>(context).fetchCurrentEmployeeData();
      BlocProvider.of<EmployeeCubit>(context).fetchTreasury();
      BlocProvider.of<ClientsCubit>(context).fetchClients();
    }
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(
          const Duration(seconds: 2),
          () => Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const IndexScreen(),
              )));
    });
    super.initState();
  }

  @override
  void dispose() {
    _timer!.cancel();
    super.dispose();
  }

  checker() async {
    var queryList = (await AppDB.database!.rawQuery('SELECT * FROM employees '))
        .toList() as List<Map<String, dynamic>>;
    if (queryList.isEmpty) {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const OnboardingScreen(),
          ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.teal[800],
      body: Center(
        child: Icon(
          Icons.sports_gymnastics,
          size: size,
        ),
      ),
    );
  }
}
