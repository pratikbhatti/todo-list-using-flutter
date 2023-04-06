import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  final loginformKey = GlobalKey<FormState>();
  TextEditingController login_email = TextEditingController();
  TextEditingController login_password = TextEditingController();
  RxBool icon_password = false.obs;
  void change_pass(bool newValue) {
    icon_password.value = !icon_password.value;
    update();
  }
}
