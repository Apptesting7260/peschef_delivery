import 'package:peschef_delivery/controller/homeScreenController.dart';
import 'package:peschef_delivery/controller/userPrefrenceController.dart';
import 'package:peschef_delivery/data/response/status.dart';
import 'package:peschef_delivery/models/cancelOrderModel.dart';
import 'package:peschef_delivery/repository/repository.dart';
import 'package:peschef_delivery/utils/utils.dart';
import 'package:get/get.dart';

import 'package:shared_preferences/shared_preferences.dart';

class CancelOrderController extends GetxController {
  final _api = Repository();
  final HomeScreenController homeScreenController =
      Get.put(HomeScreenController());

  final rxRequestStatus = Status.COMPLETED.obs;
  final cancelOrderData = CancelOrderModel().obs;
  RxString error = ''.obs;

  void setRxRequestStatus(Status _value) => rxRequestStatus.value = _value;
  void CancelOrderDataSet(CancelOrderModel _value) =>
      cancelOrderData.value = _value;
  void setError(String _value) => error.value = _value;
  UserPreference userPreference = UserPreference();
  CancelOrderApi(String id) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    String token = sp.getString('token') ?? "";
    Map data = {"id": id};
    setRxRequestStatus(Status.LOADING);
    _api.CancelOrderApi(data, token).then((value) {
      setRxRequestStatus(Status.COMPLETED);
      CancelOrderDataSet(value);
      if (cancelOrderData.value.status == true) {
        homeScreenController.HomeScreenApi();
        Get.back();
      } else {
        Get.back();
        Utils.toastMessage(cancelOrderData.value.message.toString());
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
