import 'package:demo45/screens/home/controller/home_controller.dart';
import 'package:demo45/screens/login/controller/login_controller.dart';
import 'package:demo45/screens/login/view/login_page.dart';
import 'package:demo45/utility/color.dart';
import 'package:demo45/utility/db_helper.dart';
import 'package:demo45/utility/share_preference.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  LoginController loginController = Get.put(LoginController());
  HomeController homeController = Get.put(HomeController());

  @override
  void initState() {
    super.initState();
    // homeController.date_condition();
    homeController.getData();
    // homeController.statusFunction();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              homeController.add_data_category_name.clear();
              homeController.add_data_task_name.clear();
              AlertDialog();
            },
            icon: Icon(Icons.add),
          ),
          backgroundColor: ColorStyle.blue,
          title: Text("Appbar"),
          centerTitle: true,
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: DottedBorder(
                color: ColorStyle.black,
                strokeWidth: 3,
                child: ElevatedButton(
                  child: Text("Log Out"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorStyle.blue,
                  ),
                  onPressed: () async {
                    final prefs = await SharedPreferences.getInstance();
                    var getCheck = prefs.getBool('login');
                    loginController.login_email.clear();
                    loginController.login_password.clear();
                    getCheck = false;
                    prefs.setBool('login', getCheck);
                    var a = loginCheck();
                    Get.to(
                      LoginPage(),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(7.0),
          child: ListView(
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    child: Obx(
                      () => Text(
                        homeController.date.isEmpty
                            ? "${DateTime.now().month} / ${DateTime.now().day} / ${DateTime.now().year}"
                            : "${homeController.date}",
                        style: GoogleFonts.poppins(
                            color: ColorStyle.blue,
                            fontSize: 25.sp,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 2.5.w,
                  ),
                  Text("(month/day/year)"),

                  // IconButton(
                  //   onPressed: () async {
                  //     readOnly:
                  //     true;
                  //     DateTime? pickedDate = await showDatePicker(
                  //       context: context,
                  //       initialDate: DateTime.now(),
                  //       firstDate: DateTime(2000),
                  //       lastDate: DateTime(2101),
                  //       builder: (context, child) {
                  //         return Theme(
                  //             data: Theme.of(context).copyWith(
                  //               colorScheme: ColorScheme.light(
                  //                 primary: ColorStyle.blue, // <-- SEE HERE
                  //                 onPrimary: ColorStyle.white, // <-- SEE HERE
                  //                 // <-- SEE HERE
                  //               ),
                  //             ),
                  //             child: child!);
                  //       },
                  //     );
                  //
                  //     if (pickedDate != null) {
                  //       String formattedDate =
                  //           DateFormat("M / d / yyyy").format(pickedDate);
                  //       homeController.date.value = formattedDate;
                  //       // print(formattedDate);
                  //     } else {
                  //       print("Date is not selected");
                  //     }
                  //   },
                  //   icon: Icon(
                  //     Icons.date_range,
                  //     color: ColorStyle.blue,
                  //   ),
                  // ),
                ],
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
                () =>

                    Container(
                  // height: MediaQuery.of(context).size.height,
                  child: ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: homeController.data.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          (homeController.data[index]['status'] == 1)
                              ? Container()
                              : Slidable(
                                  endActionPane: ActionPane(
                                    motion: ScrollMotion(),
                                    children: [
                                      SlidableAction(
                                        backgroundColor: ColorStyle.blue,
                                        foregroundColor: Colors.white,
                                        icon: Icons.done,
                                        label: 'Done',
                                        onPressed: (context) {
                                          DbHelper.dbHelper.updateStatusCode(
                                              id: homeController.data[index]
                                                  ['id'],
                                              status: 1);

                                          // DbHelper.dbHelper.deleteData(
                                          //     id: homeController.data[index]['id']);
                                          homeController.getData();
                                        },
                                      ),
                                      SlidableAction(
                                        onPressed: (context) {
                                          homeController
                                                  .edit_data_task_name.text =
                                              homeController.data[index]
                                                  ['name'];
                                          homeController.edit_data_category_name
                                                  .text =
                                              homeController.data[index]
                                                  ['category'];
                                          Edit_AlertDialog(index);
                                          // homeController.getData();
                                          // homeController.statusFunction();
                                        },
                                        backgroundColor: ColorStyle.yellow,
                                        foregroundColor: ColorStyle.black,
                                        icon: Icons.edit,
                                        label: 'Edit',
                                      ),
                                      SlidableAction(
                                        onPressed: (context) {
                                          DbHelper.dbHelper.deleteData(
                                              id: homeController.data[index]
                                                  ['id']);
                                          homeController.getData();
                                        },
                                        backgroundColor: ColorStyle.red,
                                        foregroundColor: ColorStyle.white,
                                        icon: Icons.delete,
                                        label: 'Delete',
                                      ),
                                    ],
                                  ),
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(13),
                                    ),
                                    elevation: 10,
                                    child: ListTile(
                                      title: Text(
                                          "${homeController.data[index]['category']}"),
                                      subtitle: Text(
                                          "${homeController.data[index]['name']}"),
                                    ),
                                  ),
                                ),
                        ],
                      );
                    },
                  ),
                ),
              ),
              SizedBox(
                height: 2.5.h,
              ),
              Container(
                // height: MediaQuery.of(context).size.height,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
                    Obx(
                      () => ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: homeController.data.length,
                        itemBuilder: (context, index) {
                          return (homeController.data[index]['status'] == 0)
                              ? Container()
                              : Slidable(
                                  endActionPane: ActionPane(
                                    motion: ScrollMotion(),
                                    children: [
                                      SlidableAction(
                                        onPressed: (context) {
                                          DbHelper.dbHelper.updateStatusCode(
                                              id: homeController.data[index]
                                                  ['id'],
                                              status: 0);
                                          homeController.getData();
                                        },
                                        backgroundColor: ColorStyle.red,
                                        foregroundColor: ColorStyle.white,
                                        icon: Icons.remove,
                                        label: 'Remove',
                                      ),
                                    ],
                                  ),
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(13),
                                    ),
                                    elevation: 10,
                                    child: ListTile(
                                      title: Text(
                                          '${homeController.data[index]['category']}'),
                                      subtitle: Text(
                                          "${homeController.data[index]['name']}"),
                                    ),
                                  ),
                                );
                        },
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future Edit_AlertDialog(index) {
    return Get.defaultDialog(
      title: "Edit Task",
      content: Column(
        children: [
          TextFormField(
            controller: homeController.edit_data_task_name,
            style: TextStyle(color: ColorStyle.black),
            decoration: InputDecoration(
              hintText: "Enter Task Name",
              hintStyle: TextStyle(color: ColorStyle.black),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: ColorStyle.blue),
                borderRadius: BorderRadius.circular(20.0),
              ),
              border: new OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(20),
                ),
                borderSide: new BorderSide(color: ColorStyle.black),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(20),
                ),
                borderSide: BorderSide(width: 1, color: ColorStyle.blue),
              ),
            ),
          ),
          SizedBox(
            height: 5.5.h,
          ),
          TextFormField(
            controller: homeController.edit_data_category_name,
            style: TextStyle(color: ColorStyle.black),
            decoration: InputDecoration(
              hintText: "Enter Category",
              hintStyle: TextStyle(color: ColorStyle.black),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: ColorStyle.blue),
                borderRadius: BorderRadius.circular(20.0),
              ),
              border: new OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(20),
                ),
                borderSide: new BorderSide(color: ColorStyle.black),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(20),
                ),
                borderSide: BorderSide(width: 1, color: ColorStyle.blue),
              ),
            ),
          ),
          SizedBox(
            height: 2.5.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                style:
                    ElevatedButton.styleFrom(backgroundColor: ColorStyle.blue),
                onPressed: () {
                  DbHelper.dbHelper.updateData(
                      id: homeController.data[index]['id'],
                      name: homeController.edit_data_task_name.text,
                      status: 0,
                      category: homeController.edit_data_category_name.text,
                      date: homeController.date.isEmpty
                          ? "${homeController.month_name} ${DateTime.now().day}, ${DateTime.now().year}"
                          : "${homeController.date}");
                  homeController.getData();
                  // homeController.statusFunction();
                  Get.back();
                },
                child: Text("Save"),
              ),
              ElevatedButton(
                style:
                    ElevatedButton.styleFrom(backgroundColor: ColorStyle.blue),
                onPressed: () {
                  Get.back();
                },
                child: Text("Cancel"),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future AlertDialog() {
    return Get.defaultDialog(
      title: "Add Task",
      content: Column(
        children: [
          TextFormField(
            controller: homeController.add_data_task_name,
            style: TextStyle(color: ColorStyle.black),
            decoration: InputDecoration(
              hintText: "Enter Task Name",
              hintStyle: TextStyle(color: ColorStyle.black),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: ColorStyle.blue),
                borderRadius: BorderRadius.circular(20.0),
              ),
              border: new OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(20),
                ),
                borderSide: new BorderSide(color: ColorStyle.black),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(20),
                ),
                borderSide: BorderSide(width: 1, color: ColorStyle.blue),
              ),
            ),
          ),
          SizedBox(
            height: 5.5.h,
          ),
          TextFormField(
            controller: homeController.add_data_category_name,
            style: TextStyle(color: ColorStyle.black),
            decoration: InputDecoration(
              hintText: "Enter Category",
              hintStyle: TextStyle(color: ColorStyle.black),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: ColorStyle.blue),
                borderRadius: BorderRadius.circular(20.0),
              ),
              border: new OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(20),
                ),
                borderSide: new BorderSide(color: ColorStyle.black),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(20),
                ),
                borderSide: BorderSide(width: 1, color: ColorStyle.blue),
              ),
            ),
          ),
          SizedBox(
            height: 2.5.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                style:
                    ElevatedButton.styleFrom(backgroundColor: ColorStyle.blue),
                onPressed: () {
                  DbHelper.dbHelper.insertData(
                      name: homeController.add_data_task_name.text,
                      category: homeController.add_data_category_name.text,
                      status: 0,
                      date:  "${DateTime.now().month} / ${DateTime.now().day} / ${DateTime.now().year}");

                      // homeController.date.isEmpty
                      //     ? "${homeController.month_name} ${DateTime.now().day}, ${DateTime.now().year}"
                      //     : "${homeController.date}");
                  homeController.getData();
                  // homeController.statusFunction();
                  Get.back();
                },
                child: Text("Save"),
              ),
              ElevatedButton(
                style:
                    ElevatedButton.styleFrom(backgroundColor: ColorStyle.blue),
                onPressed: () {
                  Get.back();
                },
                child: Text("Cancel"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
