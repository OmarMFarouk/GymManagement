import 'package:flutter/services.dart';
import 'package:gymmanagement/blocs/auth_bloc/auth_bloc/auth_cubit.dart';
import 'package:gymmanagement/blocs/auth_bloc/auth_bloc/auth_states.dart';
import 'package:gymmanagement/screens/auth_rel/onboarding_screen.dart';
import 'package:gymmanagement/src/app_functions.dart';
import 'package:gymmanagement/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../components/general/my_app_title_bar.dart';
import '../../components/general/my_snackbar.dart';
import '../../src/app_colors.dart';

class PortalScreen extends StatefulWidget {
  const PortalScreen({super.key});

  @override
  _PortalScreenState createState() => _PortalScreenState();
}

class _PortalScreenState extends State<PortalScreen> {
  @override
  void initState() {
    AppFunctions.statusCheckup(
        destination: const OnboardingScreen(), context: context);
    super.initState();
  }

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthStates>(listener: (context, state) {
      if (state is AuthError) {
        MySnackbar.show(context: context, isError: true, msg: state.msg);
      }
      if (state is AuthSuccess) {
        MySnackbar.show(context: context, isError: false, msg: state.msg);
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const SplashScreen(),
            ));
      }
    }, builder: (context, state) {
      var cubit = AuthCubit.get(context);

      return Scaffold(
        body: Column(
          children: [
            const AppTitleBar(),
            Expanded(
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Image.asset(
                      'assets/images/bg.jpg',
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned.fill(
                    child: Container(
                      color: AppColors.black
                          .withOpacity(0.4), // semi-transparent overlay
                    ),
                  ),
                  Center(
                    child: Card(
                      color: AppColors.white.withOpacity(0.9),
                      child: Container(
                        width: 500,
                        padding: const EdgeInsets.all(80),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    FontAwesomeIcons.store,
                                    size: 40,
                                    color: AppColors.teal[800],
                                  ),
                                  const SizedBox(width: 10),
                                  Text(
                                    'تسجيل الدخول',
                                    style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.teal[800],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 30),
                              DropdownButtonFormField<String>(
                                value: cubit.selectedRole,
                                items: ['admin', 'employee'].map((role) {
                                  return DropdownMenuItem(
                                    value: role,
                                    child: Row(
                                      children: [
                                        Icon(
                                          role == 'admin'
                                              ? FontAwesomeIcons.userShield
                                              : FontAwesomeIcons.userTie,
                                          size: 20,
                                          color: AppColors.teal[800],
                                        ),
                                        const SizedBox(width: 10),
                                        Text(role == 'admin' ? 'أدمن' : 'موظف'),
                                      ],
                                    ),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  setState(() {
                                    cubit.selectedRole = value!;
                                  });
                                },
                                decoration: InputDecoration(
                                  labelText: 'حدد الرتبة',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 20),
                              TextFormField(
                                inputFormatters: [
                                  FilteringTextInputFormatter.deny(' ')
                                ],
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return '*فارغ';
                                  }
                                  return null;
                                },
                                controller: cubit.usernameCont,
                                decoration: InputDecoration(
                                  labelText: 'اسم المستخدم',
                                  prefixIcon: Icon(
                                    FontAwesomeIcons.idBadge,
                                    color: AppColors.teal[800],
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 30),
                              TextFormField(
                                inputFormatters: [
                                  FilteringTextInputFormatter.deny(' ')
                                ],
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return '*فارغ';
                                  }
                                  return null;
                                },
                                controller: cubit.passwordCont,
                                obscureText: true,
                                decoration: InputDecoration(
                                  labelText: 'الرقم السري',
                                  prefixIcon: Icon(
                                    FontAwesomeIcons.lock,
                                    color: AppColors.teal[800],
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 30),
                              ElevatedButton(
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    cubit.loginUser();
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 20, horizontal: 30),
                                  backgroundColor: AppColors.teal[800],
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                child: const SizedBox(
                                  width: double.infinity,
                                  child: Center(
                                    child: Text(
                                      'تسجيل الدخول',
                                      style: TextStyle(
                                          fontSize: 18, color: AppColors.white),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }
}
