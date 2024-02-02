import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:peschef_delivery/controller/recentOrderController.dart';
import 'package:peschef_delivery/data/response/status.dart';
import 'package:peschef_delivery/res/colors/app_color.dart';
import 'package:peschef_delivery/res/components/general_exception.dart';
import 'package:peschef_delivery/res/components/internet_exceptions_widget.dart';
import 'package:peschef_delivery/view/productPage.dart';

class RecentScreen extends StatefulWidget {
  const RecentScreen({super.key});

  @override
  State<RecentScreen> createState() => _RecentScreenState();
}

final RecentOrderController recentOrderController =
    Get.put(RecentOrderController());

class _RecentScreenState extends State<RecentScreen> {
  @override
  void initState() {
    // TODO: implement initState
    recentOrderController.RecentOrderApi();

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
                      'Recent Orders',
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
              switch (recentOrderController.rxRequestStatus.value) {
                case Status.LOADING:
                  return const Center(
                      child: CircularProgressIndicator(
                    color: AppColor.primaryColor,
                  ));
                case Status.ERROR:
                  if (recentOrderController.error.value == 'No internet') {
                    return InterNetExceptionWidget(
                      onPress: () {
                        recentOrderController.refreshApi();
                      },
                    );
                  } else {
                    return GeneralExceptionWidget(onPress: () {
                      recentOrderController.refreshApi();
                    });
                  }
                case Status.COMPLETED:
                  return RefreshIndicator(
                    color: AppColor.primaryColor,
                    onRefresh: () async {
                      recentOrderController.refreshApi();
                    },
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          SizedBox(
                            height: Get.height * 0.03,
                          ),
                          (recentOrderController.recentOrderData.value.data!
                                      .history!.length ==
                                  0)
                              ? Container(
                                  height: Get.height * 0.6,
                                  child: Center(
                                    child: Text(
                                      "Recent Orders are empty",
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                )
                              : Container(
                                  child: ListView.builder(
                                      scrollDirection: Axis.vertical,
                                      shrinkWrap: true,
                                      // controller: scrollController,
                                      physics: NeverScrollableScrollPhysics(),
                                      itemCount: recentOrderController
                                          .recentOrderData
                                          .value
                                          .data!
                                          .history!
                                          .length,
                                      itemBuilder: (context, i) => Padding(
                                            padding: const EdgeInsets.only(
                                                left: 20.0,
                                                right: 20,
                                                bottom: 15),
                                            child: Container(
                                                height: Get.height * 0.3,
                                                width: Get.width * 0.9,
                                                decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                20))),
                                                child: Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 20.0),
                                                  child: Column(
                                                    children: [
                                                      SizedBox(
                                                          height: Get.height *
                                                              0.02),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Text(
                                                            recentOrderController
                                                                .recentOrderData
                                                                .value
                                                                .data!
                                                                .store!
                                                                .name
                                                                .toString(),
                                                            style: TextStyle(
                                                                color: Color
                                                                    .fromRGBO(
                                                                        48,
                                                                        48,
                                                                        48,
                                                                        1),
                                                                fontSize: 18,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                fontFamily:
                                                                    "Poppins"),
                                                          ),
                                                          Row(
                                                            children: [
                                                              (recentOrderController
                                                                          .recentOrderData
                                                                          .value
                                                                          .data!
                                                                          .history![
                                                                              i]
                                                                          .history ==
                                                                      "cancel")
                                                                  ? Text(
                                                                      "Cancel",
                                                                      style: TextStyle(
                                                                          color: Color.fromRGBO(
                                                                              214,
                                                                              51,
                                                                              72,
                                                                              1),
                                                                          fontSize:
                                                                              12,
                                                                          fontWeight: FontWeight
                                                                              .w700,
                                                                          fontFamily:
                                                                              "Poppins"),
                                                                    )
                                                                  : Text(
                                                                      "Complete",
                                                                      style: TextStyle(
                                                                          color: Color.fromRGBO(
                                                                              46,
                                                                              90,
                                                                              172,
                                                                              1),
                                                                          fontSize:
                                                                              12,
                                                                          fontWeight: FontWeight
                                                                              .w700,
                                                                          fontFamily:
                                                                              "Poppins"),
                                                                    ),
                                                              SizedBox(
                                                                  width:
                                                                      Get.width *
                                                                          0.03),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                      SizedBox(
                                                          height: Get.height *
                                                              0.005),
                                                      Row(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            "Required to be picked: ${(recentOrderController.recentOrderData.value.data!.history![i].timing == "as_soon") ? " ASAP" : recentOrderController.recentOrderData.value.data!.history![i].timing}",
                                                            style: TextStyle(
                                                                color: Color
                                                                    .fromRGBO(
                                                                        48,
                                                                        48,
                                                                        48,
                                                                        1),
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                fontFamily:
                                                                    "Poppins"),
                                                          )
                                                        ],
                                                      ),
                                                      SizedBox(
                                                          height: Get.height *
                                                              0.01),
                                                      Row(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Column(
                                                            children: [
                                                              Container(
                                                                  height:
                                                                      Get.width *
                                                                          0.25,
                                                                  width:
                                                                      Get.width *
                                                                          0.25,
                                                                  child:
                                                                      ClipRRect(
                                                                    borderRadius:
                                                                        BorderRadius.all(
                                                                            Radius.circular(10)),
                                                                    child: Image
                                                                        .network(
                                                                      recentOrderController
                                                                          .recentOrderData
                                                                          .value
                                                                          .data!
                                                                          .history![
                                                                              i]
                                                                          .cartId![
                                                                              0]
                                                                          .product!
                                                                          .image
                                                                          .toString(),
                                                                      fit: BoxFit
                                                                          .cover,
                                                                    ),
                                                                  )),
                                                            ],
                                                          ),
                                                          Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    left: 8.0),
                                                            child: Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Row(
                                                                  children: [
                                                                    Text(
                                                                      "${recentOrderController.recentOrderData.value.data!.history![i].cartId![0].product!.title.toString()}(${recentOrderController.recentOrderData.value.data!.history![i].cartId![0].quantity.toString()} Pcs)",
                                                                      style: TextStyle(
                                                                          color: Color.fromRGBO(
                                                                              48,
                                                                              48,
                                                                              48,
                                                                              1),
                                                                          fontSize:
                                                                              12,
                                                                          fontWeight: FontWeight
                                                                              .w600,
                                                                          fontFamily:
                                                                              "Poppins"),
                                                                    )
                                                                  ],
                                                                ),
                                                                // Row(
                                                                //   children: [
                                                                //     Text(
                                                                //       "#USP232D",
                                                                //       style: TextStyle(
                                                                //           color: Color
                                                                //               .fromRGBO(
                                                                //                   143,
                                                                //                   149,
                                                                //                   158,
                                                                //                   1),
                                                                //           fontSize:
                                                                //               14,
                                                                //           fontWeight:
                                                                //               FontWeight
                                                                //                   .w400,
                                                                //           fontFamily:
                                                                //               "Poppins"),
                                                                //     )
                                                                //   ],
                                                                // ),
                                                                Row(
                                                                  children: [
                                                                    Text(
                                                                      "€${recentOrderController.recentOrderData.value.data!.history![i].netAmount.toString()}",
                                                                      style: TextStyle(
                                                                          color: Color.fromRGBO(
                                                                              225,
                                                                              143,
                                                                              71,
                                                                              1),
                                                                          fontSize:
                                                                              16,
                                                                          fontWeight: FontWeight
                                                                              .w700,
                                                                          fontFamily:
                                                                              "Poppins"),
                                                                    )
                                                                  ],
                                                                ),
                                                                Row(
                                                                  children: [
                                                                    Container(
                                                                      width: Get
                                                                              .width *
                                                                          0.04,
                                                                      height: Get
                                                                              .width *
                                                                          0.04,
                                                                      child: Image.asset(
                                                                          "assets/images/Location.png",
                                                                          fit: BoxFit
                                                                              .cover),
                                                                    ),
                                                                    SizedBox(
                                                                      width: Get
                                                                              .width *
                                                                          0.01,
                                                                    ),
                                                                    Container(
                                                                      width: Get
                                                                              .width *
                                                                          0.5,
                                                                      child:
                                                                          Text(
                                                                        recentOrderController
                                                                            .recentOrderData
                                                                            .value
                                                                            .data!
                                                                            .history![i]
                                                                            .shipingAddress!
                                                                            .address
                                                                            .toString(),
                                                                        style: TextStyle(
                                                                            color: Color.fromRGBO(
                                                                                143,
                                                                                149,
                                                                                158,
                                                                                1),
                                                                            fontSize:
                                                                                12,
                                                                            fontWeight:
                                                                                FontWeight.w400,
                                                                            fontFamily: "Poppins"),
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
                                                              Get.to(() => ProductScreen(
                                                                  id: recentOrderController
                                                                      .recentOrderData
                                                                      .value
                                                                      .data!
                                                                      .history![
                                                                          i]
                                                                      .id
                                                                      .toString()));
                                                            },
                                                            child: Container(
                                                              height:
                                                                  Get.height *
                                                                      0.04,
                                                              width: Get.width *
                                                                  0.25,
                                                              decoration: BoxDecoration(
                                                                  color: AppColor
                                                                      .primaryColor,
                                                                  borderRadius:
                                                                      BorderRadius.all(
                                                                          Radius.circular(
                                                                              60))),
                                                              child: Center(
                                                                child: Text(
                                                                  'Details',
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          12,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w400,
                                                                      fontFamily:
                                                                          'RammettoOne',
                                                                      color: Colors
                                                                          .white),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          // SizedBox(
                                                          //   width: Get.width * 0.02,
                                                          // ),
                                                          // GestureDetector(
                                                          //   onTap: () {},
                                                          //   child: Container(
                                                          //     height:
                                                          //         Get.height * 0.04,
                                                          //     width: Get.width * 0.25,
                                                          //     decoration: BoxDecoration(
                                                          //         color:
                                                          //             Color.fromRGBO(
                                                          //                 9,
                                                          //                 64,
                                                          //                 94,
                                                          //                 1),
                                                          //         borderRadius:
                                                          //             BorderRadius
                                                          //                 .all(Radius
                                                          //                     .circular(
                                                          //                         60))),
                                                          //     child: Center(
                                                          //       child: Text(
                                                          //         'Decline',
                                                          //         style: TextStyle(
                                                          //             fontSize: 12,
                                                          //             fontWeight:
                                                          //                 FontWeight
                                                          //                     .w400,
                                                          //             fontFamily:
                                                          //                 'RammettoOne',
                                                          //             color: Colors
                                                          //                 .white),
                                                          //       ),
                                                          //     ),
                                                          //   ),
                                                          // ),
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                )),
                                          )),
                                ),
                          SizedBox(
                            height: Get.height * 0.1,
                          )
                        ],
                      ),
                    ),
                  );
              }
            })));
  }
}
