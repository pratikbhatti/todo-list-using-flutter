import 'package:demo45/screens/bottomNavigation/view/bottom_navigation_page.dart';
import 'package:demo45/screens/home/view/home_page.dart';
import 'package:demo45/screens/login/controller/login_controller.dart';
import 'package:demo45/screens/registration/view/registration_page.dart';
import 'package:demo45/utility/color.dart';
import 'package:demo45/utility/share_preference.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  LoginController loginController = Get.put(LoginController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorStyle.blue,
      body: Form(
        key: loginController.loginformKey,
        child: Center(
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(80),
            ),
            elevation: 20,
            child: Container(
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width / 1.2,
              height: MediaQuery.of(context).size.height / 2,
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
                      "Login",
                      style: GoogleFonts.acme(fontSize: 25.sp),
                    ),
                    SizedBox(
                      height: 7.h,
                    ),
                    TextFormField(
                      controller: loginController.login_email,
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
                        controller: loginController.login_password,
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
                            loginController.icon_password.value == false
                                ? true
                                : false,
                        style: TextStyle(color: ColorStyle.black),
                        decoration: InputDecoration(
                          hintText: 'Enter Password',
                          hintStyle: TextStyle(color: ColorStyle.black),
                          prefixIcon: Obx(
                            () => IconButton(
                              onPressed: () {
                                loginController.change_pass(
                                    loginController.icon_password.value);
                                // providerTrue!.change_pass(pass);
                              },
                              icon: Icon(
                                (loginController.icon_password == true)
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Not Account"),
                        TextButton(
                          onPressed: () {
                            Get.to(RegistrationPage());
                          },
                          child: Text("Create Account"),
                        ),
                      ],
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        String? email = await readEmail();
                        String? password = await readPassword();
                        if (loginController.loginformKey.currentState!
                            .validate()) {
                          if (loginController.login_email.text != email) {
                            Fluttertoast.showToast(
                                msg: "Email Id Not Same",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.TOP,
                                timeInSecForIosWeb: 1,
                                backgroundColor: ColorStyle.red,
                                textColor: ColorStyle.white,
                                fontSize: 14.0);
                          } else if (loginController.login_password.text !=
                              password) {
                            Fluttertoast.showToast(
                                msg: "Password Is Not Same",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.TOP,
                                timeInSecForIosWeb: 1,
                                backgroundColor: ColorStyle.red,
                                textColor: ColorStyle.white,
                                fontSize: 14.0);
                          } else {
                            login();
                            bool? checkLogin = await loginCheck();
                            Get.snackbar(
                              "Successfully Login",
                              "Go to the task page",
                              snackPosition: SnackPosition.TOP,
                              backgroundColor: ColorStyle.green,
                              duration: const Duration(seconds: 2),
                            );
                            Get.off(
                              BottomNavigationPage(),
                            );
                          }
                        }
                      },
                      child: Text("Login"),
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
