import 'package:peschef_delivery/controller/homeScreenController.dart';
import 'package:peschef_delivery/controller/userPrefrenceController.dart';
import 'package:peschef_delivery/data/response/status.dart';
import 'package:peschef_delivery/models/orderPickedModel.dart';
import 'package:peschef_delivery/models/orderPickedModel.dart';
import 'package:peschef_delivery/repository/repository.dart';
import 'package:peschef_delivery/utils/utils.dart';
import 'package:get/get.dart';
import 'package:peschef_delivery/view/customerTrack.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OrderPickedController extends GetxController {
  final _api = Repository();
  final rxRequestStatus = Status.COMPLETED.obs;
  final orderPickedData = OrderPickedModel().obs;
  RxString error = ''.obs;

  void setRxRequestStatus(Status _value) => rxRequestStatus.value = _value;
  void OrderPickedDataSet(OrderPickedModel _value) =>
      orderPickedData.value = _value;
  void setError(String _value) => error.value = _value;
  UserPreference userPreference = UserPreference();
  OrderPickedApi(String id) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    String token = sp.getString('token') ?? "";
    Map data = {"id": id};
    setRxRequestStatus(Status.LOADING);
    _api.OrderPickedApi(data, token).then((value) {
      setRxRequestStatus(Status.COMPLETED);
      OrderPickedDataSet(value);
      if (orderPickedData.value.status == true) {
        // homeScreenController.HomeScreenApi();
        Get.to(() => CustomerTrackScreen());
      } else {
        Utils.toastMessage(orderPickedData.value.message.toString());
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
