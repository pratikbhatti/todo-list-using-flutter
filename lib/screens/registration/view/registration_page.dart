import 'package:demo45/screens/login/view/login_page.dart';
import 'package:demo45/screens/registration/controller/registration_controller.dart';
import 'package:demo45/utility/color.dart';
import 'package:demo45/utility/share_preference.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  RegistrationController registrationController =
      Get.put(RegistrationController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorStyle.blue,
      body: Form(
        key: registrationController.formKey,
        child: Center(
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(80),
            ),
            elevation: 20,
            child: Container(
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width / 1.2,
              height: MediaQuery.of(context).size.height / 1.8,
              decoration: BoxDecoration(
                color: ColorStyle.white,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    Container(
                      width: ScreenUtil().setWidth(50),
                      height: ScreenUtil().setWidth(50),
                      child: Image.asset("assets/images/login_system.png"),
                    ),
                    Text(
                      "Registration",
                      style: GoogleFonts.acme(fontSize: 25.sp),
                    ),
                    SizedBox(
                      height: 7.h,
                    ),
                    TextFormField(
                      controller: registrationController.registration_email,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "PLease Enter Your Email";
                        }
                        if (!RegExp(
                                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                            .hasMatch(value)) {
                          return "Please enter a valid email address";
                        } else {
                          return null;
                        }
                      },
                      style: TextStyle(color: ColorStyle.black),
                      decoration: InputDecoration(
                        hintText: "Enter Email",
                        hintStyle: TextStyle(color: ColorStyle.black),
                        prefixIcon: Icon(Icons.email, color: ColorStyle.black),
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
                          borderSide:
                              BorderSide(width: 1, color: ColorStyle.blue),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 7.h,
                    ),
                    Obx(
                      () => TextFormField(
                        controller:
                            registrationController.registration_password,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "PLease Enter Your Password";
                          }
                          if (!RegExp(
                                  r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$')
                              .hasMatch(value)) {
                            return "Please enter a valid Password";
                          } else {
                            return null;
                          }
                        },
                        obscureText:
                            registrationController.icon_password.value == false
                                ? true
                                : false,
                        style: TextStyle(color: ColorStyle.black),
                        decoration: InputDecoration(
                          hintText: 'Enter Password',
                          hintStyle: TextStyle(color: ColorStyle.black),
                          prefixIcon: Obx(
                            () => IconButton(
                              onPressed: () {
                                registrationController.change_pass(
                                    registrationController.icon_password.value);
                              },
                              icon: Icon(
                                (registrationController.icon_password == true)
                                    ? Icons.lock_open
                                    : Icons.lock,
                                color: ColorStyle.black,
                              ),
                            ),
                          ),
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
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 8.h,
                    ),
                    Obx(
                      () => TextFormField(
                        controller:
                            registrationController.registration_re_password,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "PLease Enter Your Re Password";
                          }
                          if (!RegExp(
                                  r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$')
                              .hasMatch(value)) {
                            return "Please enter a valid Re Password";
                          } else {
                            return null;
                          }
                        },
                        obscureText:
                            registrationController.icon_re_password.value ==
                                    false
                                ? true
                                : false,
                        style: TextStyle(color: ColorStyle.black),
                        decoration: InputDecoration(
                          hintText: 'Enter Re Password',
                          hintStyle: TextStyle(color: ColorStyle.black),
                          prefixIcon: Obx(
                            () => IconButton(
                              onPressed: () {
                                registrationController.change_re_pass(
                                    registrationController
                                        .icon_re_password.value);
                              },
                              icon: Icon(
                                (registrationController.icon_re_password ==
                                        true)
                                    ? Icons.lock_open
                                    : Icons.lock,
                                color: ColorStyle.black,
                              ),
                            ),
                          ),
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
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 7.h,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (registrationController.formKey.currentState!
                            .validate()) {
                          if (registrationController
                                  .registration_password.text !=
                              registrationController
                                  .registration_re_password.text) {
                            Fluttertoast.showToast(
                                msg: "Password and re password are not same",
                                toastLength: Toast.LENGTH_SHORT,
                                timeInSecForIosWeb: 1,
                                gravity: ToastGravity.TOP,
                                backgroundColor: ColorStyle.red,
                                textColor: ColorStyle.white,
                                fontSize: 14.0);
                          } else {
                            save(
                                registrationController.registration_email.text,
                                registrationController
                                    .registration_password.text,
                                registrationController
                                    .registration_re_password.text);
                            Get.snackbar(
                              "Successfully Registration",
                              "Please login",
                              snackPosition: SnackPosition.TOP,
                              backgroundColor: ColorStyle.green,
                              duration: const Duration(seconds: 2),
                            );
                            Get.to(LoginPage());
                          }
                        }
                      },
                      child: Text("Registration"),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
