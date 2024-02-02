import 'package:peschef_delivery/controller/userPrefrenceController.dart';
import 'package:peschef_delivery/data/response/status.dart';
import 'package:peschef_delivery/models/logOutModel.dart';
import 'package:peschef_delivery/repository/repository.dart';
import 'package:peschef_delivery/res/routes/routes_name.dart';
import 'package:peschef_delivery/utils/utils.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LogOutController extends GetxController {
  final _api = Repository();

  final rxRequestStatus = Status.COMPLETED.obs;
  final logOutData = LogOutModel().obs;
  RxString error = ''.obs;

  void setRxRequestStatus(Status _value) => rxRequestStatus.value = _value;
  void LogOutSet(LogOutModel _value) => logOutData.value = _value;
  void setError(String _value) => error.value = _value;
  UserPreference userPreference = UserPreference();

  LogOutApi() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    String token = sp.getString('token') ?? "";
    print("tockenf : ${token}");
    setRxRequestStatus(Status.LOADING);
    _api.LogOutApi(token).then((value) {
      setRxRequestStatus(Status.COMPLETED);
      LogOutSet(value);
      if (logOutData.value.status == true) {
        userPreference.removeUser().then((value) {
          Get.offAllNamed(RouteName.loginScreen);
        });
        FirebaseDatabase.instance.ref().child("users").child(token).remove();
        //  Utils.toastMessage("Please Login in Your account")
      } else {
        Utils.toastMessage(logOutData.value.message.toString());
      }
    }).onError((error, stackTrace) {
      setError(error.toString());
      print('errrrrrrrrrrrr');
      // Utils.toastMessage("sorry for the inconvenience we will be back soon!!");
      print(error);
      setRxRequestStatus(Status.ERROR);
    });
  }
}
