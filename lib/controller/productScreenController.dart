import 'package:peschef_delivery/controller/homeScreenController.dart';
import 'package:peschef_delivery/controller/userPrefrenceController.dart';
import 'package:peschef_delivery/data/response/status.dart';
import 'package:peschef_delivery/models/productScreenModel.dart';

import 'package:peschef_delivery/repository/repository.dart';
import 'package:peschef_delivery/utils/utils.dart';
import 'package:get/get.dart';

import 'package:shared_preferences/shared_preferences.dart';

class ProductScreenController extends GetxController {
  final _api = Repository();
  final HomeScreenController homeScreenController =
      Get.put(HomeScreenController());

  final rxRequestStatus = Status.COMPLETED.obs;
  final productScreenData = ProductScreenModel().obs;
  RxString error = ''.obs;

  void setRxRequestStatus(Status _value) => rxRequestStatus.value = _value;
  void ProductScreenDataSet(ProductScreenModel _value) =>
      productScreenData.value = _value;
  void setError(String _value) => error.value = _value;
  UserPreference userPreference = UserPreference();
  ProductScreenApi(String id) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    String token = sp.getString('token') ?? "";
    Map data = {"id": id};
    setRxRequestStatus(Status.LOADING);
    _api.ProductScreenApi(data, token).then((value) {
      setRxRequestStatus(Status.COMPLETED);
      ProductScreenDataSet(value);
      if (productScreenData.value.status == true) {
        homeScreenController.HomeScreenApi();
      } else {
        Utils.toastMessage(productScreenData.value.message.toString());
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
