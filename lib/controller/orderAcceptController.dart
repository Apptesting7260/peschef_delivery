import 'package:peschef_delivery/controller/homeScreenController.dart';
import 'package:peschef_delivery/controller/userPrefrenceController.dart';
import 'package:peschef_delivery/data/response/status.dart';
import 'package:peschef_delivery/models/orderAcceptModel.dart';
import 'package:peschef_delivery/repository/repository.dart';
import 'package:peschef_delivery/utils/utils.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OrderAcceptController extends GetxController {
  final _api = Repository();
  final HomeScreenController homeScreenController =
      Get.put(HomeScreenController());

  final rxRequestStatus = Status.COMPLETED.obs;
  final orderAcceptData = OrderAcceptModel().obs;
  RxString error = ''.obs;

  void setRxRequestStatus(Status _value) => rxRequestStatus.value = _value;
  void OrderAcceptDataSet(OrderAcceptModel _value) =>
      orderAcceptData.value = _value;
  void setError(String _value) => error.value = _value;
  UserPreference userPreference = UserPreference();
  OrderAcceptApi(String id) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    String token = sp.getString('token') ?? "";
    Map data = {"id": id};
    setRxRequestStatus(Status.LOADING);
    _api.OrderAcceptApi(data, token).then((value) {
      setRxRequestStatus(Status.COMPLETED);
      OrderAcceptDataSet(value);
      if (orderAcceptData.value.status == true) {
        homeScreenController.HomeScreenApi();
      } else {
        Utils.toastMessage(orderAcceptData.value.message.toString());
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
