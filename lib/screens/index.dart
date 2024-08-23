import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gymmanagement/blocs/employee_bloc/employee_cubit.dart';
import 'package:gymmanagement/components/general/my_image_preview.dart';
import 'package:gymmanagement/components/index/sidebar_item.dart';
import 'package:gymmanagement/screens/analytics_rel/analytics_screen.dart';
import 'package:gymmanagement/screens/client_rel/add_client_screen.dart';
import 'package:gymmanagement/screens/client_rel/clients_screen.dart';
import 'package:gymmanagement/screens/employee_rel/employees_screen.dart';
import 'package:gymmanagement/screens/subscriptions_rel/subscriptions_screen.dart';
import 'package:gymmanagement/screens/treasury_rel_scrs/treasury_screen.dart';
import 'package:gymmanagement/src/app_functions.dart';
import 'package:gymmanagement/src/app_shared.dart';
import 'package:restartfromos/restartatos.dart';

import '../components/general/my_app_title_bar.dart';
import '../src/app_colors.dart';

class IndexScreen extends StatefulWidget {
  const IndexScreen({super.key});

  @override
  State<IndexScreen> createState() => _IndexScreenState();
}

List<Widget> screens = [
  const AddClientScreen(),
  const ClientsScreen(),
  const SubscriptionsScreen(),
  const EmployeeScreen(),
  const TreasuryScreen(),
  const AnalyticsScreen(),
];
int currentIndex = 0;
PageController pageController = PageController(initialPage: currentIndex);

class _IndexScreenState extends State<IndexScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const AppTitleBar(),
        Expanded(
          child: Row(
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                width: MediaQuery.of(context).size.width * 0.155,
                child: Column(
                  children: [
                    Material(
                      color: Colors.transparent,
                      child: Row(
                        children: [
                          InkWell(
                            borderRadius: BorderRadius.circular(15),
                            onTap: () =>
                                AppShared.localStorage.getString('logo') == null
                                    ? AppFunctions.setAppLogo()
                                    : MyImagePreview.previewImage(
                                        context: context,
                                        path: AppShared.localStorage
                                            .getString('logo')!),
                            child: CircleAvatar(
                              radius: 30,
                              backgroundColor: AppColors.teal[800],
                              foregroundImage:
                                  AppShared.localStorage.getString('logo') ==
                                          null
                                      ? null
                                      : FileImage(File(AppShared.localStorage
                                          .getString('logo')!)),
                              child: const Icon(
                                Icons.add_a_photo_outlined,
                                color: AppColors.white,
                              ),
                            ),
                          ),
                          const Spacer(),
                          Text(
                            ',مرحبََا\n${currentEmployee.username}',
                            style: const TextStyle(
                                color: AppColors.white, fontSize: 18),
                            textAlign: TextAlign.end,
                          )
                        ],
                      ),
                    ),
                    const Divider(),
                    SideBarItem(
                        onTap: () {
                          pageController.animateToPage(0,
                              duration: Durations.extralong4,
                              curve: Curves.fastEaseInToSlowEaseOut);
                        },
                        title: 'أضافة',
                        icon: Icons.add,
                        isCurrent: currentIndex == 0 ? true : false),
                    const SizedBox(
                      height: 20,
                    ),
                    SideBarItem(
                        onTap: () {
                          pageController.animateToPage(1,
                              duration: Durations.extralong4,
                              curve: Curves.fastEaseInToSlowEaseOut);
                        },
                        title: 'المشتركين',
                        icon: Icons.people,
                        isCurrent: currentIndex == 1 ? true : false),
                    const SizedBox(
                      height: 20,
                    ),
                    SideBarItem(
                        onTap: () {
                          pageController.animateToPage(2,
                              duration: Durations.extralong4,
                              curve: Curves.fastEaseInToSlowEaseOut);
                        },
                        title: 'الأشتراكات',
                        icon: Icons.receipt_long_sharp,
                        isCurrent: currentIndex == 2 ? true : false),
                    const SizedBox(
                      height: 20,
                    ),
                    currentEmployee.role == 'admin'
                        ? SideBarItem(
                            onTap: () {
                              pageController.animateToPage(3,
                                  duration: Durations.extralong4,
                                  curve: Curves.fastEaseInToSlowEaseOut);
                            },
                            title: 'الموظفين',
                            icon: Icons.person_pin_outlined,
                            isCurrent: currentIndex == 3 ? true : false)
                        : const Divider(),
                    const SizedBox(
                      height: 20,
                    ),
                    SideBarItem(
                        onTap: () {
                          pageController.animateToPage(4,
                              duration: Durations.extralong4,
                              curve: Curves.fastEaseInToSlowEaseOut);
                        },
                        title: 'الخزينة',
                        icon: Icons.calculate_outlined,
                        isCurrent: currentIndex == 4 ? true : false),
                    const SizedBox(
                      height: 20,
                    ),
                    SideBarItem(
                        onTap: () {
                          pageController.animateToPage(5,
                              duration: Durations.extralong4,
                              curve: Curves.fastEaseInToSlowEaseOut);
                        },
                        title: 'إحصائيات',
                        icon: Icons.analytics_outlined,
                        isCurrent: currentIndex == 5 ? true : false),
                    const SizedBox(
                      height: 20,
                    ),
                    const Spacer(),
                    SideBarItem(
                        onTap: () async {
                          await AppShared.localStorage.setBool('active', false);
                          RestartFromOS.restartApp(appName: 'gymmanagement');
                        },
                        title: 'تسجيل الخروج',
                        icon: Icons.logout,
                        isCurrent: false)
                  ],
                ),
              ),
              Expanded(
                  child: PageView(
                      physics: const NeverScrollableScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      controller: pageController,
                      onPageChanged: (value) {
                        setState(() {
                          currentIndex = value;
                        });
                      },
                      children: screens))
            ],
          ),
        ),
      ],
    );
  }
}
