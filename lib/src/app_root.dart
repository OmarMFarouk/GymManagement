import 'package:gymmanagement/blocs/analytics_bloc/analytics_cubit.dart';
import 'package:gymmanagement/blocs/clients_bloc/clients_cubit.dart';
import 'package:gymmanagement/blocs/subscriptions_bloc/subscriptions_cubit.dart';
import 'package:gymmanagement/screens/auth_rel/onboarding_screen.dart';
import 'package:gymmanagement/screens/auth_rel/portal_screen.dart';
import 'package:gymmanagement/src/app_shared.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gymmanagement/screens/splash_screen.dart';

import '../blocs/auth_bloc/auth_bloc/auth_cubit.dart';
import '../blocs/employee_bloc/employee_cubit.dart';

class AppRoot extends StatelessWidget {
  const AppRoot({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AnalyticsCubit()),
        BlocProvider(create: (context) => SubscriptionsCubit()),
        BlocProvider(create: (context) => EmployeeCubit()),
        BlocProvider(create: (context) => AuthCubit()),
        BlocProvider(create: (context) => ClientsCubit())
      ],
      child: MaterialApp(
        theme: ThemeData(fontFamily: 'Cairo'),
        title: 'Gym Management',
        debugShowCheckedModeBanner: false,
        home: AppShared.localStorage.getBool('onboarded') == true
            ? AppShared.localStorage.getBool('active') == true
                ? const SplashScreen()
                : const PortalScreen()
            : const OnboardingScreen(),
      ),
    );
  }
}
