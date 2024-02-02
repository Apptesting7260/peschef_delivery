import 'package:peschef_delivery/controller/productScreenController.dart';
import 'package:peschef_delivery/data/response/status.dart';
import 'package:peschef_delivery/res/colors/app_color.dart';
import 'package:peschef_delivery/res/components/general_exception.dart';
import 'package:peschef_delivery/res/components/internet_exceptions_widget.dart';
import 'package:peschef_delivery/view/restroTrack.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductScreen extends StatefulWidget {
  final String id;
  const ProductScreen({
    super.key,
    required this.id,
  });

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

final ProductScreenController productScreenController =
    Get.put(ProductScreenController());

class _ProductScreenState extends State<ProductScreen> {
  @override
  void initState() {
    // TODO: implement initState
    productScreenController.ProductScreenApi(widget.id.toString());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(widget.id);
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
                    // SizedBox(
                    //   width: Get.width * 0.08,
                    // ),
                    // Obx(
                    //   () => (singleProductController.rxRequestStatus ==
                    //           Status.LOADING)
                    //       ? Container()
                    //       : Container(
                    //           child: Text(
                    //           singleProductController
                    //               .SingleProductData.value.product!.title
                    //               .toString(),
                    //           style: TextStyle(
                    //               fontSize: 20,
                    //               fontWeight: FontWeight.w400,
                    //               fontFamily: 'RammettoOne'),
                    //         )),
                    // ),
                  ],
                ),
              ),
            ),
            body: Obx(() {
              switch (productScreenController.rxRequestStatus.value) {
                case Status.LOADING:
                  return const Center(
                      child: CircularProgressIndicator(
                    color: AppColor.primaryColor,
                  ));
                case Status.ERROR:
                  if (productScreenController.error.value == 'No internet') {
                    return InterNetExceptionWidget(
                      onPress: () {
                        productScreenController.ProductScreenApi(
                            widget.id.toString());
                      },
                    );
                  } else {
                    return GeneralExceptionWidget(onPress: () {
                      productScreenController.ProductScreenApi(
                          widget.id.toString());
                    });
                  }
                case Status.COMPLETED:
                  return RefreshIndicator(
                      color: AppColor.primaryColor,
                      onRefresh: () async {
                        productScreenController.ProductScreenApi(
                            widget.id.toString());
                      },
                      child: SingleChildScrollView(
                        physics: AlwaysScrollableScrollPhysics(),
                        child: Column(children: [
                          SizedBox(height: Get.height * 0.02),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: Get.width * 0.87,
                                // height: Get.height*0.3,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(25),
                                  color: Colors.white,
                                ),
                                child: Column(
                                  children: [
                                    Stack(
                                      children: [
                                        Container(
                                          child: Padding(
                                            padding: const EdgeInsets.all(20),
                                            child: Column(
                                              children: [
                                                Container(
                                                  height: Get.height * 0.28,
                                                  width: Get.width * 0.76,
                                                  decoration: BoxDecoration(
                                                    color: Color.fromRGBO(
                                                        242, 242, 242, 1),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                  ),
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                    child: Image.network(
                                                      productScreenController
                                                          .productScreenData
                                                          .value
                                                          .data!
                                                          .productDetails!
                                                          .cartId![0]
                                                          .product!
                                                          .image
                                                          .toString(),
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        // Positioned(
                                        //   right: 5,
                                        //   top: 32,
                                        //   child: Container(
                                        //     decoration: BoxDecoration(
                                        //         shape: BoxShape.circle,
                                        //         color: Colors.white),
                                        //     height: Get.height * 0.04,
                                        //     width: Get.width * 0.2,
                                        //     child: Icon(
                                        //       Icons.favorite_border,
                                        //       color: Color.fromRGBO(
                                        //           254, 51, 72, 1),
                                        //     ),
                                        //   ),
                                        // ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        SizedBox(
                                          width: Get.width * 0.05,
                                        ),
                                        Text(
                                          productScreenController
                                              .productScreenData
                                              .value
                                              .data!
                                              .productDetails!
                                              .cartId![0]
                                              .product!
                                              .title
                                              .toString(),
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontFamily: "RammettoOne",
                                              color:
                                                  Color.fromRGBO(9, 64, 94, 1)),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: Get.height * 0.005,
                                    ),
                                    // Row(
                                    //   children: [
                                    //     SizedBox(
                                    //       width: Get.width * 0.05,
                                    //     ),
                                    //     Text(
                                    //       "Orders ID: ",
                                    //       style: TextStyle(
                                    //           color: Color.fromRGBO(
                                    //               143, 149, 158, 1),
                                    //           fontSize: 14,
                                    //           fontWeight: FontWeight.w400,
                                    //           fontFamily: "Poppins"),
                                    //     ),
                                    //     Text(
                                    //       "#USP232D",
                                    //       style: TextStyle(
                                    //           color: Color.fromRGBO(
                                    //               143, 149, 158, 1),
                                    //           fontSize: 14,
                                    //           fontWeight: FontWeight.w400,
                                    //           fontFamily: "Poppins"),
                                    //     )
                                    //   ],
                                    // ),
                                    // SizedBox(
                                    //   height: Get.height * 0.005,
                                    // ),
                                    Row(
                                      children: [
                                        SizedBox(
                                          width: Get.width * 0.05,
                                        ),
                                        Container(
                                            height: Get.width * 0.05,
                                            width: Get.width * 0.05,
                                            child: Image.asset(
                                              "assets/images/time.png",
                                              fit: BoxFit.cover,
                                            )),
                                        SizedBox(
                                          width: Get.width * 0.02,
                                        ),
                                        Text(
                                          (productScreenController
                                                      .productScreenData
                                                      .value
                                                      .data!
                                                      .productDetails!
                                                      .timing ==
                                                  "as_soon")
                                              ? "ASAP"
                                              : productScreenController
                                                  .productScreenData
                                                  .value
                                                  .data!
                                                  .productDetails!
                                                  .timing
                                                  .toString(),
                                          style: TextStyle(
                                              color: Color.fromRGBO(
                                                  143, 149, 158, 1),
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400,
                                              fontFamily: "Poppins"),
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: Get.height * 0.005,
                                    ),
                                    Row(
                                      children: [
                                        SizedBox(
                                          width: Get.width * 0.05,
                                        ),
                                        Container(
                                            height: Get.width * 0.05,
                                            width: Get.width * 0.05,
                                            child: Image.asset(
                                              "assets/images/km.png",
                                              fit: BoxFit.cover,
                                            )),
                                        SizedBox(
                                          width: Get.width * 0.02,
                                        ),
                                        Text(
                                          "5 Km",
                                          style: TextStyle(
                                              color: Color.fromRGBO(
                                                  143, 149, 158, 1),
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400,
                                              fontFamily: "Poppins"),
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: Get.height * 0.005,
                                    ),
                                    Row(
                                      children: [
                                        SizedBox(
                                          width: Get.width * 0.05,
                                        ),
                                        Container(
                                            height: Get.width * 0.05,
                                            width: Get.width * 0.05,
                                            child: Image.asset(
                                              "assets/images/locationG.png",
                                              fit: BoxFit.cover,
                                            )),
                                        SizedBox(
                                          width: Get.width * 0.02,
                                        ),
                                        Text(
                                          "49th St Los Angeles, California",
                                          style: TextStyle(
                                              color: Color.fromRGBO(
                                                  143, 149, 158, 1),
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400,
                                              fontFamily: "Poppins"),
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: Get.height * 0.015,
                                    ),
                                    Row(
                                      children: [
                                        SizedBox(
                                          width: Get.width * 0.05,
                                        ),
                                        Text(
                                          "Customer order",
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontFamily: "RammettoOne",
                                              color:
                                                  Color.fromRGBO(9, 64, 94, 1)),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: Get.height * 0.005,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            SizedBox(
                                              width: Get.width * 0.07,
                                            ),
                                            Text(
                                              "Sub Total",
                                              style: TextStyle(
                                                  fontFamily: "Poppins",
                                                  fontWeight: FontWeight.bold,
                                                  color: Color.fromRGBO(
                                                      119, 119, 119, 1),
                                                  fontSize: 16),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              "€${productScreenController.productScreenData.value.data!.productDetails!.subTotal.toString()}",
                                              style: TextStyle(
                                                  fontFamily: "RammettoOne",
                                                  fontWeight: FontWeight.w500,
                                                  color: Color.fromRGBO(
                                                      9, 64, 94, 1),
                                                  fontSize: 14),
                                            ),
                                            SizedBox(
                                              width: Get.width * 0.07,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: Get.height * 0.008,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            SizedBox(
                                              width: Get.width * 0.07,
                                            ),
                                            Text(
                                              "Pick Up discount",
                                              style: TextStyle(
                                                  fontFamily: "Poppins",
                                                  fontWeight: FontWeight.bold,
                                                  color: Color.fromRGBO(
                                                      119, 119, 119, 1),
                                                  fontSize: 16),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              "€${productScreenController.productScreenData.value.data!.productDetails!.onPickupDiscunt.toString()}",
                                              style: TextStyle(
                                                  fontFamily: "RammettoOne",
                                                  fontWeight: FontWeight.w500,
                                                  color: Color.fromRGBO(
                                                      9, 64, 94, 1),
                                                  fontSize: 14),
                                            ),
                                            SizedBox(
                                              width: Get.width * 0.07,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: Get.height * 0.008,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            SizedBox(
                                              width: Get.width * 0.07,
                                            ),
                                            Text(
                                              "Coupon Discount",
                                              style: TextStyle(
                                                  fontFamily: "Poppins",
                                                  fontWeight: FontWeight.bold,
                                                  color: Color.fromRGBO(
                                                      119, 119, 119, 1),
                                                  fontSize: 16),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              "€${productScreenController.productScreenData.value.data!.productDetails!.couponDiscunt.toString()}",
                                              style: TextStyle(
                                                  fontFamily: "RammettoOne",
                                                  fontWeight: FontWeight.w500,
                                                  color: Color.fromRGBO(
                                                      9, 64, 94, 1),
                                                  fontSize: 14),
                                            ),
                                            SizedBox(
                                              width: Get.width * 0.07,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: Get.height * 0.008,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            SizedBox(
                                              width: Get.width * 0.07,
                                            ),
                                            Text(
                                              "Points Discount",
                                              style: TextStyle(
                                                  fontFamily: "Poppins",
                                                  fontWeight: FontWeight.bold,
                                                  color: Color.fromRGBO(
                                                      119, 119, 119, 1),
                                                  fontSize: 16),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              "€${productScreenController.productScreenData.value.data!.productDetails!.issuePoinDiscunt.toString()}",
                                              style: TextStyle(
                                                  fontFamily: "RammettoOne",
                                                  fontWeight: FontWeight.w500,
                                                  color: Color.fromRGBO(
                                                      9, 64, 94, 1),
                                                  fontSize: 14),
                                            ),
                                            SizedBox(
                                              width: Get.width * 0.07,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: Get.height * 0.008,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            SizedBox(
                                              width: Get.width * 0.06,
                                              height: Get.height * 0.03,
                                            ),
                                            Text(
                                              "Total",
                                              style: TextStyle(
                                                  fontFamily: "Poppins",
                                                  color: Color.fromRGBO(
                                                      0, 0, 0, 1),
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            SizedBox(
                                              width: Get.width * 0.02,
                                            ),
                                            Text(
                                                "(${productScreenController.productScreenData.value.data!.productDetails!.cartId!.length}, Item)",
                                                style: TextStyle(
                                                    fontFamily: "Poppins",
                                                    color: Color.fromRGBO(
                                                        119, 119, 119, 1),
                                                    fontSize: 12,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              "€${productScreenController.productScreenData.value.data!.productDetails!.netAmount.toString()}",
                                              style: TextStyle(
                                                  fontFamily: "RammettoOne",
                                                  color: Color.fromRGBO(
                                                      225, 143, 71, 1),
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            SizedBox(
                                              width: Get.width * 0.06,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: Get.height * 0.025,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        Get.to(() => RestaurantTrackScreen());
                                      },
                                      child: Container(
                                        height: Get.height * 0.065,
                                        width: Get.width * 0.6,
                                        decoration: BoxDecoration(
                                            color: AppColor.primaryColor,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(60))),
                                        child: Center(
                                          child:
                                              //  (addToCartController
                                              //             .rxRequestStatus.value ==
                                              //         Status.LOADING)
                                              //     ? CircularProgressIndicator(
                                              //         color: Colors.white,
                                              //       )
                                              //     :
                                              Text(
                                            'Pick up',
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400,
                                                fontFamily: 'RammettoOne',
                                                color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: Get.height * 0.05,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: Get.height * 0.13,
                          )
                        ]),
                      ));
              }
            })));
  }
}
