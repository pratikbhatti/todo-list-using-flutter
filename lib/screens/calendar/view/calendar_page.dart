import 'package:demo45/screens/calendar/controller/calendar_controller.dart';
import 'package:demo45/utility/color.dart';
import 'package:demo45/utility/db_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarPage extends StatefulWidget {
  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  CalendarController calendarController = Get.put(CalendarController());

  // HomeController homeController = Get.put(HomeController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // DbHelper.dbHelper.readDateData("${calendarController.today.value.month} / ${calendarController.today.value.day} / ${calendarController.today.value.year}");
    calendarController.getData();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: ColorStyle.blue,
          title: Text("Calendar View"),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(7.0),
          child: ListView(
            children: [
              // Obx(() =>
              // Text("${calendarController.today.value.month} / ${calendarController.today.value.day} / ${calendarController.today.value.year}")),
              Container(
                child: Obx(
                  () => TableCalendar(
                    firstDay: DateTime.utc(2010, 10, 16),
                    locale: "en_US",
                    rowHeight: 43,
                    headerStyle: HeaderStyle(
                        formatButtonVisible: false, titleCentered: true),
                    calendarFormat: CalendarFormat.week,
                    availableGestures: AvailableGestures.all,
                    lastDay: DateTime.utc(2030, 3, 14),
                    selectedDayPredicate: (day) {
                      calendarController.getData();
                      return isSameDay(day, calendarController.today.value);
                    },
                    focusedDay: calendarController.today.value,
                    onDaySelected: (selectedDay, focusedDay) {
                      calendarController.onDaySeleted(selectedDay, focusedDay);
                      calendarController.getData();
                      // calendarController.date.value = today as String;
                    },
                  ),
                ),
              ),

              Divider(
                color: ColorStyle.black,
              ),
              Text(
                "Your Task",
                style: GoogleFonts.poppins(
                    fontSize: 15.sp, color: ColorStyle.blue),
              ),
              Divider(
                color: ColorStyle.black,
              ),
              Obx(
                () => Container(
                  child: ListView.builder(
                    itemCount: calendarController.data.length,
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return (calendarController.data[index]['status'] == 1)
                          ? Container()
                          : Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(13),
                              ),
                              elevation: 10,
                              child: ListTile(
                                title: Text(
                                    "${calendarController.data[index]['category']}"),
                                subtitle: Text(
                                    "${calendarController.data[index]['name']}"),
                              ),
                            );
                    },
                  ),
                ),
              ),
              Divider(
                color: ColorStyle.black,
              ),
              Text(
                "Done Task",
                style: GoogleFonts.poppins(
                    fontSize: 15.sp, color: ColorStyle.blue),
              ),
              Divider(
                color: ColorStyle.black,
              ),
              Obx(() =>
              Container(
                child: ListView.builder(
                  itemCount: calendarController.data.length,
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  // shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return (calendarController.data[index]['status'] == 0)
                        ? Container()
                        : Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(13),
                            ),
                            elevation: 10,
                            child: ListTile(
                              title: Text(
                                  "${calendarController.data[index]['category']}"),
                              subtitle: Text(
                                  "${calendarController.data[index]['name']}"),
                            ),
                          );
                  },
                ),
              ),),
            ],
          ),
        ),
      ),
    );
  }
}
