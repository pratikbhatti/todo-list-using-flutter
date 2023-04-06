import 'package:demo45/utility/db_helper.dart';
import 'package:get/get.dart';

class CalendarController extends GetxController {
  RxList<Map> data = <Map>[].obs;
  RxString month_name = "".obs;
  RxString date = "".obs;
  Rx<DateTime> today = DateTime.now().obs;

  void getData() async
  {
    print("${today.value.month} / ${today.value.day} / ${today.value.year}");
    data.value = await DbHelper.dbHelper.readDateData("${today.value.month} / ${today.value.day} / ${today.value.year}");
    // print(data[0]['name']);
  }

  void onDaySeleted(DateTime day, DateTime focusedDay) {
    today.value = day;
    update();
  }

  // void calendar_date_condition() {
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
