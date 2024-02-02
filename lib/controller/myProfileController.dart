import 'package:peschef_delivery/data/response/status.dart';
import 'package:peschef_delivery/models/myProfileModel.dart';
import 'package:peschef_delivery/repository/repository.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyProfileController extends GetxController {
  final _api = Repository();

  final rxRequestStatus = Status.COMPLETED.obs;
  final myProfileData = MyProfileModel().obs;
  RxString error = ''.obs;

  void setRxRequestStatus(Status _value) => rxRequestStatus.value = _value;
  void MyProfileSet(MyProfileModel _value) => myProfileData.value = _value;
  void setError(String _value) => error.value = _value;

  MyProfileApi() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    String token = sp.getString('token') ?? "";
    setRxRequestStatus(Status.LOADING);
    _api.MyProfileApi(token).then((value) {
      setRxRequestStatus(Status.COMPLETED);
      MyProfileSet(value);
    }).onError((error, stackTrace) {
      setError(error.toString());
      print('errrrrrrrrrrrr');
      // Utils.toastMessage("sorry for the inconvenience we will be back soon!!");
      print(error);
      setRxRequestStatus(Status.ERROR);
    });
  }

  Future<void> refreshApi() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    String token = sp.getString('token') ?? "";
    setRxRequestStatus(Status.LOADING);
    _api.MyProfileApi(token).then((value) {
      setRxRequestStatus(Status.COMPLETED);
      MyProfileSet(value);
    }).onError((error, stackTrace) {
      setError(error.toString());
      // Utils.toastMessage("sorry for the inconvenience we will be back soon!!");
      setRxRequestStatus(Status.ERROR);
    });
  }
}
