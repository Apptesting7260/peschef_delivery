import 'package:peschef_delivery/controller/editProfileController.dart';
import 'package:peschef_delivery/controller/myProfileController.dart';
import 'package:peschef_delivery/data/response/status.dart';
import 'package:peschef_delivery/res/colors/app_color.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

final _GlobalKey = GlobalKey<FormState>();
final EditProfileController editProfileController =
    Get.put(EditProfileController());

final MyProfileController myProfileController = Get.put(MyProfileController());

class _EditProfileScreenState extends State<EditProfileScreen> {
  @override
  void initState() {
    // TODO: implement initState
    editProfileController.fieldInit();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: Color.fromRGBO(242, 242, 242, 1),
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(Get.height * 0.1),
              child: Padding(
                padding: EdgeInsets.only(top: 20.0, bottom: 10),
                child: Row(
                  children: [
                    SizedBox(
                      width: Get.width * 0.05,
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: Container(
                          width: Get.width * 0.13,
                          height: Get.width * 0.13,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.all(
                                Radius.circular(17),
                              )),
                          child: Center(
                              child: Image.asset(
                            'assets/images/arrow_b.png',
                            height: Get.height * 0.025,
                          ))),
                    ),
                    SizedBox(
                      width: Get.width * 0.08,
                    ),
                    Container(
                        child: Text(
                      'Edit Profile',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'RammettoOne'),
                    )),
                  ],
                ),
              ),
            ),
            body: SingleChildScrollView(
              child: Column(children: [
                SizedBox(
                  height: Get.height * 0.02,
                ),
                Obx(
                  () => Stack(
                    children: [
                      Container(
                        child: (myProfileController
                                        .myProfileData.value.profile!.image ==
                                    null ||
                                myProfileController
                                        .myProfileData.value.profile!.image ==
                                    "")
                            ? (editProfileController.profileImageGetUrl.value
                                        .toString() ==
                                    "")
                                ? CircleAvatar(
                                    radius: Get.width * 0.104,
                                    backgroundColor: AppColor.primaryColor,
                                    child: Container(
                                      height: Get.width * 0.2,
                                      width: Get.width * 0.2,
                                      decoration: BoxDecoration(
                                          color: AppColor.primaryColor,
                                          borderRadius:
                                              BorderRadius.circular(60)),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(60),
                                        child: Image.asset(
                                          "assets/images/demoPic.png",
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  )
                                : CircleAvatar(
                                    radius: Get.width * 0.1,
                                    backgroundImage: Image.file(
                                      editProfileController.image.value,
                                      fit: BoxFit.cover,
                                    ).image,
                                  )
                            : CircleAvatar(
                                radius: Get.width * 0.104,
                                backgroundColor: AppColor.primaryColor,
                                child: (editProfileController
                                            .profileImageGetUrl.value
                                            .toString() ==
                                        "")
                                    ? Container(
                                        height: Get.width * 0.2,
                                        width: Get.width * 0.2,
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(60)),
                                        child: CachedNetworkImage(
                                          imageUrl: myProfileController
                                              .myProfileData
                                              .value
                                              .profile!
                                              .image
                                              .toString(),
                                          imageBuilder:
                                              (context, imageProvider) =>
                                                  Container(
                                            width: 90.0,
                                            height: 90.0,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              image: DecorationImage(
                                                  image: imageProvider,
                                                  fit: BoxFit.cover),
                                            ),
                                          ),
                                          placeholder: (context, url) => Center(
                                            child: CircularProgressIndicator(
                                              color: Colors.white,
                                            ),
                                          ),
                                          errorWidget: (context, url, error) =>
                                              Icon(Icons.error),
                                        ),
                                      )
                                    : CircleAvatar(
                                        radius: Get.width * 0.1,
                                        backgroundImage: Image.file(
                                          editProfileController.image.value,
                                          fit: BoxFit.cover,
                                        ).image,
                                      ),
                              ),
                      ),
                      Positioned(
                          bottom: 0,
                          right: 0,
                          child: GestureDetector(
                            onTap: () {
                              editProfileController.fieldUpdate();
                              ImageUploadshowAlertDialog();
                            },
                            child: Container(
                              height: Get.height * 0.05,
                              width: Get.width * 0.07,
                              decoration: BoxDecoration(
                                  color: AppColor.secondaryColor,
                                  shape: BoxShape.circle),
                              child: Center(
                                  child: Icon(
                                Icons.camera_enhance,
                                color: Colors.white,
                                size: 16,
                              )),
                            ),
                          ))
                    ],
                  ),
                ),
                Form(
                  key: _GlobalKey,
                  child: Column(
                    children: [
                      SizedBox(
                        height: Get.height * .03,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: Get.width * 0.06,
                          ),
                          Text(
                            'Full Name',
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                fontFamily: 'RammettoOne',
                                color: AppColor.secondaryColor),
                          )
                        ],
                      ),
                      SizedBox(
                        height: Get.height * 0.008,
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(top: 5, left: 20, right: 20),
                        child: TextFormField(
                          controller: editProfileController.nameController.value
                            ..text = editProfileController.name.toString(),
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(35)),
                                  borderSide:
                                      const BorderSide(color: Colors.white)),
                              fillColor: Colors.white,
                              filled: true,
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: Get.width * .045,
                                  vertical: Get.height * .016),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(35),
                                borderSide: BorderSide(color: Colors.white),
                              ),
                              errorBorder: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(35.0)),
                                borderSide: BorderSide(color: Colors.red),
                              ),
                              disabledBorder: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(35.0)),
                                borderSide: BorderSide(color: Colors.white),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(35.0)),
                                borderSide:
                                    BorderSide(color: AppColor.secondaryColor),
                              ),
                              hintText: 'Enter full name',
                              hintStyle: TextStyle(
                                  color: Color.fromRGBO(119, 119, 119, 1),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: 'Poppins')),
                          onFieldSubmitted: (value) {},
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your name';
                            }
                            return null;
                          },
                        ),
                      ),
                      SizedBox(
                        height: Get.height * .03,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: Get.width * 0.06,
                          ),
                          Text(
                            'Email address',
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                fontFamily: 'RammettoOne',
                                color: AppColor.secondaryColor),
                          )
                        ],
                      ),
                      SizedBox(
                        height: Get.height * 0.008,
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(top: 5, left: 20, right: 20),
                        child: TextFormField(
                          readOnly: true,
                          controller:
                              editProfileController.emailController.value
                                ..text = editProfileController.email.toString(),
                          style: Theme.of(context).textTheme.bodyMedium,
                          decoration: InputDecoration(
                              // suffixIcon: Padding(
                              //     padding:
                              //         EdgeInsets.only(right: 20.0, top: 14),
                              //     child:
                              //         //  (emailChangeVerifyController
                              //         //         .verify.value)
                              //         //     ?
                              //         GestureDetector(
                              //       onTap: () {},
                              //       child: Text(
                              //         "verified",
                              //         style: TextStyle(
                              //           fontSize: 14,
                              //           color: Colors.green,
                              //           fontWeight: FontWeight.bold,
                              //           fontFamily: 'RammettoOne',
                              //         ),
                              //       ),
                              //     )
                              // : GestureDetector(
                              //     onTap: () {
                              //       editProfileController.fieldUpdate();
                              //       emailChangeVerifyController
                              //           .EmailChangeVerifyApi(
                              //               editProfileController
                              //                   .emailController
                              //                   .value
                              //                   .text
                              //                   .toString());
                              //     },
                              //     child: (emailChangeVerifyController
                              //                 .rxRequestStatus ==
                              //             Status.LOADING)
                              //         ? CircularProgressIndicator(
                              //             color: Colors.red,
                              //           )
                              //         : Text(
                              //             "verify",
                              //             style: TextStyle(
                              //               fontSize: 14,
                              //               color: Color.fromRGBO(
                              //                   214, 51, 72, 1),
                              //               fontWeight: FontWeight.bold,
                              //               fontFamily: 'RammettoOne',
                              //             ),
                              //           ),
                              //   ),
                              // ),
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(35)),
                                  borderSide:
                                      const BorderSide(color: Colors.white)),
                              fillColor: Colors.white,
                              filled: true,
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: Get.width * .045,
                                  vertical: Get.height * .016),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(35),
                                borderSide: BorderSide(color: Colors.white),
                              ),
                              errorBorder: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(35.0)),
                                borderSide: BorderSide(color: Colors.red),
                              ),
                              disabledBorder: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(35.0)),
                                borderSide: BorderSide(color: Colors.white),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(35.0)),
                                borderSide:
                                    BorderSide(color: AppColor.secondaryColor),
                              ),
                              hintText: 'Enter email address',
                              hintStyle: TextStyle(
                                  color: Color.fromRGBO(119, 119, 119, 1),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: 'Poppins')),
                          onFieldSubmitted: (value) {},
                          validator: (value) {
                            const pattern =
                                r"(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'"
                                r'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-'
                                r'\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*'
                                r'[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:(2(5[0-5]|[0-4]'
                                r'[0-9])|1[0-9][0-9]|[1-9]?[0-9]))\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9]'
                                r'[0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\'
                                r'x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])';
                            final regex = RegExp(pattern);
                            if (value == null ||
                                value.isEmpty ||
                                !regex.hasMatch(value)) {
                              return 'Please enter a valid email';
                            }
                            return null;
                          },
                        ),
                      ),
                      SizedBox(
                        height: Get.height * .03,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: Get.width * 0.06,
                          ),
                          Text(
                            'Gender',
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                fontFamily: 'RammettoOne',
                                color: AppColor.secondaryColor),
                          )
                        ],
                      ),
                      SizedBox(
                        height: Get.height * 0.008,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // SizedBox(width: Get.width*0.08,),
                          Container(
                            // height: Get.height*0.06,
                            width: Get.width * 0.9,
                            // decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
                            child: DropdownButtonFormField2<String>(
                              validator: (value) {
                                if (value == null) {
                                  return 'Please select an item';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(35)),
                                    borderSide:
                                        const BorderSide(color: Colors.white)),
                                fillColor: Colors.white,
                                filled: true,
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: Get.width * .01,
                                    vertical: Get.height * .016),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(35),
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                                errorBorder: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(35.0)),
                                  borderSide: BorderSide(color: Colors.red),
                                ),
                                disabledBorder: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(35.0)),
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(35.0)),
                                  borderSide: BorderSide(
                                      color: AppColor.secondaryColor),
                                ),
                              ),
                              isExpanded: true,
                              hint: const Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      'Select Item',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: Color.fromRGBO(119, 119, 119, 1),
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                              items: editProfileController.gender
                                  .map(
                                      (String item) => DropdownMenuItem<String>(
                                            value: item,
                                            child: Text(
                                              item,
                                              style: const TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400,
                                                color: Color.fromRGBO(
                                                    119, 119, 119, 1),
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ))
                                  .toList(),
                              value: editProfileController.selectedgender.value,
                              onChanged: (String? value) {
                                editProfileController.selectedgender.value =
                                    value!;
                              },
                              buttonStyleData: ButtonStyleData(
                                padding:
                                    const EdgeInsets.only(left: 14, right: 14),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(14),
                                    color: Colors.white),
                                elevation: 0,
                              ),
                              iconStyleData: const IconStyleData(
                                icon: Icon(
                                  Icons.arrow_forward_ios_outlined,
                                ),
                                iconSize: 14,
                                iconEnabledColor:
                                    Color.fromRGBO(119, 119, 119, 1),
                                iconDisabledColor:
                                    Color.fromRGBO(119, 119, 119, 1),
                              ),
                              dropdownStyleData: DropdownStyleData(
                                maxHeight: Get.height * 0.4,
                                width: Get.width * 0.83,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16),
                                  color: Colors.white,
                                ),
                                offset: const Offset(0, -10),
                                scrollbarTheme: ScrollbarThemeData(
                                  radius: const Radius.circular(40),
                                  thickness:
                                      MaterialStateProperty.all<double>(6),
                                  thumbVisibility:
                                      MaterialStateProperty.all<bool>(true),
                                ),
                              ),
                              menuItemStyleData: const MenuItemStyleData(
                                height: 40,
                                padding: EdgeInsets.only(left: 14, right: 14),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: Get.height * 0.03,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: Get.width * 0.06,
                          ),
                          Text(
                            'Phone Number',
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                fontFamily: 'RammettoOne',
                                color: AppColor.secondaryColor),
                          )
                        ],
                      ),
                      SizedBox(
                        height: Get.height * 0.008,
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(top: 5, left: 20, right: 20),
                        child: TextFormField(
                          controller:
                              editProfileController.phoneController.value
                                ..text = editProfileController.phone.toString(),
                          style: Theme.of(context).textTheme.bodyMedium,
                          keyboardType: TextInputType.phone,
                          maxLength: 10,
                          decoration: InputDecoration(
                              counterText: '',
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(35)),
                                  borderSide:
                                      const BorderSide(color: Colors.white)),
                              fillColor: Colors.white,
                              filled: true,
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: Get.width * .045,
                                  vertical: Get.height * .016),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(35),
                                borderSide: BorderSide(color: Colors.white),
                              ),
                              errorBorder: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(35.0)),
                                borderSide: BorderSide(color: Colors.red),
                              ),
                              disabledBorder: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(35.0)),
                                borderSide: BorderSide(color: Colors.white),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(35.0)),
                                borderSide:
                                    BorderSide(color: AppColor.secondaryColor),
                              ),
                              prefixIcon: Container(
                                height: Get.height * 0.06,
                                width: Get.width * 0.26,
                                // color: Colors.amber,
                                child: CountryCodePicker(
                                  onChanged: (element) => editProfileController
                                      .pickedCountryCode
                                      .value = element.toString(),
                                  initialSelection: editProfileController
                                      .countryCode
                                      .toString(),
                                  showCountryOnly: false,
                                  showOnlyCountryWhenClosed: false,
                                  favorite: const [
                                    '+39',
                                    'it',
                                  ],
                                  showDropDownButton: true,
                                  showFlag: false,
                                  onInit: (element) => editProfileController
                                      .pickedCountryCode
                                      .value = element.toString(),
                                ),
                              ),
                              hintText: 'Enter phone number',
                              hintStyle: TextStyle(
                                  color: Color.fromRGBO(119, 119, 119, 1),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: 'Poppins')),
                          onFieldSubmitted: (value) {},
                          validator: (value) {
                            final RegExp phoneRegex = RegExp(
                                r'^\d{10}$'); // Change this pattern as needed.

                            if (!phoneRegex.hasMatch(value!)) {
                              return 'Please enter a valid 10-digit phone number.';
                            }

                            return null;
                          },
                        ),
                      ),
                      SizedBox(
                        height: Get.height * .05,
                      ),
                      Obx(
                        () => GestureDetector(
                          onTap: () {
                            editProfileController.fieldUpdate();
                            if (_GlobalKey.currentState!.validate()) {
                              editProfileController.EditProfile();
                            }
                          },
                          child: Container(
                            height: Get.height * 0.05,
                            width: Get.width * 0.4,
                            decoration: BoxDecoration(
                                color: AppColor.primaryColor,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(60))),
                            child: Center(
                              child: (editProfileController.rxRequestStatus ==
                                      Status.LOADING)
                                  ? CircularProgressIndicator(
                                      color: Colors.white,
                                    )
                                  : Text(
                                      'Save',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400,
                                          fontFamily: 'RammettoOne',
                                          color: Colors.white),
                                    ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: Get.height * 0.1,
                      ),
                    ],
                  ),
                ),
              ]),
            )));
  }

  Future<void> ImageUploadshowAlertDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(actions: [
          Container(
            height: Get.height * 0.25,
            child: Stack(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        MaterialButton(
                            color: AppColor.primaryColor,
                            child: const Text("Pick Image from Gallery",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold)),
                            onPressed: () {
                              editProfileController
                                  .pickImage(ImageSource.gallery);
                              Get.back();
                            }),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        MaterialButton(
                            color: AppColor.primaryColor,
                            child: const Text("Pick Image from Camera",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold)),
                            onPressed: () {
                              editProfileController
                                  .pickImage(ImageSource.camera);
                              Get.back();
                            }),
                      ],
                    ),
                  ],
                ),
                Positioned(
                    right: 0,
                    top: 20,
                    child: GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: Container(
                        height: 28,
                        width: 28,
                        decoration: BoxDecoration(
                            color: AppColor.primaryColor,
                            shape: BoxShape.circle),
                        child: Icon(
                          Icons.close,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ))
              ],
            ),
          ),
        ]);
      },
    );
  }
}
