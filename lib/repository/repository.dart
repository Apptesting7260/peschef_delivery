import 'package:peschef_delivery/data/network/network_api_services.dart';
import 'package:peschef_delivery/models/cancelOrderModel.dart';
import 'package:peschef_delivery/models/declineOrderModel.dart';
import 'package:peschef_delivery/models/forgotePasswordModel.dart';
import 'package:peschef_delivery/models/homeScreenModel.dart';
import 'package:peschef_delivery/models/logOutModel.dart';
import 'package:peschef_delivery/models/loginModel.dart';
import 'package:peschef_delivery/models/myProfileModel.dart';
import 'package:peschef_delivery/models/orderAcceptModel.dart';
import 'package:peschef_delivery/models/orderPickedModel.dart';
import 'package:peschef_delivery/models/otpVerifyModel.dart';
import 'package:peschef_delivery/models/productScreenModel.dart';
import 'package:peschef_delivery/models/recentOrdersModel.dart';
import 'package:peschef_delivery/models/resetPasswordModel.dart';
import 'package:peschef_delivery/models/restroTrackModel.dart';
import 'package:peschef_delivery/res/app_url/app_url.dart';

class Repository {
  final _apiService = NetworkApiServices();

  Future<dynamic> LoginApi(var data, String token) async {
    dynamic response = await _apiService.postApi(data, AppUrl.loginUrl, token);
    return LoginModel.fromJson(response);
  }

  Future<dynamic> HomeScreenApi(token) async {
    dynamic response = await _apiService.getApi(AppUrl.homeScreenUrl, token);
    return HomeScreenModel.fromJson(response);
  }

  Future<dynamic> OrderAcceptApi(var data, String token) async {
    dynamic response =
        await _apiService.postApi(data, AppUrl.orderAcceptUrl, token);
    return OrderAcceptModel.fromJson(response);
  }

  Future<dynamic> LogOutApi(token) async {
    dynamic response = await _apiService.getApi(AppUrl.logOutUrl, token);
    return LogOutModel.fromJson(response);
  }

  Future<dynamic> MyProfileApi(token) async {
    dynamic response = await _apiService.getApi(AppUrl.myProfileUrl, token);
    return MyProfileModel.fromJson(response);
  }

  Future<dynamic> CancelOrderApi(var data, String token) async {
    dynamic response =
        await _apiService.postApi(data, AppUrl.cancelOrderUrl, token);
    return CancelOrderModel.fromJson(response);
  }

  Future<dynamic> RecentOrderApi(token) async {
    dynamic response = await _apiService.getApi(AppUrl.recentOrderUrl, token);
    return RecentOrderModel.fromJson(response);
  }

  Future<dynamic> DeclineOrderApi(var data, String token) async {
    dynamic response =
        await _apiService.postApi(data, AppUrl.declineOrderUrl, token);
    return DeclineOrderModel.fromJson(response);
  }

  Future<dynamic> ProductScreenApi(var data, String token) async {
    dynamic response =
        await _apiService.postApi(data, AppUrl.productScreenUrl, token);
    return ProductScreenModel.fromJson(response);
  }

  Future<dynamic> ResetPasswordApi(var data, String token) async {
    dynamic response =
        await _apiService.postApi(data, AppUrl.resetPasswordUrl, token);
    return ResetPasswordModel.fromJson(response);
  }

  Future<dynamic> OtpVerifyApi(var data, String token) async {
    dynamic response =
        await _apiService.postApi(data, AppUrl.otpVerifyUrl, token);
    return OtpVerifyModel.fromJson(response);
  }

  Future<dynamic> ForgotPasswordApi(var data, token) async {
    dynamic response =
        await _apiService.postApi(data, AppUrl.forgotePasswordUrl, token);
    return ForgotPasswordModel.fromJson(response);
  }

  Future<dynamic> RestroTrackApi(token) async {
    dynamic response = await _apiService.getApi(AppUrl.restroTrackUrl, token);
    return RestroTrackModel.fromJson(response);
  }

  Future<dynamic> OrderPickedApi(var data, token) async {
    dynamic response =
        await _apiService.postApi(data, AppUrl.orderPickedUrl, token);
    return OrderPickedModel.fromJson(response);
  }
}
