import 'package:peschef_delivery/controller/logOutController.dart';
import 'package:peschef_delivery/controller/myProfileController.dart';
import 'package:peschef_delivery/controller/userPrefrenceController.dart';
import 'package:peschef_delivery/data/response/status.dart';
import 'package:peschef_delivery/res/colors/app_color.dart';
import 'package:peschef_delivery/res/components/general_exception.dart';
import 'package:peschef_delivery/res/components/internet_exceptions_widget.dart';
import 'package:peschef_delivery/res/routes/routes_name.dart';
import 'package:peschef_delivery/view/editProfileScreen.dart';
import 'package:peschef_delivery/view/ongoingOrders.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyProfileScreen extends StatefulWidget {
  const MyProfileScreen({super.key});

  @override
  State<MyProfileScreen> createState() => _MyProfileScreenState();
}

UserPreference userPreference = UserPreference();
final LogOutController logOutController = Get.put(LogOutController());
final MyProfileController myProfileController = Get.put(MyProfileController());

class _MyProfileScreenState extends State<MyProfileScreen> {
  @override
  void initState() {
    // TODO: implement initState
    myProfileController.MyProfileApi();
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
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: Get.width * 0.13,
                    ),
                    // SizedBox(
                    //   width: Get.width * 0.05,
                    // ),
                    // GestureDetector(
                    //   onTap: () {
                    //     Get.back();
                    //   },
                    //   child: Container(
                    //       width: Get.width * 0.13,
                    //       height: Get.width * 0.13,
                    //       decoration: BoxDecoration(
                    //           color: Colors.white,
                    //           borderRadius: BorderRadius.all(
                    //             Radius.circular(17),
                    //           )),
                    //       child: Center(
                    //           child: Image.asset(
                    //         'assets/images/arrow_b.png',
                    //         height: Get.height * 0.025,
                    //       ))),
                    // ),
                    // SizedBox(
                    //   width: Get.width * 0.08,
                    // ),
                    Container(
                        child: Text(
                      'My Profile',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'RammettoOne'),
                    )),
                  ],
                ),
              ),
            ),
            body: Obx(() {
              switch (myProfileController.rxRequestStatus.value) {
                case Status.LOADING:
                  return const Center(
                      child: CircularProgressIndicator(
                    color: AppColor.primaryColor,
                  ));
                case Status.ERROR:
                  if (myProfileController.error.value == 'No internet') {
                    return InterNetExceptionWidget(
                      onPress: () {
                        myProfileController.refreshApi();
                      },
                    );
                  } else {
                    return GeneralExceptionWidget(onPress: () {
                      myProfileController.refreshApi();
                    });
                  }
                case Status.COMPLETED:
                  return RefreshIndicator(
                    color: AppColor.primaryColor,
                    onRefresh: () async {
                      myProfileController.refreshApi();
                    },
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          SizedBox(
                            height: Get.height * 0.015,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Stack(
                                children: [
                                  Container(
                                    // height: Get.height * 0.45,
                                    width: Get.width * 0.9,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(15),
                                          bottomLeft: Radius.circular(15),
                                          bottomRight: Radius.circular(15),
                                          topRight: Radius.circular(15)),
                                    ),
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          height: Get.height * 0.05,
                                        ),
                                        Row(
                                          children: [
                                            SizedBox(
                                              width: Get.width * 0.06,
                                            ),
                                            Container(
                                              child: (myProfileController
                                                              .myProfileData
                                                              .value
                                                              .profile!
                                                              .image ==
                                                          null ||
                                                      myProfileController
                                                              .myProfileData
                                                              .value
                                                              .profile!
                                                              .image ==
                                                          "")
                                                  ? CircleAvatar(
                                                      radius: Get.width * 0.104,
                                                      backgroundColor:
                                                          AppColor.primaryColor,
                                                      child: Container(
                                                        height: Get.width * 0.2,
                                                        width: Get.width * 0.2,
                                                        decoration: BoxDecoration(
                                                            color: AppColor
                                                                .primaryColor,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        60)),
                                                        child: ClipRRect(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(60),
                                                          child: Image.asset(
                                                            "assets/images/demoPic.png",
                                                            fit: BoxFit.cover,
                                                          ),
                                                        ),
                                                      ),
                                                    )
                                                  : CircleAvatar(
                                                      radius: Get.width * 0.104,
                                                      backgroundColor:
                                                          AppColor.primaryColor,
                                                      child: Container(
                                                        height: Get.width * 0.2,
                                                        width: Get.width * 0.2,
                                                        decoration: BoxDecoration(
                                                            color: Colors.white,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        60)),
                                                        child:
                                                            CachedNetworkImage(
                                                          imageUrl:
                                                              myProfileController
                                                                  .myProfileData
                                                                  .value
                                                                  .profile!
                                                                  .image
                                                                  .toString(),
                                                          imageBuilder: (context,
                                                                  imageProvider) =>
                                                              Container(
                                                            width: 90.0,
                                                            height: 90.0,
                                                            decoration:
                                                                BoxDecoration(
                                                              shape: BoxShape
                                                                  .circle,
                                                              image: DecorationImage(
                                                                  image:
                                                                      imageProvider,
                                                                  fit: BoxFit
                                                                      .cover),
                                                            ),
                                                          ),
                                                          placeholder:
                                                              (context, url) =>
                                                                  Center(
                                                            child:
                                                                CircularProgressIndicator(
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                          ),
                                                          errorWidget: (context,
                                                                  url, error) =>
                                                              Icon(Icons.error),
                                                        ),
                                                      ),
                                                    ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: Get.height * 0.018,
                                        ),
                                        Row(
                                          children: [
                                            SizedBox(
                                              width: Get.width * 0.06,
                                            ),
                                            Text(
                                              // "Name",
                                              myProfileController.myProfileData
                                                  .value.profile!.name
                                                  .toString(),
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w700,
                                                  fontFamily: 'Poppins'),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: Get.height * 0.0015,
                                        ),
                                        Row(
                                          children: [
                                            SizedBox(
                                              width: Get.width * 0.06,
                                            ),
                                            Text(
                                              // "exampel@gmail.com",
                                              myProfileController.myProfileData
                                                  .value.profile!.email
                                                  .toString(),
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w400,
                                                  fontFamily: 'Poppins',
                                                  color: Color.fromRGBO(
                                                      119, 119, 119, 1)),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: Get.height * 0.025,
                                        ),
                                        Row(
                                          children: [
                                            SizedBox(
                                              width: Get.width * 0.05,
                                            ),
                                            Container(
                                                height: Get.height * 0.04,
                                                width: Get.width * 0.09,
                                                decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color:
                                                        AppColor.primaryColor),
                                                child: Icon(
                                                  Icons.call,
                                                  size: 20,
                                                  color: Colors.white,
                                                )),
                                            SizedBox(
                                              width: Get.width * 0.03,
                                            ),
                                            Row(
                                              children: [
                                                Container(
                                                  child: Text(
                                                    // "+91",
                                                    "${myProfileController.myProfileData.value.profile!.countryCode.toString()} ",
                                                    style: TextStyle(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontFamily: 'Poppins',
                                                        color: Color.fromRGBO(
                                                            119, 119, 119, 1)),
                                                  ),
                                                ),
                                                Container(
                                                  child: Text(
                                                    // "9876543212",
                                                    myProfileController
                                                        .myProfileData
                                                        .value
                                                        .profile!
                                                        .mobile
                                                        .toString(),
                                                    style: TextStyle(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontFamily: 'Poppins',
                                                        color: Color.fromRGBO(
                                                            119, 119, 119, 1)),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: Get.height * 0.015,
                                        ),
                                        // (myProfileController.myProfileData.value
                                        //             .profile!.address ==
                                        //         null)
                                        //     ? Container()
                                        //     : Row(
                                        //         children: [
                                        //           SizedBox(
                                        //             width: Get.width * 0.05,
                                        //           ),
                                        //           Container(
                                        //               height: Get.height * 0.04,
                                        //               width: Get.width * 0.09,
                                        //               decoration: BoxDecoration(
                                        //                   shape:
                                        //                       BoxShape.circle,
                                        //                   color: Color.fromRGBO(
                                        //                       214, 51, 72, 1)),
                                        //               child: Icon(
                                        //                 Icons.location_pin,
                                        //                 size: 20,
                                        //                 color: Colors.white,
                                        //               )),
                                        //           SizedBox(
                                        //             width: Get.width * 0.03,
                                        //           ),
                                        //           Container(
                                        //             child: Flexible(
                                        //               child: Text(
                                        //                 // "hefuedfih fged hgufg ",
                                        //                 myProfileController
                                        //                     .myProfileData
                                        //                     .value
                                        //                     .profile!
                                        //                     .address
                                        //                     .toString(),
                                        //                 style: TextStyle(
                                        //                     fontSize: 14,
                                        //                     fontWeight:
                                        //                         FontWeight.w400,
                                        //                     fontFamily:
                                        //                         'Poppins',
                                        //                     color:
                                        //                         Color.fromRGBO(
                                        //                             119,
                                        //                             119,
                                        //                             119,
                                        //                             1)),
                                        //               ),
                                        //             ),
                                        //           ),
                                        //         ],
                                        //       ),
                                        // SizedBox(
                                        //   height: Get.height * 0.03,
                                        // ),
                                      ],
                                    ),
                                  ),
                                  // Positioned(
                                  //   right: 0,
                                  //   child: GestureDetector(
                                  //     onTap: () {
                                  //       // Get.to(() => EditProfileScreen());
                                  //     },
                                  //     child: Container(
                                  //       decoration: BoxDecoration(
                                  //         color: AppColor.primaryColor,
                                  //         borderRadius: BorderRadius.only(
                                  //             bottomLeft: Radius.circular(15),
                                  //             topRight: Radius.circular(15)),
                                  //       ),
                                  //       height: Get.height * 0.04,
                                  //       width: Get.width * 0.09,
                                  //       child: Icon(
                                  //         Icons.edit_note_rounded,
                                  //         color: Colors.white,
                                  //       ),
                                  //     ),
                                  //   ),
                                  // )
                                ],
                              ),
                            ],
                          ),
                          SizedBox(
                            height: Get.height * 0.02,
                          ),
                          Container(
                            height: Get.height * 0.09,
                            width: Get.width * 0.9,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20))),
                            child: Center(
                              child: ListTile(
                                leading: Icon(
                                  Icons.person,
                                  size: 30,
                                  color: AppColor.primaryColor,
                                ),
                                title: Text(
                                  'Account',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                    fontFamily: 'Poppins',
                                  ),
                                ),
                                trailing: Image.asset(
                                  'assets/images/arrow.png',
                                  height: Get.height * 0.02,
                                ),
                                onTap: () {
                                  Get.to(() => EditProfileScreen());
                                },
                              ),
                            ),
                          ),
                          SizedBox(
                            height: Get.height * 0.02,
                          ),
                          Container(
                            height: Get.height * 0.09,
                            width: Get.width * 0.9,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20))),
                            child: Center(
                              child: ListTile(
                                leading: Icon(
                                  Icons.list_alt_rounded,
                                  size: 30,
                                  color: AppColor.primaryColor,
                                ),
                                title: Text(
                                  'Orders',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                    fontFamily: 'Poppins',
                                  ),
                                ),
                                trailing: Image.asset(
                                  'assets/images/arrow.png',
                                  height: Get.height * 0.02,
                                ),
                                onTap: () {
                                  // Get.to(MyOrderScreen());
                                  Get.to(() => OngoingScreen());
                                },
                              ),
                            ),
                          ),
                          SizedBox(
                            height: Get.height * 0.02,
                          ),
                          // Container(
                          //   height: Get.height * 0.09,
                          //   width: Get.width * 0.9,
                          //   decoration: BoxDecoration(
                          //       color: Colors.white,
                          //       borderRadius:
                          //           BorderRadius.all(Radius.circular(20))),
                          //   child: Center(
                          //     child: ListTile(
                          //       leading: Icon(
                          //         Icons.language_rounded,
                          //         size: 30,
                          //         color: AppColor.primaryColor,
                          //       ),
                          //       title: Text(
                          //         'Language',
                          //         style: TextStyle(
                          //           fontSize: 18,
                          //           fontWeight: FontWeight.w700,
                          //           fontFamily: 'Poppins',
                          //         ),
                          //       ),
                          //       trailing: Image.asset(
                          //         'assets/images/arrow.png',
                          //         height: Get.height * 0.02,
                          //       ),
                          //       onTap: () {
                          //         Get.to(() => ChooseLanguageScreen());
                          //       },
                          //     ),
                          //   ),
                          // ),
                          // SizedBox(
                          //   height: Get.height * 0.02,
                          // ),
                          Container(
                            height: Get.height * 0.09,
                            width: Get.width * 0.9,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20))),
                            child: Center(
                              child: ListTile(
                                leading: Icon(
                                  Icons.help,
                                  size: 30,
                                  color: AppColor.primaryColor,
                                ),
                                title: Text(
                                  'Help & support',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                    fontFamily: 'Poppins',
                                  ),
                                ),
                                trailing: Image.asset(
                                  'assets/images/arrow.png',
                                  height: Get.height * 0.02,
                                ),
                                onTap: () {
                                  // Get.to(HelpAndSupportScreen());
                                },
                              ),
                            ),
                          ),
                          SizedBox(
                            height: Get.height * 0.02,
                          ),
                          Container(
                            height: Get.height * 0.09,
                            width: Get.width * 0.9,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20))),
                            child: Center(
                              child: ListTile(
                                leading: Icon(
                                  Icons.notifications,
                                  size: 30,
                                  color: AppColor.primaryColor,
                                ),
                                title: Text(
                                  'Notification',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                    fontFamily: 'Poppins',
                                  ),
                                ),
                                trailing: Image.asset(
                                  'assets/images/arrow.png',
                                  height: Get.height * 0.02,
                                ),
                                onTap: () {
                                  // Get.to(SettingScreen());
                                },
                              ),
                            ),
                          ),
                          SizedBox(
                            height: Get.height * 0.06,
                          ),
                          Obx(
                            () => GestureDetector(
                              onTap: () {
                                logOutController.LogOutApi();
                              },
                              child: Container(
                                height: Get.height * 0.06,
                                width: Get.width * 0.5,
                                decoration: BoxDecoration(
                                    color: AppColor.primaryColor,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(60))),
                                child: Center(
                                  child: (logOutController.rxRequestStatus ==
                                          Status.LOADING)
                                      ? CircularProgressIndicator(
                                          color: Colors.white,
                                        )
                                      : Text(
                                          'LogOut',
                                          style: TextStyle(
                                              fontSize: 14,
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
                          SizedBox(
                            height: Get.height * 0.11,
                          )
                        ],
                      ),
                    ),
                  );
              }
            })));
  }
}
