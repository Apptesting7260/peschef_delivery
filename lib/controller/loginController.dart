import 'package:peschef_delivery/controller/userPrefrenceController.dart';
import 'package:peschef_delivery/data/response/status.dart';
import 'package:peschef_delivery/models/loginModel.dart';
import 'package:peschef_delivery/models/userModel.dart';
import 'package:peschef_delivery/repository/repository.dart';
import 'package:peschef_delivery/res/routes/routes_name.dart';
import 'package:peschef_delivery/utils/utils.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  final _api = Repository();

  final Rx<TextEditingController> emailController = TextEditingController().obs;
  final Rx<TextEditingController> passController = TextEditingController().obs;
  final signInGlobalKey = GlobalKey<FormState>().obs;
  final rxRequestStatus = Status.COMPLETED.obs;
  final loginData = LoginModel().obs;
  RxString error = ''.obs;
  String token = '';
  void setRxRequestStatus(Status _value) => rxRequestStatus.value = _value;
  void LoginDataSet(LoginModel _value) => loginData.value = _value;
  void setError(String _value) => error.value = _value;

  UserPreference userPreference = UserPreference();

  SignUpApi() {
    Map data = {
      'email': emailController.value.text.toString(),
      'password': passController.value.text.toString(),
    };
    setRxRequestStatus(Status.LOADING);
    _api.LoginApi(data, token).then((value) {
      setRxRequestStatus(Status.COMPLETED);
      LoginDataSet(value);

      if (loginData.value.status == true) {
        emailController.value.clear();
        passController.value.clear();
        // print("Start");

        // FirebaseDatabase.instance
        //     .ref()
        //     .child("users")
        //     .child(loginData.value.token.toString())
        //     .push()
        //     .set({
        //   "lat": 26.9633667,
        //   "long": 75.7690853,
        // });
        // print("end");
        UserModel userModel =
            UserModel(token: loginData.value.token.toString(), isLogin: true);

        userPreference.saveUser(userModel).then((value) {
          // releasing resouces because we are not going to use this

          Get.delete<LoginModel>();
          Get.offAllNamed(RouteName.tabBarScreen)!.then((value) {});
        }).onError((error, stackTrace) {});
      } else {
        Utils.toastMessage(loginData.value.message.toString());
      }
    }).onError((error, stackTrace) {
      setError(error.toString());
      // Utils.toastMessage("sorry for the inconvenience we will be back soon!!");
      print('errrrrrrrrrrrr');
      print(error);
      setRxRequestStatus(Status.ERROR);
    });
  }
}
