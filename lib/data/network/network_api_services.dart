import 'dart:convert';
import 'dart:io';

import 'package:peschef_delivery/data/network/base_api_services.dart';
import 'package:flutter/foundation.dart';

import 'package:http/http.dart' as http;

import '../app_exceptions.dart';

class NetworkApiServices extends BaseApiServices {
  @override
  Future<dynamic> getApi(String url, String token) async {
    if (kDebugMode) {
      print(url);
    }

    dynamic responseJson;
    try {
      final response = await http.get(Uri.parse(url), headers: {
        "Authorization": "Bearer ${token}"
      }).timeout(const Duration(seconds: 50));

      responseJson = returnResponse(response);
    } on SocketException {
      throw InternetException('');
    } on RequestTimeOut {
      throw RequestTimeOut('');
    }
    print(responseJson);
    return responseJson;
  }

  // @override
  // Future<dynamic> getApi2(String url) async {
  //   // final prefs=await SharedPreferences.getInstance();
  //   if (kDebugMode) {
  //     print(url);
  //   }

  //   dynamic responseJson;
  //   try {
  //     final response = await http.get(
  //       Uri.parse(url),
  //       headers: {
  //         "Authorization":
  //             "Bearer 1309|U0BqDpCg8ZFVAiZYFSwIcgIn997Cxx6Rbkj2lHl4"
  //       },
  //     ).timeout(const Duration(seconds: 50));
  //     // print(prefs.getString('BarearToken'));
  //     responseJson = returnResponse(response);
  //     print('apiiiiiiiiiiiiiiiiiiii');
  //     // apiresponsehit=jsonDecode(response.body);
  //   } on SocketException {
  //     throw InternetException('');
  //   } on RequestTimeOut {
  //     throw RequestTimeOut('');
  //   }
  //   // print(responseJson);
  //   return responseJson;
  // }

  @override
  Future<dynamic> postApi(var data, String url, String token) async {
    if (kDebugMode) {
      print(url);
      print(data);
    }

    dynamic responseJson;
    try {
      print("tocken@calling : ${token.toString()}");
      print("url@calling : ${url.toString()}");
      final response = await http
          .post(Uri.parse(url),
              headers: {"Authorization": "Bearer ${token}"}, body: data)
          .timeout(const Duration(seconds: 50));
      responseJson = returnResponse(response);
      print("data: ${response}");
    } on SocketException {
      throw InternetException('');
    } on RequestTimeOut {
      throw RequestTimeOut('');
    }
    if (kDebugMode) {
      print("${responseJson}");
    }
    return responseJson;
  }

  dynamic returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;
      case 400:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;
      case 401:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;
      case 503:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;
      case 500:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;
      case 405:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;
      case 501:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;

      default:
        throw FetchDataException(
            'Error accoured while communicating with server ' +
                response.statusCode.toString());
      // default:
      //   dynamic responseJson = jsonDecode(response.body);
      //   return responseJson;
    }
  }
}
