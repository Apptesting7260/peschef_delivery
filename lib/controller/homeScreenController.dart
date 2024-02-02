import 'package:peschef_delivery/data/response/status.dart';
import 'package:peschef_delivery/models/homeScreenModel.dart';
import 'package:peschef_delivery/repository/repository.dart';
import 'package:get/get.dart';

import 'package:shared_preferences/shared_preferences.dart';

class HomeScreenController extends GetxController {
  final _api = Repository();

  final rxRequestStatus = Status.COMPLETED.obs;
  final homeScreenData = HomeScreenModel().obs;
  RxString error = ''.obs;

  void setRxRequestStatus(Status _value) => rxRequestStatus.value = _value;
  void HomeScreenSet(HomeScreenModel _value) => homeScreenData.value = _value;
  void setError(String _value) => error.value = _value;

  HomeScreenApi() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    String token = sp.getString('token') ?? "";
    setRxRequestStatus(Status.LOADING);
    _api.HomeScreenApi(token).then((value) {
      setRxRequestStatus(Status.COMPLETED);
      HomeScreenSet(value);
      print(value);
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
    _api.HomeScreenApi(token).then((value) {
      setRxRequestStatus(Status.COMPLETED);
      HomeScreenSet(value);
    }).onError((error, stackTrace) {
      setError(error.toString());
      // Utils.toastMessage("sorry for the inconvenience we will be back soon!!");
      setRxRequestStatus(Status.ERROR);
    });
  }
}
