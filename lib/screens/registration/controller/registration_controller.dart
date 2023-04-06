import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegistrationController extends GetxController {
  final formKey = GlobalKey<FormState>();
  TextEditingController registration_email = TextEditingController();
  TextEditingController registration_password = TextEditingController();
  TextEditingController registration_re_password = TextEditingController();

  RxBool icon_password = false.obs;
  RxBool icon_re_password = false.obs;
  void change_pass(bool newValue) {
    icon_password.value = !icon_password.value;
    update();
  }

  void change_re_pass(bool newValue) {
    icon_re_password.value = !icon_re_password.value;
    update();
  }
}
