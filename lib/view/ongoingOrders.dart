import 'package:peschef_delivery/controller/cancelOrderController.dart';
import 'package:peschef_delivery/controller/homeScreenController.dart';
import 'package:peschef_delivery/data/response/status.dart';
import 'package:peschef_delivery/res/colors/app_color.dart';
import 'package:peschef_delivery/res/components/general_exception.dart';
import 'package:peschef_delivery/res/components/internet_exceptions_widget.dart';
import 'package:peschef_delivery/view/productPage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OngoingScreen extends StatefulWidget {
  final String? type;
  const OngoingScreen({this.type, super.key});

  @override
  State<OngoingScreen> createState() => _OngoingScreenState();
}

// List<bool> items = [true, false, true, false, false, true];
final HomeScreenController homeScreenController =
    Get.put(HomeScreenController());

final CancelOrderController cancelOrderController =
    Get.put(CancelOrderController());

class _OngoingScreenState extends State<OngoingScreen> {
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
              preferredSize: Size.fromHeight(Get.height * 0.1),
              child: Padding(
                padding: EdgeInsets.only(top: 20.0, bottom: 10),
                child: Row(
                  children: [
                    SizedBox(
                      width: Get.width * 0.05,
                    ),
                    (widget.type == "fromTab")
                        ? Container(
                            width: Get.width * 0.07,
                          )
                        : GestureDetector(
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
                      'Ongoing Orders',
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
                      child: Column(
                        children: [
                          SizedBox(
                            height: Get.height * 0.03,
                          ),
                          Container(
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
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                )))
                                          ],
                                        )
                                      : Column(children: [
                                          Container(
                                            child: ListView.builder(
                                                scrollDirection: Axis.vertical,
                                                physics:
                                                    NeverScrollableScrollPhysics(),
                                                shrinkWrap: true,
                                                // controller: scrollController,
                                                itemCount: homeScreenController
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
                                                                  left: 20.0,
                                                                  right: 20,
                                                                  bottom: 15),
                                                          child: Container(
                                                              height:
                                                                  Get.height *
                                                                      0.3,
                                                              width: Get.width *
                                                                  0.9,
                                                              decoration: BoxDecoration(
                                                                  color: Colors
                                                                      .white,
                                                                  borderRadius:
                                                                      BorderRadius.all(
                                                                          Radius.circular(
                                                                              20))),
                                                              child: Padding(
                                                                padding: EdgeInsets
                                                                    .only(
                                                                        left:
                                                                            20.0),
                                                                child: Column(
                                                                  children: [
                                                                    SizedBox(
                                                                        height: Get.height *
                                                                            0.02),
                                                                    Row(
                                                                      children: [
                                                                        Text(
                                                                          homeScreenController
                                                                              .homeScreenData
                                                                              .value
                                                                              .data!
                                                                              .store!
                                                                              .name
                                                                              .toString(),
                                                                          style: TextStyle(
                                                                              color: Color.fromRGBO(48, 48, 48, 1),
                                                                              fontSize: 18,
                                                                              fontWeight: FontWeight.w600,
                                                                              fontFamily: "Poppins"),
                                                                        )
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
                                                                          "Required to be picked: ${(homeScreenController.homeScreenData.value.data!.current![i].timing == "as_soon") ? "ASAP" : homeScreenController.homeScreenData.value.data!.current![i].timing.toString()}",
                                                                          style: TextStyle(
                                                                              color: Color.fromRGBO(48, 48, 48, 1),
                                                                              fontSize: 14,
                                                                              fontWeight: FontWeight.w500,
                                                                              fontFamily: "Poppins"),
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
                                                                          padding:
                                                                              EdgeInsets.only(left: 8.0),
                                                                          child:
                                                                              Column(
                                                                            crossAxisAlignment:
                                                                                CrossAxisAlignment.start,
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
                                                                      height: Get
                                                                              .height *
                                                                          0.015,
                                                                    ),
                                                                    Row(
                                                                      children: [
                                                                        GestureDetector(
                                                                          onTap:
                                                                              () {
                                                                            Get.to(() =>
                                                                                ProductScreen(id: homeScreenController.homeScreenData.value.data!.current![i].id.toString()));
                                                                          },
                                                                          child:
                                                                              Container(
                                                                            height:
                                                                                Get.height * 0.04,
                                                                            width:
                                                                                Get.width * 0.25,
                                                                            decoration:
                                                                                BoxDecoration(color: AppColor.primaryColor, borderRadius: BorderRadius.all(Radius.circular(60))),
                                                                            child:
                                                                                Center(
                                                                              child: Text(
                                                                                'Details',
                                                                                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400, fontFamily: 'RammettoOne', color: Colors.white),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        SizedBox(
                                                                          width:
                                                                              Get.width * 0.02,
                                                                        ),
                                                                        GestureDetector(
                                                                          onTap:
                                                                              () {
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
                                                                          child:
                                                                              Container(
                                                                            height:
                                                                                Get.height * 0.04,
                                                                            width:
                                                                                Get.width * 0.25,
                                                                            decoration:
                                                                                BoxDecoration(color: AppColor.secondaryColor, borderRadius: BorderRadius.all(Radius.circular(60))),
                                                                            child:
                                                                                Center(
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
                                        ])),
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
