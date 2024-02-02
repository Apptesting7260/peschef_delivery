import 'package:peschef_delivery/data/response/status.dart';
import 'package:peschef_delivery/models/recentOrdersModel.dart';
import 'package:peschef_delivery/repository/repository.dart';
import 'package:get/get.dart';

import 'package:shared_preferences/shared_preferences.dart';

class RecentOrderController extends GetxController {
  final _api = Repository();

  final rxRequestStatus = Status.COMPLETED.obs;
  final recentOrderData = RecentOrderModel().obs;
  RxString error = ''.obs;

  void setRxRequestStatus(Status _value) => rxRequestStatus.value = _value;
  void RecentOrderSet(RecentOrderModel _value) =>
      recentOrderData.value = _value;
  void setError(String _value) => error.value = _value;

  RecentOrderApi() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    String token = sp.getString('token') ?? "";
    setRxRequestStatus(Status.LOADING);
    _api.RecentOrderApi(token).then((value) {
      setRxRequestStatus(Status.COMPLETED);
      RecentOrderSet(value);
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
    _api.RecentOrderApi(token).then((value) {
      setRxRequestStatus(Status.COMPLETED);
      RecentOrderSet(value);
    }).onError((error, stackTrace) {
      setError(error.toString());
      // Utils.toastMessage("sorry for the inconvenience we will be back soon!!");
      setRxRequestStatus(Status.ERROR);
    });
  }
}
