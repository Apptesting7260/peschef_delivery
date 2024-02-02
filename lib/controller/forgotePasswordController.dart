import 'dart:async';

import 'package:peschef_delivery/data/response/status.dart';
import 'package:peschef_delivery/models/forgotePasswordModel.dart';
import 'package:peschef_delivery/repository/repository.dart';
import 'package:peschef_delivery/utils/utils.dart';
import 'package:peschef_delivery/view/emailVerificationScreen.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class ForgotPasswordController extends GetxController {
  final _api = Repository();

  final Rx<TextEditingController> emailController = TextEditingController().obs;

  final rxRequestStatus = Status.COMPLETED.obs;
  final forgotPasswordData = ForgotPasswordModel().obs;
  RxString error = ''.obs;

  void setRxRequestStatus(Status _value) => rxRequestStatus.value = _value;
  void SignUpSet(ForgotPasswordModel _value) =>
      forgotPasswordData.value = _value;
  void setError(String _value) => error.value = _value;
  String type = "forgot";
  String token = '';
  var secondsRemaining = 120.obs;
  var enableResend = false.obs;
  late Timer timer;
  void resendCode() {
    //other code here

    secondsRemaining.value = 120;
    enableResend.value = false;
  }

  ForgotPasswordApi(String mail) {
    Map data = {
      'email': mail,
    };
    setRxRequestStatus(Status.LOADING);
    _api.ForgotPasswordApi(data, token).then((value) {
      setRxRequestStatus(Status.COMPLETED);
      SignUpSet(value);
      if (forgotPasswordData.value.status == true) {
        Get.to(() => EmailVerificationScreen(
              email: emailController.value.text.toString(),
              type: type,
            ));
        //  Utils.toastMessage("Please Login in Your account");
      } else {
        Utils.toastMessage(forgotPasswordData.value.message.toString());
      }
      resendCode();
    }).onError((error, stackTrace) {
      setError(error.toString());
      print('errrrrrrrrrrrr');
      // Utils.toastMessage("sorry for the inconvenience we will be back soon!!");
      print(error);
      setRxRequestStatus(Status.ERROR);
    });
  }
}
