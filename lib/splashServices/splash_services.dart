import 'dart:async';

import 'package:peschef_delivery/controller/userPrefrenceController.dart';
import 'package:peschef_delivery/res/routes/routes_name.dart';
import 'package:get/get.dart';

class SplashServices {
  UserPreference userPreference = UserPreference();

  void isLogin() {
    userPreference.getUser().then((value) {
      print(value.token);
      print(value.isLogin);

      if (value.isLogin == false || value.isLogin.toString() == 'null') {
        Timer(const Duration(seconds: 3),
            () => Get.offAllNamed(RouteName.loginScreen));
      } else {
        Timer(const Duration(seconds: 3),
            () => Get.offAllNamed(RouteName.tabBarScreen));
      }
    });
  }
}
