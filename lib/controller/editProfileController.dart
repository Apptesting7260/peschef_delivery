import 'dart:io';

import 'package:peschef_delivery/controller/homeScreenController.dart';
import 'package:peschef_delivery/controller/myProfileController.dart';
import 'package:peschef_delivery/data/response/status.dart';
import 'package:peschef_delivery/models/editProfileModel.dart';
import 'package:peschef_delivery/res/app_url/app_url.dart';
import 'package:peschef_delivery/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

import 'package:shared_preferences/shared_preferences.dart';

class EditProfileController extends GetxController {
  final MyProfileController myProfileController =
      Get.put(MyProfileController());
  final HomeScreenController homeScreenController =
      Get.put(HomeScreenController());

  final rxRequestStatus = Status.COMPLETED.obs;

  final profileUpdate = EditProfileModel().obs;

  RxString error = ''.obs;

  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;

  void EditProfileSet(EditProfileModel value) => profileUpdate.value = value;

  void setError(String value) => error.value = value;

  final Rx<TextEditingController> nameController = TextEditingController().obs;
  final Rx<TextEditingController> emailController = TextEditingController().obs;
  final Rx<TextEditingController> phoneController = TextEditingController().obs;
  // final Rx<TextEditingController> addressController =
  // TextEditingController().obs;
  var pickedCountryCode = "+39".obs;

  var profileImageGetUrl = "".obs;

  Rx<File> image = File("assets/appLogo.png").obs;

  Future<void> pickImage(ImageSource source) async {
    final pickedImage = await ImagePicker().pickImage(source: source);

    if (pickedImage != null) {
      // Get the original image size
      File originalImage = File(pickedImage.path);
      int originalSize = await originalImage.length();

      // Compress the selected image
      var compressedImageData = await FlutterImageCompress.compressWithFile(
        pickedImage.path,
        quality: 85, // Adjust the quality as needed (0 to 100)
      );

      File compressedImage = File(pickedImage.path)
        ..writeAsBytesSync(compressedImageData!);

      int compressedSize = await compressedImage.length();

      print('Original image size: $originalSize bytes');
      print('Compressed image size: $compressedSize bytes');
      print('Path ---> ' + compressedImage.path);

      image.value = compressedImage;
      // imageUploadController.asyncFileUpload(_image!);
      profileImageGetUrl.value = image.value.path;
      print("path $image");
    }
  }

  var selectedgender = "Male".obs;
  var gender = [
    'Male',
    'Female',
  ].obs;
  var email = "".obs;
  var name = "".obs;
  var countryCode = "".obs;
  var phone = "".obs;
  // var address = "".obs;
  fieldUpdate() {
    print("update call");
    email.value = emailController.value.text;
    name.value = nameController.value.text;
    countryCode.value = pickedCountryCode.value;
    phone.value = phoneController.value.text;
    // address.value = addressController.value.text;
  }

  // addressUpdateFromCurrent() {
  //   Future.delayed(Duration(seconds: 3), () {
  //     // code to be executed after 2 seconds
  //     address.value = (myProfileController
  //                 .myProfileData.value.profile!.address ==
  //             null)
  //         // ? addressSetController.currentAddress.value
  //         ? ""
  //         : myProfileController.myProfileData.value.profile!.address.toString();
  //   });
  // }

  fieldInit() {
    // addressSetController.getCurrentPosition();
    print("init call");
    email.value = myProfileController.myProfileData.value.profile!.email ?? "";
    name.value = myProfileController.myProfileData.value.profile!.name ?? "";
    countryCode.value =
        myProfileController.myProfileData.value.profile!.countryCode ?? "";
    phone.value = myProfileController.myProfileData.value.profile!.mobile ?? "";
    // address.value = (myProfileController.myProfileData.value.profile!.address ==
    //         null)
    //     // ? addressSetController.currentAddress.value
    //     ? ""
    //     : myProfileController.myProfileData.value.profile!.address.toString();
    // addressUpdateFromCurrent();
  }

  EditProfile() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    String token = sp.getString('token') ?? "";
    setRxRequestStatus(Status.LOADING);
    //create multipart request for POST or PATCH method
    Map<String, String> headers = {"Authorization": "Bearer ${token}"};

    var request = http.MultipartRequest(
        "POST",
        Uri.parse(
          AppUrl.editProfileUrl,
        ));
    request.headers.addAll(headers);

    //add text fields
    request.fields["name"] = nameController.value.text.toString();
    request.fields["email"] = emailController.value.text.toString();
    request.fields["mobile"] = phoneController.value.text.toString();
    request.fields["gender"] = selectedgender.value.toString();
    request.fields["country_code"] = pickedCountryCode.toString();
    //create multipart using filepath, string or bytes
    if (profileImageGetUrl.value != "") {
      var pic = await http.MultipartFile.fromPath("image", image.value.path);
      //add multipart to request

      request.files.add(pic);
      print("hhhhhhhhhhhhhhhh${image.value.path}");
    }

    var response = await request.send();

    //Get the response from the server
    var responseData = await response.stream.toBytes();
    if (response.statusCode == 200) {
      setRxRequestStatus(Status.COMPLETED);
      myProfileController.MyProfileApi();
      homeScreenController.HomeScreenApi();
      profileImageGetUrl.value = "";
      Get.back();
    } else {
      Utils.toastMessage("Error");
      setRxRequestStatus(Status.ERROR);
    }
    var responseString = String.fromCharCodes(responseData);
    print(responseString);
  }
}
