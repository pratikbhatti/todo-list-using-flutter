import 'package:demo45/screens/home/view/home_page.dart';
import 'package:demo45/screens/login/view/login_page.dart';
import 'package:demo45/screens/splash/view/splash_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'screens/bottomNavigation/view/bottom_navigation_page.dart';
import 'screens/calendar/view/calendar_page.dart';
import 'screens/registration/view/registration_page.dart';

void main() {
  runApp(
    ScreenUtilInit(
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          home: SplashPage(),
        );
      },
    ),
  );
}
