import 'package:peschef_delivery/controller/cancelOrderController.dart';
import 'package:peschef_delivery/controller/declineOrderController.dart';
import 'package:peschef_delivery/controller/homeScreenController.dart';
import 'package:peschef_delivery/controller/orderAcceptController.dart';
import 'package:peschef_delivery/data/response/status.dart';
import 'package:peschef_delivery/res/colors/app_color.dart';
import 'package:peschef_delivery/res/components/general_exception.dart';
import 'package:peschef_delivery/res/components/internet_exceptions_widget.dart';
import 'package:peschef_delivery/view/notificationScreen.dart';
import 'package:peschef_delivery/view/productPage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

// var myClick = 0;

final HomeScreenController homeScreenController =
    Get.put(HomeScreenController());
final OrderAcceptController orderAcceptController =
    Get.put(OrderAcceptController());

final CancelOrderController cancelOrderController =
    Get.put(CancelOrderController());

final DeclineOrderController declineOrderController =
    Get.put(DeclineOrderController());

class _HomeScreenState extends State<HomeScreen> {
  bool selected = true;
  @override
  void initState() {
    // TODO: implement initState
    homeScreenController.HomeScreenApi();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: Color.fromRGBO(242, 242, 242, 1),
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(Get.height * 0.26),
              child: Container(
                color: Colors.white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        SizedBox(
                          height: Get.height * 0.05,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                SizedBox(
                                  width: Get.width * 0.05,
                                ),
                                Container(
                                    height: Get.height * 0.04,
                                    child:
                                        Image.asset('assets/images/Logo.png')),
                              ],
                            ),
                            // SizedBox(width: Get.width*0.37,),

                            Row(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Get.to(() => NotificationScreen());
                                  },
                                  child: Container(
                                      height: Get.height * 0.03,
                                      child: Image.asset(
                                          'assets/images/bell_icon.png')),
                                ),
                                SizedBox(
                                  width: Get.width * 0.05,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                    ListView(
                      shrinkWrap: true,
                      children: [
                        Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  color: Color.fromRGBO(255, 255, 255, 1),
                                  borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(20),
                                      bottomRight: Radius.circular(20))),
                              child: Column(
                                children: [
                                  // SizedBox(height: Get.height*0.1,),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      // SizedBox(width: Get.width*0.04,),
                                      Container(
                                        // width: Get.width * 0.9,
                                        // height: Get.height * 0.058,

                                        child: Row(
                                          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            // SizedBox(width: Get.width*0.0,),
                                            GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  selected = true;
                                                });
                                              },
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    children: [
                                                      SizedBox(
                                                          width:
                                                              Get.width * 0.04),
                                                      Container(
                                                          height:
                                                              Get.height * 0.04,
                                                          child: Text(
                                                            'Upcoming',
                                                            style: TextStyle(
                                                                fontSize: 18,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                                fontFamily:
                                                                    'RammettoOne',
                                                                color: (selected)
                                                                    ? AppColor
                                                                        .primaryColor
                                                                    : AppColor
                                                                        .secondaryColor),
                                                          )),
                                                    ],
                                                  ),
                                                  (selected)
                                                      ? Container(
                                                          width:
                                                              Get.width * 0.36,
                                                          height: Get.height *
                                                              0.005,
                                                          color: AppColor
                                                              .primaryColor,
                                                        )
                                                      : Container(
                                                          height: Get.height *
                                                              0.005)
                                                ],
                                              ),
                                            ),

                                            SizedBox(
                                              width: Get.width * 0.2,
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  selected = false;
                                                });
                                              },
                                              child: Column(
                                                // crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Container(
                                                      height: Get.height * 0.04,
                                                      child: Text(
                                                        'Ongoing',
                                                        style: TextStyle(
                                                            fontSize: 18,
                                                            fontFamily:
                                                                'RammettoOne',
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            color: (!selected)
                                                                ? AppColor
                                                                    .primaryColor
                                                                : AppColor
                                                                    .secondaryColor),
                                                      )),
                                                  (!selected)
                                                      ? Container(
                                                          width:
                                                              Get.width * 0.3,
                                                          height: Get.height *
                                                              0.005,
                                                          color: AppColor
                                                              .primaryColor,
                                                        )
                                                      : Container(
                                                          height: Get.height *
                                                              0.005)
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            body: Obx(() {
              switch (homeScreenController.rxRequestStatus.value) {
                case Status.LOADING:
                  return const Center(
                      child: CircularProgressIndicator(
                    color: AppColor.primaryColor,
                  ));
                case Status.ERROR:
                  if (homeScreenController.error.value == 'No internet') {
                    return InterNetExceptionWidget(
                      onPress: () {
                        homeScreenController.refreshApi();
                      },
                    );
                  } else {
                    return GeneralExceptionWidget(onPress: () {
                      homeScreenController.refreshApi();
                    });
                  }
                case Status.COMPLETED:
                  return RefreshIndicator(
                    color: AppColor.primaryColor,
                    onRefresh: () async {
                      homeScreenController.refreshApi();
                    },
                    child: SingleChildScrollView(
                      physics: AlwaysScrollableScrollPhysics(),
                      child: Column(
                        children: [
                          SizedBox(
                            height: Get.height * 0.04,
                          ),
                          (selected)
                              ? Container(
                                  child:
                                      (homeScreenController.homeScreenData.value
                                                  .data!.upcomming!.length ==
                                              0)
                                          ? Column(
                                              children: [
                                                Container(
                                                    height: Get.height * 0.5,
                                                    child: Center(
                                                        child: Text(
                                                      "Upcomming Orders are empty",
                                                      style: TextStyle(
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                      ),
                                                    )))
                                              ],
                                            )
                                          : Column(
                                              children: [
                                                Container(
                                                  child: ListView.builder(
                                                      scrollDirection:
                                                          Axis.vertical,
                                                      physics:
                                                          NeverScrollableScrollPhysics(),
                                                      shrinkWrap: true,
                                                      // controller: scrollController,
                                                      itemCount:
                                                          homeScreenController
                                                              .homeScreenData
                                                              .value
                                                              .data!
                                                              .upcomming!
                                                              .length,
                                                      itemBuilder:
                                                          (context, i) =>
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .only(
                                                                        left:
                                                                            20.0,
                                                                        right:
                                                                            20,
                                                                        bottom:
                                                                            15),
                                                                child:
                                                                    Container(
                                                                        height: Get.height *
                                                                            0.3,
                                                                        width: Get.width *
                                                                            0.9,
                                                                        decoration: BoxDecoration(
                                                                            color: Colors
                                                                                .white,
                                                                            borderRadius: BorderRadius.all(Radius.circular(
                                                                                20))),
                                                                        child:
                                                                            Padding(
                                                                          padding:
                                                                              EdgeInsets.only(left: 20.0),
                                                                          child:
                                                                              Column(
                                                                            children: [
                                                                              SizedBox(height: Get.height * 0.02),
                                                                              Row(
                                                                                children: [
                                                                                  Text(
                                                                                    homeScreenController.homeScreenData.value.data!.store!.name.toString(),
                                                                                    style: TextStyle(color: Color.fromRGBO(48, 48, 48, 1), fontSize: 18, fontWeight: FontWeight.w600, fontFamily: "Poppins"),
                                                                                  )
                                                                                ],
                                                                              ),
                                                                              SizedBox(height: Get.height * 0.005),
                                                                              Row(
                                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                                children: [
                                                                                  Text(
                                                                                    "Required to be picked: ${(homeScreenController.homeScreenData.value.data!.upcomming![i].timing == "as_soon") ? " ASAP" : homeScreenController.homeScreenData.value.data!.upcomming![i].timing.toString()}",
                                                                                    style: TextStyle(color: Color.fromRGBO(48, 48, 48, 1), fontSize: 14, fontWeight: FontWeight.w500, fontFamily: "Poppins"),
                                                                                  )
                                                                                ],
                                                                              ),
                                                                              SizedBox(height: Get.height * 0.01),
                                                                              Row(
                                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                                children: [
                                                                                  Column(
                                                                                    children: [
                                                                                      Container(
                                                                                          height: Get.width * 0.25,
                                                                                          width: Get.width * 0.25,
                                                                                          child: ClipRRect(
                                                                                            borderRadius: BorderRadius.all(Radius.circular(10)),
                                                                                            child: Image.network(
                                                                                              homeScreenController.homeScreenData.value.data!.upcomming![i].cartId![0].product!.image.toString(),
                                                                                              fit: BoxFit.cover,
                                                                                            ),
                                                                                          )),
                                                                                    ],
                                                                                  ),
                                                                                  Padding(
                                                                                    padding: EdgeInsets.only(left: 8.0),
                                                                                    child: Column(
                                                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                                                      children: [
                                                                                        Row(
                                                                                          children: [
                                                                                            Text(
                                                                                              "${homeScreenController.homeScreenData.value.data!.upcomming![i].cartId![0].product!.title.toString()}(${homeScreenController.homeScreenData.value.data!.upcomming![i].cartId!.length.toString()} Pcs)",
                                                                                              style: TextStyle(color: Color.fromRGBO(48, 48, 48, 1), fontSize: 12, fontWeight: FontWeight.w600, fontFamily: "Poppins"),
                                                                                            )
                                                                                          ],
                                                                                        ),
                                                                                        // Row(
                                                                                        //   children: [
                                                                                        //     Text(
                                                                                        //       "#USP232D",
                                                                                        //       style: TextStyle(color: Color.fromRGBO(143, 149, 158, 1), fontSize: 14, fontWeight: FontWeight.w400, fontFamily: "Poppins"),
                                                                                        //     )
                                                                                        //   ],
                                                                                        // ),
                                                                                        Row(
                                                                                          children: [
                                                                                            Text(
                                                                                              "€${homeScreenController.homeScreenData.value.data!.upcomming![i].netAmount.toString()}",
                                                                                              style: TextStyle(color: Color.fromRGBO(225, 143, 71, 1), fontSize: 16, fontWeight: FontWeight.w700, fontFamily: "Poppins"),
                                                                                            )
                                                                                          ],
                                                                                        ),
                                                                                        Row(
                                                                                          children: [
                                                                                            Container(
                                                                                              width: Get.width * 0.04,
                                                                                              height: Get.width * 0.04,
                                                                                              child: Image.asset("assets/images/Location.png", fit: BoxFit.cover),
                                                                                            ),
                                                                                            SizedBox(
                                                                                              width: Get.width * 0.01,
                                                                                            ),
                                                                                            Container(
                                                                                              width: Get.width * 0.5,
                                                                                              child: Text(
                                                                                                homeScreenController.homeScreenData.value.data!.upcomming![i].shipingAddress!.address.toString(),
                                                                                                style: TextStyle(color: Color.fromRGBO(143, 149, 158, 1), fontSize: 12, fontWeight: FontWeight.w400, fontFamily: "Poppins"),
                                                                                              ),
                                                                                            )
                                                                                          ],
                                                                                        )
                                                                                      ],
                                                                                    ),
                                                                                  )
                                                                                ],
                                                                              ),
                                                                              SizedBox(
                                                                                height: Get.height * 0.015,
                                                                              ),
                                                                              Row(
                                                                                children: [
                                                                                  Obx(
                                                                                    () => GestureDetector(
                                                                                      onTap: () {
                                                                                        homeScreenController.homeScreenData.value.data!.acceptButton.value = i;
                                                                                        orderAcceptController.OrderAcceptApi(homeScreenController.homeScreenData.value.data!.upcomming![i].id.toString());
                                                                                      },
                                                                                      child: Container(
                                                                                        height: Get.height * 0.04,
                                                                                        width: Get.width * 0.25,
                                                                                        decoration: BoxDecoration(color: AppColor.primaryColor, borderRadius: BorderRadius.all(Radius.circular(60))),
                                                                                        child: Center(
                                                                                          child: (orderAcceptController.rxRequestStatus.value == Status.LOADING && homeScreenController.homeScreenData.value.data!.acceptButton.value == i)
                                                                                              ? Container(
                                                                                                  height: Get.width * 0.04,
                                                                                                  width: Get.width * 0.04,
                                                                                                  child: CircularProgressIndicator(
                                                                                                    color: Colors.white,
                                                                                                  ),
                                                                                                )
                                                                                              : Text(
                                                                                                  'Accept',
                                                                                                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400, fontFamily: 'RammettoOne', color: Colors.white),
                                                                                                ),
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                  SizedBox(
                                                                                    width: Get.width * 0.02,
                                                                                  ),
                                                                                  GestureDetector(
                                                                                    onTap: () {
                                                                                      showModalBottomSheet(
                                                                                          context: context,
                                                                                          backgroundColor: Colors.white,
                                                                                          shape: const RoundedRectangleBorder(
                                                                                            borderRadius: BorderRadius.vertical(
                                                                                              top: Radius.circular(50.0),
                                                                                            ),
                                                                                          ),
                                                                                          builder: (context) {
                                                                                            return SizedBox(
                                                                                              height: Get.height * 0.37,
                                                                                              child: Column(
                                                                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                                                                mainAxisSize: MainAxisSize.min,
                                                                                                children: <Widget>[
                                                                                                  SizedBox(
                                                                                                    height: Get.height * 0.06,
                                                                                                  ),
                                                                                                  Icon(
                                                                                                    Icons.delete_outlined,
                                                                                                    color: AppColor.primaryColor,
                                                                                                    size: 50,
                                                                                                  ),
                                                                                                  SizedBox(
                                                                                                    height: Get.height * 0.02,
                                                                                                  ),
                                                                                                  Text(
                                                                                                    "Decline Order",
                                                                                                    style: TextStyle(fontSize: 18, fontFamily: "RammettoOne"),
                                                                                                  ),
                                                                                                  SizedBox(
                                                                                                    height: Get.height * 0.01,
                                                                                                  ),
                                                                                                  Text(
                                                                                                    "Are you sure want to decline this order?",
                                                                                                    style: TextStyle(fontSize: 16, color: Color.fromRGBO(119, 119, 119, 1), fontFamily: "Poppins"),
                                                                                                  ),
                                                                                                  SizedBox(
                                                                                                    height: Get.height * 0.035,
                                                                                                  ),
                                                                                                  Row(
                                                                                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                                                                    children: [
                                                                                                      GestureDetector(
                                                                                                        onTap: () {
                                                                                                          Get.back();
                                                                                                        },
                                                                                                        child: Container(
                                                                                                          height: Get.height * 0.05,
                                                                                                          width: Get.width * 0.4,
                                                                                                          decoration: BoxDecoration(color: AppColor.secondaryColor, borderRadius: BorderRadius.all(Radius.circular(60))),
                                                                                                          child: Center(
                                                                                                            child: Text(
                                                                                                              'No',
                                                                                                              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, fontFamily: 'RammettoOne', color: Colors.white),
                                                                                                            ),
                                                                                                          ),
                                                                                                        ),
                                                                                                      ),
                                                                                                      GestureDetector(
                                                                                                        onTap: () {
                                                                                                          declineOrderController.DeclineOrderApi(homeScreenController.homeScreenData.value.data!.upcomming![i].id.toString());
                                                                                                        },
                                                                                                        child: Container(
                                                                                                          height: Get.height * 0.05,
                                                                                                          width: Get.width * 0.4,
                                                                                                          decoration: BoxDecoration(color: AppColor.primaryColor, borderRadius: BorderRadius.all(Radius.circular(60))),
                                                                                                          child: Obx(
                                                                                                            () => Center(
                                                                                                              child: (declineOrderController.rxRequestStatus == Status.LOADING)
                                                                                                                  ? CircularProgressIndicator(
                                                                                                                      color: Colors.white,
                                                                                                                    )
                                                                                                                  : Text(
                                                                                                                      'Yes, Decline',
                                                                                                                      style: TextStyle(fontSize: 13, fontWeight: FontWeight.w400, fontFamily: 'RammettoOne', color: Colors.white),
                                                                                                                    ),
                                                                                                            ),
                                                                                                          ),
                                                                                                        ),
                                                                                                      ),
                                                                                                    ],
                                                                                                  )
                                                                                                ],
                                                                                              ),
                                                                                            );
                                                                                          });
                                                                                    },
                                                                                    child: Container(
                                                                                      height: Get.height * 0.04,
                                                                                      width: Get.width * 0.25,
                                                                                      decoration: BoxDecoration(color: AppColor.secondaryColor, borderRadius: BorderRadius.all(Radius.circular(60))),
                                                                                      child: Center(
                                                                                        child: Text(
                                                                                          'Decline',
                                                                                          style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400, fontFamily: 'RammettoOne', color: Colors.white),
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                ],
                                                                              )
                                                                            ],
                                                                          ),
                                                                        )),
                                                              )),
                                                ),
                                              ],
                                            ))
                              : Container(),

                          (!selected)
                              ? Container(
                                  child:
                                      (homeScreenController.homeScreenData.value
                                                  .data!.current!.length ==
                                              0)
                                          ? Column(
                                              children: [
                                                Container(
                                                    height: Get.height * 0.5,
                                                    child: Center(
                                                        child: Text(
                                                      "Current order are empty",
                                                      style: TextStyle(
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                      ),
                                                    )))
                                              ],
                                            )
                                          : Column(children: [
                                              Container(
                                                child: ListView.builder(
                                                    scrollDirection:
                                                        Axis.vertical,
                                                    physics:
                                                        NeverScrollableScrollPhysics(),
                                                    shrinkWrap: true,
                                                    // controller: scrollController,
                                                    itemCount:
                                                        homeScreenController
                                                            .homeScreenData
                                                            .value
                                                            .data!
                                                            .current!
                                                            .length,
                                                    itemBuilder:
                                                        (context, i) => Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .only(
                                                                      left:
                                                                          20.0,
                                                                      right: 20,
                                                                      bottom:
                                                                          15),
                                                              child: Container(
                                                                  height:
                                                                      Get.height *
                                                                          0.3,
                                                                  width:
                                                                      Get.width *
                                                                          0.9,
                                                                  decoration: BoxDecoration(
                                                                      color: Colors
                                                                          .white,
                                                                      borderRadius:
                                                                          BorderRadius.all(Radius.circular(
                                                                              20))),
                                                                  child:
                                                                      Padding(
                                                                    padding: EdgeInsets
                                                                        .only(
                                                                            left:
                                                                                20.0),
                                                                    child:
                                                                        Column(
                                                                      children: [
                                                                        SizedBox(
                                                                            height:
                                                                                Get.height * 0.02),
                                                                        Row(
                                                                          children: [
                                                                            Text(
                                                                              homeScreenController.homeScreenData.value.data!.store!.name.toString(),
                                                                              style: TextStyle(color: Color.fromRGBO(48, 48, 48, 1), fontSize: 18, fontWeight: FontWeight.w600, fontFamily: "Poppins"),
                                                                            )
                                                                          ],
                                                                        ),
                                                                        SizedBox(
                                                                            height:
                                                                                Get.height * 0.005),
                                                                        Row(
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.start,
                                                                          children: [
                                                                            Text(
                                                                              "Required to be picked: ${(homeScreenController.homeScreenData.value.data!.current![i].timing == "as_soon") ? "ASAP" : homeScreenController.homeScreenData.value.data!.current![i].timing.toString()}",
                                                                              style: TextStyle(color: Color.fromRGBO(48, 48, 48, 1), fontSize: 14, fontWeight: FontWeight.w500, fontFamily: "Poppins"),
                                                                            )
                                                                          ],
                                                                        ),
                                                                        SizedBox(
                                                                            height:
                                                                                Get.height * 0.01),
                                                                        Row(
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.start,
                                                                          children: [
                                                                            Column(
                                                                              children: [
                                                                                Container(
                                                                                    height: Get.width * 0.25,
                                                                                    width: Get.width * 0.25,
                                                                                    child: ClipRRect(
                                                                                      borderRadius: BorderRadius.all(Radius.circular(10)),
                                                                                      child: Image.network(
                                                                                        homeScreenController.homeScreenData.value.data!.current![i].cartId![0].product!.image.toString(),
                                                                                        fit: BoxFit.cover,
                                                                                      ),
                                                                                    )),
                                                                              ],
                                                                            ),
                                                                            Padding(
                                                                              padding: EdgeInsets.only(left: 8.0),
                                                                              child: Column(
                                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                                children: [
                                                                                  Row(
                                                                                    children: [
                                                                                      Text(
                                                                                        "${homeScreenController.homeScreenData.value.data!.current![i].cartId![0].product!.title.toString()}(${homeScreenController.homeScreenData.value.data!.current![i].cartId!.length.toString()} Pcs)",
                                                                                        style: TextStyle(color: Color.fromRGBO(48, 48, 48, 1), fontSize: 12, fontWeight: FontWeight.w600, fontFamily: "Poppins"),
                                                                                      )
                                                                                    ],
                                                                                  ),
                                                                                  // Row(
                                                                                  //   children: [
                                                                                  //     Text(
                                                                                  //       "#USP232D",
                                                                                  //       style: TextStyle(color: Color.fromRGBO(143, 149, 158, 1), fontSize: 14, fontWeight: FontWeight.w400, fontFamily: "Poppins"),
                                                                                  //     )
                                                                                  //   ],
                                                                                  // ),
                                                                                  Row(
                                                                                    children: [
                                                                                      Text(
                                                                                        "€${homeScreenController.homeScreenData.value.data!.current![i].netAmount.toString()}",
                                                                                        style: TextStyle(color: Color.fromRGBO(225, 143, 71, 1), fontSize: 16, fontWeight: FontWeight.w700, fontFamily: "Poppins"),
                                                                                      )
                                                                                    ],
                                                                                  ),
                                                                                  Row(
                                                                                    children: [
                                                                                      Container(
                                                                                        width: Get.width * 0.04,
                                                                                        height: Get.width * 0.04,
                                                                                        child: Image.asset("assets/images/Location.png", fit: BoxFit.cover),
                                                                                      ),
                                                                                      SizedBox(
                                                                                        width: Get.width * 0.01,
                                                                                      ),
                                                                                      Container(
                                                                                        width: Get.width * 0.5,
                                                                                        child: Text(
                                                                                          homeScreenController.homeScreenData.value.data!.current![i].shipingAddress!.address.toString(),
                                                                                          style: TextStyle(color: Color.fromRGBO(143, 149, 158, 1), fontSize: 12, fontWeight: FontWeight.w400, fontFamily: "Poppins"),
                                                                                        ),
                                                                                      )
                                                                                    ],
                                                                                  )
                                                                                ],
                                                                              ),
                                                                            )
                                                                          ],
                                                                        ),
                                                                        SizedBox(
                                                                          height:
                                                                              Get.height * 0.015,
                                                                        ),
                                                                        Row(
                                                                          children: [
                                                                            GestureDetector(
                                                                              onTap: () {
                                                                                Get.to(() => ProductScreen(id: homeScreenController.homeScreenData.value.data!.current![i].id.toString()));
                                                                              },
                                                                              child: Container(
                                                                                height: Get.height * 0.04,
                                                                                width: Get.width * 0.25,
                                                                                decoration: BoxDecoration(color: AppColor.primaryColor, borderRadius: BorderRadius.all(Radius.circular(60))),
                                                                                child: Center(
                                                                                  child: Text(
                                                                                    'Details',
                                                                                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400, fontFamily: 'RammettoOne', color: Colors.white),
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            SizedBox(
                                                                              width: Get.width * 0.02,
                                                                            ),
                                                                            GestureDetector(
                                                                              onTap: () {
                                                                                showModalBottomSheet(
                                                                                    context: context,
                                                                                    backgroundColor: Colors.white,
                                                                                    shape: const RoundedRectangleBorder(
                                                                                      borderRadius: BorderRadius.vertical(
                                                                                        top: Radius.circular(50.0),
                                                                                      ),
                                                                                    ),
                                                                                    builder: (context) {
                                                                                      return SizedBox(
                                                                                        height: Get.height * 0.37,
                                                                                        child: Column(
                                                                                          crossAxisAlignment: CrossAxisAlignment.center,
                                                                                          mainAxisSize: MainAxisSize.min,
                                                                                          children: <Widget>[
                                                                                            SizedBox(
                                                                                              height: Get.height * 0.06,
                                                                                            ),
                                                                                            Icon(
                                                                                              Icons.delete_sharp,
                                                                                              color: AppColor.primaryColor,
                                                                                              size: 50,
                                                                                            ),
                                                                                            SizedBox(
                                                                                              height: Get.height * 0.02,
                                                                                            ),
                                                                                            Text(
                                                                                              "Cancel Order",
                                                                                              style: TextStyle(fontSize: 18, fontFamily: "RammettoOne"),
                                                                                            ),
                                                                                            SizedBox(
                                                                                              height: Get.height * 0.01,
                                                                                            ),
                                                                                            Text(
                                                                                              "Are you sure want to Cancel this order?",
                                                                                              style: TextStyle(fontSize: 16, color: Color.fromRGBO(119, 119, 119, 1), fontFamily: "Poppins"),
                                                                                            ),
                                                                                            SizedBox(
                                                                                              height: Get.height * 0.035,
                                                                                            ),
                                                                                            Row(
                                                                                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                                                              children: [
                                                                                                GestureDetector(
                                                                                                  onTap: () {
                                                                                                    Get.back();
                                                                                                  },
                                                                                                  child: Container(
                                                                                                    height: Get.height * 0.05,
                                                                                                    width: Get.width * 0.4,
                                                                                                    decoration: BoxDecoration(color: AppColor.secondaryColor, borderRadius: BorderRadius.all(Radius.circular(60))),
                                                                                                    child: Center(
                                                                                                      child: Text(
                                                                                                        'No',
                                                                                                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, fontFamily: 'RammettoOne', color: Colors.white),
                                                                                                      ),
                                                                                                    ),
                                                                                                  ),
                                                                                                ),
                                                                                                GestureDetector(
                                                                                                  onTap: () {
                                                                                                    cancelOrderController.CancelOrderApi(homeScreenController.homeScreenData.value.data!.current![i].id.toString());
                                                                                                  },
                                                                                                  child: Container(
                                                                                                    height: Get.height * 0.05,
                                                                                                    width: Get.width * 0.4,
                                                                                                    decoration: BoxDecoration(color: AppColor.primaryColor, borderRadius: BorderRadius.all(Radius.circular(60))),
                                                                                                    child: Obx(
                                                                                                      () => Center(
                                                                                                        child: (cancelOrderController.rxRequestStatus == Status.LOADING)
                                                                                                            ? CircularProgressIndicator(
                                                                                                                color: Colors.white,
                                                                                                              )
                                                                                                            : Text(
                                                                                                                'Yes, Cancel',
                                                                                                                style: TextStyle(fontSize: 13, fontWeight: FontWeight.w400, fontFamily: 'RammettoOne', color: Colors.white),
                                                                                                              ),
                                                                                                      ),
                                                                                                    ),
                                                                                                  ),
                                                                                                ),
                                                                                              ],
                                                                                            )
                                                                                          ],
                                                                                        ),
                                                                                      );
                                                                                    });
                                                                              },
                                                                              child: Container(
                                                                                height: Get.height * 0.04,
                                                                                width: Get.width * 0.25,
                                                                                decoration: BoxDecoration(color: AppColor.secondaryColor, borderRadius: BorderRadius.all(Radius.circular(60))),
                                                                                child: Center(
                                                                                  child: Text(
                                                                                    'Cancel',
                                                                                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400, fontFamily: 'RammettoOne', color: Colors.white),
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        )
                                                                      ],
                                                                    ),
                                                                  )),
                                                            )),
                                              ),
                                            ]))
                              : Container(),
                          //  SizedBox(height: Get.height*0.04,),
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
