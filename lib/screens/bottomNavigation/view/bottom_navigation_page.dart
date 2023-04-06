import 'package:demo45/screens/bottomNavigation/controller/bottom_navigation_controller.dart';
import 'package:demo45/utility/color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BottomNavigationPage extends StatefulWidget {
  const BottomNavigationPage({Key? key}) : super(key: key);

  @override
  State<BottomNavigationPage> createState() => _BottomNavigationPageState();
}

class _BottomNavigationPageState extends State<BottomNavigationPage> {
  BottomNavigationController bottomNavigationController =
      Get.put(BottomNavigationController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Obx(
        () => Scaffold(
          body: bottomNavigationController
              .screen[bottomNavigationController.change_index.value],
          bottomNavigationBar: BottomNavigationBar(

            currentIndex: bottomNavigationController.change_index.value,
            selectedItemColor: ColorStyle.blue,
            unselectedItemColor: ColorStyle.black,
            onTap: (index) {
              bottomNavigationController.changeIndex(index);
            },
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: "home",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.calendar_month_outlined),
                label: "calendar",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
