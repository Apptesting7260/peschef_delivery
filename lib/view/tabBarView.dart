import 'package:peschef_delivery/res/colors/app_color.dart';
import 'package:peschef_delivery/view/homeScreen.dart';
import 'package:peschef_delivery/view/myProfileScreen.dart';
import 'package:peschef_delivery/view/ongoingOrders.dart';
import 'package:peschef_delivery/view/recentScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyTabView extends StatefulWidget {
  @override
  _MyTabViewState createState() => _MyTabViewState();
}

class _MyTabViewState extends State<MyTabView> {
  int _currentIndex = 0;

  final List<Widget> _tabs = [
    HomeScreen(),
    RecentScreen(),
    OngoingScreen(type: "fromTab"),
    MyProfileScreen(),
  ];
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: Color.fromRGBO(242, 242, 242, 1),
            // endDrawer: DrawerWidgets(),
            bottomSheet: Container(
              height: Get.height * 0.11,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _currentIndex = 0;
                      });
                    },
                    child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          (_currentIndex == 0)
                              ? Icon(
                                  Icons.home_rounded,
                                  color: AppColor.primaryColor,
                                  size: 35,
                                )
                              : Icon(
                                  Icons.home_rounded,
                                  color: Color.fromRGBO(203, 203, 203, 1),
                                  size: 35,
                                ),
                          Text(
                            'Home',
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w400,
                              fontFamily: 'RammettoOne',
                              color: (_currentIndex == 0)
                                  ? AppColor.primaryColor
                                  : Color.fromRGBO(203, 203, 203, 1),
                            ),
                          ),
                          SizedBox(
                            height: Get.height * 0.018,
                          ),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _currentIndex = 1;
                      });
                    },
                    child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          (_currentIndex == 1)
                              ? Icon(
                                  Icons.refresh_rounded,
                                  color: AppColor.primaryColor,
                                  size: 35,
                                )
                              : Icon(
                                  Icons.refresh_rounded,
                                  color: Color.fromRGBO(203, 203, 203, 1),
                                  size: 35,
                                ),
                          Text(
                            'Recent',
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w400,
                              fontFamily: 'RammettoOne',
                              color: (_currentIndex == 1)
                                  ? AppColor.primaryColor
                                  : Color.fromRGBO(203, 203, 203, 1),
                            ),
                          ),
                          SizedBox(
                            height: Get.height * 0.018,
                          ),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _currentIndex = 2;
                      });
                    },
                    child: Stack(
                      children: [
                        Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              (_currentIndex == 2)
                                  ? Icon(
                                      Icons.shopping_bag_sharp,
                                      color: AppColor.primaryColor,
                                      size: 35,
                                    )
                                  : Icon(
                                      Icons.shopping_bag_sharp,
                                      color: Color.fromRGBO(203, 203, 203, 1),
                                      size: 35,
                                    ),
                              Text(
                                'Orders',
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: 'RammettoOne',
                                  color: (_currentIndex == 2)
                                      ? AppColor.primaryColor
                                      : Color.fromRGBO(203, 203, 203, 1),
                                ),
                              ),
                              SizedBox(
                                height: Get.height * 0.018,
                              ),
                            ],
                          ),
                        ),
                        // Positioned(
                        //   top: 15,
                        //   right: 0,
                        //   child: Obx(() => (
                        //     myCartController
                        //                   .myCartData.value.cart ==
                        //               null ||
                        //           myCartController
                        //                   .myCartData.value.cart!.length ==
                        //               0)
                        //       ? Container()
                        //       : Container(
                        //           height: Get.width * 0.06,
                        //           width: Get.width * 0.06,
                        //           decoration: BoxDecoration(
                        //               shape: BoxShape.circle,
                        //               color: Colors.white),
                        //           child: Center(
                        //             child: Container(
                        //               height: Get.width * 0.05,
                        //               width: Get.width * 0.05,
                        //               decoration: BoxDecoration(
                        //                   color: (_currentIndex == 2)
                        //                       ? AppColor.primaryColor

                        //                       : Color.fromRGBO(
                        //                           203, 203, 203, 1),
                        //                   shape: BoxShape.circle),
                        //               child: Center(
                        //                 child: Text(
                        //                   myCartController
                        //                       .myCartData.value.cart!.length
                        //                       .toString(),
                        //                   style: TextStyle(
                        //                       color: Colors.white,
                        //                       fontWeight: FontWeight.bold,
                        //                       fontSize: 12),
                        //                 ),
                        //               ),
                        //             ),
                        //           ),
                        //         )),
                        // ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _currentIndex = 3;
                      });
                    },
                    child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          (_currentIndex == 3)
                              ? Icon(
                                  Icons.person,
                                  color: AppColor.primaryColor,
                                  size: 35,
                                )
                              : Icon(
                                  Icons.person,
                                  color: Color.fromRGBO(203, 203, 203, 1),
                                  size: 35,
                                ),
                          Text(
                            'Profile',
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w400,
                              fontFamily: 'RammettoOne',
                              color: (_currentIndex == 3)
                                  ? AppColor.primaryColor
                                  : Color.fromRGBO(203, 203, 203, 1),
                            ),
                          ),
                          SizedBox(
                            height: Get.height * 0.018,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            body: _tabs[_currentIndex]));
  }
}
