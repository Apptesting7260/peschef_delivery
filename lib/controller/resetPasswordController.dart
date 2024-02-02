import 'package:peschef_delivery/data/response/status.dart';
import 'package:peschef_delivery/models/resetPasswordModel.dart';
import 'package:peschef_delivery/repository/repository.dart';
import 'package:peschef_delivery/utils/utils.dart';
import 'package:peschef_delivery/view/successfullyScreen.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class ResetPasswordController extends GetxController {
  final _api = Repository();

  final Rx<TextEditingController> newPassController =
      TextEditingController().obs;
  final Rx<TextEditingController> confirmPassController =
      TextEditingController().obs;
  final resetPassNewGlobalKey = GlobalKey<FormState>().obs;
  final resetPassConfirmGlobalKey = GlobalKey<FormState>().obs;
  var clickResetPass = false.obs;
  RxBool isPasswordMatch = false.obs;

  void validatePassword() {
    isPasswordMatch.value =
        (newPassController.value.text == confirmPassController.value.text);
  }

  var isHidden = true.obs;
  void togglePasswordView() {
    isHidden.value = !isHidden.value;
  }

  var isHidden2 = true.obs;
  void togglePasswordView2() {
    isHidden2.value = !isHidden2.value;
  }

  final rxRequestStatus = Status.COMPLETED.obs;
  final resetPasswordData = ResetPasswordModel().obs;
  RxString error = ''.obs;

  void setRxRequestStatus(Status _value) => rxRequestStatus.value = _value;
  void ResetPasswordDataSet(ResetPasswordModel _value) =>
      resetPasswordData.value = _value;
  void setError(String _value) => error.value = _value;

  ResetPasswordApi(token) {
    Map data = {
      'password': newPassController.value.text.toString(),
      'confirm_password': confirmPassController.value.text.toString(),
    };
    setRxRequestStatus(Status.LOADING);
    _api.ResetPasswordApi(data, token).then((value) {
      setRxRequestStatus(Status.COMPLETED);
      ResetPasswordDataSet(value);
      if (resetPasswordData.value.status == true) {
        newPassController.value.clear();
        confirmPassController.value.clear();
        Get.to(() => SuccessfullyScreen());
        //  Utils.toastMessage("Please Login in Your account");
      } else {
        Utils.toastMessage(resetPasswordData.value.message.toString());
      }
    }).onError((error, stackTrace) {
      setError(error.toString());
      print('errrrrrrrrrrrr');
      print(error);
      setRxRequestStatus(Status.ERROR);
    });
  }

  void refreshApi(token) {
    setRxRequestStatus(Status.LOADING);
    Map data = {
      'password': newPassController.value.text.toString(),
      'confirm_password': confirmPassController.value.text.toString(),
    };
    _api.ResetPasswordApi(data, token).then((value) {
      setRxRequestStatus(Status.COMPLETED);
      ResetPasswordDataSet(value);
    }).onError((error, stackTrace) {
      setError(error.toString());
      // Utils.toastMessage("sorry for the inconvenience we will be back soon!!");
      setRxRequestStatus(Status.ERROR);
    });
  }
}
