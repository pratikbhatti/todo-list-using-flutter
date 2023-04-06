import 'package:demo45/screens/calendar/view/calendar_page.dart';
import 'package:demo45/screens/home/view/home_page.dart';
import 'package:get/get.dart';

class BottomNavigationController extends GetxController
{
  RxList screen = [HomePage(),CalendarPage()].obs;
  RxInt change_index = 0.obs;

  void changeIndex(int index) {
    change_index.value = index;
    update();
  }
}