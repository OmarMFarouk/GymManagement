import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gymmanagement/src/app_shared.dart';
import 'package:gymmanagement/src/app_presets.dart';

import '../../src/app_colors.dart';

class AppTitleBar extends StatefulWidget {
  const AppTitleBar({
    super.key,
  });

  @override
  State<AppTitleBar> createState() => _AppTitleBarState();
}

class _AppTitleBarState extends State<AppTitleBar> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          onPanDown: (details) {
            AppPresets.instance.startDragging();
          },

          // onDoubleTap: () {
          //   if (AppShared.localStorage.getBool('maximized') == true) {
          //     AppWindowsPresets.instance.restore();
          //     AppShared.localStorage.setBool('maximized', false);
          //   } else {
          //     AppWindowsPresets.instance.maximize();
          //     AppShared.localStorage.setBool('maximized', true);
          //   }

          //   setState(() {});
          // },
          child: Container(
            color: AppColors.grey.shade800,
            padding: const EdgeInsets.all(20.0),
          ),
        ),
        Row(
          children: [
            const Material(
                color: Colors.transparent,
                child: Text(
                  '\tGym Management System - made by FERO telegram: @pr0af',
                  style: TextStyle(
                      color: AppColors.white, fontWeight: FontWeight.bold),
                )),
            const Spacer(),
            IconButton(
              onPressed: () => AppPresets.instance.minimize(),
              icon: const Icon(FontAwesomeIcons.windowMinimize),
              color: AppColors.white,
            ),
            const SizedBox(
              width: 20,
            ),
            IconButton(
              onPressed: () async {
                if (AppShared.localStorage.getBool('maximized') == true) {
                  AppPresets.instance.restore();
                  AppShared.localStorage.setBool('maximized', false);
                } else {
                  AppPresets.instance.maximize();
                  AppShared.localStorage.setBool('maximized', true);
                }

                setState(() {});
              },
              icon: Icon(AppShared.localStorage.getBool('maximized') == true
                  ? FontAwesomeIcons.windowRestore
                  : FontAwesomeIcons.maximize),
              color: AppColors.white,
            ),
            const SizedBox(
              width: 20,
            ),
            IconButton(
              hoverColor: AppColors.red,
              onPressed: () async {
                await AppShared.localStorage.setBool('active', false);
                exit(0);
              },
              icon: const Icon(FontAwesomeIcons.windowClose),
              color: AppColors.white,
            ),
          ],
        ),
      ],
    );
  }
}
