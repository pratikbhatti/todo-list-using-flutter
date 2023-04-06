import 'package:demo45/utility/db_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  RxString month_name = "".obs;
  RxString current_date = "".obs;
  RxString date = "".obs;
  TextEditingController add_data_task_name = TextEditingController();
  TextEditingController add_data_category_name = TextEditingController();
  TextEditingController edit_data_task_name = TextEditingController();
  TextEditingController edit_data_category_name = TextEditingController();
  RxList TodoList = [].obs;
  RxList DoneList = [].obs;
  RxList<Map> data = <Map>[].obs;
  // RxList status =[].obs;
  // Rx/

  void getData() async
  {
    data.value = await DbHelper.dbHelper.readData();
  }



  // void date_condition() {
  //   if (DateTime.now().month == 1) {
  //     month_name.value = 'January';
  //   } else if (DateTime.now().month == 2) {
  //     month_name.value = 'February';
  //   } else if (DateTime.now().month == 3) {
  //     month_name.value = 'March';
  //   } else if (DateTime.now().month == 4) {
  //     month_name.value = 'April';
  //   } else if (DateTime.now().month == 5) {
  //     month_name.value = 'May';
  //   } else if (DateTime.now().month == 6) {
  //     month_name.value = 'June';
  //   } else if (DateTime.now().month == 7) {
  //     month_name.value = 'july';
  //   } else if (DateTime.now().month == 8) {
  //     month_name.value = 'August';
  //   } else if (DateTime.now().month == 9) {
  //     month_name.value = 'September';
  //   } else if (DateTime.now().month == 10) {
  //     month_name.value = 'October';
  //   } else if (DateTime.now().month == 11) {
  //     month_name.value = 'November';
  //   } else if (DateTime.now().month == 12) {
  //     month_name.value = 'December';
  //   }
  //   update();
  // }
}
