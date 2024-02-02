import 'package:peschef_delivery/controller/forgotePasswordController.dart';
import 'package:peschef_delivery/controller/userPrefrenceController.dart';
import 'package:peschef_delivery/data/response/status.dart';
import 'package:peschef_delivery/models/otpVerifyModel.dart';
import 'package:peschef_delivery/models/userModel.dart';
import 'package:peschef_delivery/repository/repository.dart';
import 'package:peschef_delivery/res/routes/routes_name.dart';
import 'package:peschef_delivery/utils/utils.dart';
import 'package:peschef_delivery/view/resetPasswordScreen.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class OtpVerifyController extends GetxController {
  final _api = Repository();

  final pinController = TextEditingController().obs;
  final focusNode = FocusNode().obs;
  final formKey = GlobalKey<FormState>().obs;
  final rxRequestStatus = Status.COMPLETED.obs;
  final otpVerifyData = OtpVerifyModel().obs;
  RxString error = ''.obs;
  var otp = ''.obs;
  String token = '';

  final ForgotPasswordController forgotPasswordController =
      Get.put(ForgotPasswordController());
  void setRxRequestStatus(Status _value) => rxRequestStatus.value = _value;
  void OtpVerifySet(OtpVerifyModel _value) => otpVerifyData.value = _value;
  void setError(String _value) => error.value = _value;

  UserPreference userPreference = UserPreference();

  OtpVerifyApi(String email, String type) {
    Map data = {
      'email': email.toString(),
      'otp': otp.toString(),
      "verify_type": type,
    };
    setRxRequestStatus(Status.LOADING);
    _api.OtpVerifyApi(data, token).then((value) {
      setRxRequestStatus(Status.COMPLETED);
      OtpVerifySet(value);

      if (otpVerifyData.value.status == true) {
        pinController.value.clear();
        forgotPasswordController.emailController.value.clear();

        //  Utils.toastMessage("Please Login in Your account");
        if (type == "SignUp") {
          UserModel userModel = UserModel(
              token: otpVerifyData.value.token.toString(), isLogin: true);

          userPreference.saveUser(userModel).then((value) {
            // releasing resouces because we are not going to use this
            Get.delete<OtpVerifyModel>();
          }).onError((error, stackTrace) {});
          Get.offAllNamed(RouteName.tabBarScreen)!.then((value) {});
        } else {
          Get.to(
              ResetPasswordScreen(token: otpVerifyData.value.token.toString()));
        }
      } else {
        Utils.toastMessage(otpVerifyData.value.message.toString());
      }
    }).onError((error, stackTrace) {
      setError(error.toString());
      print('errrrrrrrrrrrr');
      // Utils.toastMessage("sorry for the inconvenience we will be back soon!!");
      print(error);
      setRxRequestStatus(Status.ERROR);
    });
  }

  void refreshApi(String email) {
    setRxRequestStatus(Status.LOADING);
    Map data = {
      'email': email.toString(),
      'otp': otp.toString(),
    };
    _api.OtpVerifyApi(data, token).then((value) {
      setRxRequestStatus(Status.COMPLETED);
      OtpVerifySet(value);
    }).onError((error, stackTrace) {
      setError(error.toString());
      setRxRequestStatus(Status.ERROR);
    });
  }
}
