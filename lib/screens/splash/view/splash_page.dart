import 'dart:async';

import 'package:demo45/screens/bottomNavigation/view/bottom_navigation_page.dart';
import 'package:demo45/screens/home/view/home_page.dart';
import 'package:demo45/screens/login/view/login_page.dart';
import 'package:demo45/utility/color.dart';
import 'package:demo45/utility/share_preference.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Timer(
      Duration(seconds: 5),
      () async {
        bool? checkLogin = await loginCheck();

        if (checkLogin == true) {
          Get.off(
            BottomNavigationPage(),
          );
        } else {
          Get.off(
            LoginPage(),
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorStyle.blue,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Task Me",
              style:
                  GoogleFonts.tillana(fontSize: 32.sp, color: ColorStyle.white),
            ),
            SizedBox(
              height: 12.h,
            ),
            CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
