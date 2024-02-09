import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/services.dart';
import 'package:peschef_delivery/res/colors/app_color.dart';
import 'package:peschef_delivery/view/homeScreen.dart';
import 'package:peschef_delivery/view/tabBarView.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:location/location.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomerTrackScreen extends StatefulWidget {
  const CustomerTrackScreen({super.key});

  @override
  State<CustomerTrackScreen> createState() => _CustomerTrackScreenState();
}

class _CustomerTrackScreenState extends State<CustomerTrackScreen> {
  final Completer<GoogleMapController> _controller = Completer();
  late StreamSubscription<LocationData> locationSubscription;
  static const LatLng sourceLocation =
      LatLng(26.962792048609355, 75.7689452854216);
  static const LatLng destination =
      LatLng(26.966646479141453, 75.77189977134597);
  List<LatLng> polylineCoordinates = [];
  void getPolyPoints() async {
    PolylinePoints polylinePoints = PolylinePoints();

    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      "AIzaSyDCYxwFU7VXnXce\_-YEsl2ETWP-SWT81VY", // Your Google Map Key
      PointLatLng(currentLocation!.latitude!, currentLocation!.longitude!),
      PointLatLng(destination.latitude, destination.longitude),
      travelMode: TravelMode.transit,
    );
    if (result.points.isNotEmpty) {
      result.points.forEach(
        (PointLatLng point) => polylineCoordinates.add(
          LatLng(point.latitude, point.longitude),
        ),
      );
      setState(() {});
    }
  }

  LocationData? currentLocation;
  void getCurrentLocation() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    String token = sp.getString('token') ?? "";
    Location location = Location();
    location.getLocation().then(
      (location) {
        currentLocation = location;
        getPolyPoints();
      },
    );
    GoogleMapController googleMapController = await _controller.future;
    locationSubscription = location.onLocationChanged.listen(
      (newLoc) async {
        currentLocation = newLoc;
        print("chala${currentLocation}");

        FirebaseDatabase.instance
            .ref()
            .child("users")
            .child(token)
            .update({"lat": newLoc.latitude!, "long": newLoc.longitude!});
        googleMapController.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
              zoom: 17,
              target: LatLng(
                newLoc.latitude!,
                newLoc.longitude!,
              ),
            ),
          ),
        );
        setState(() {});
      },
    );
  }

  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

  BitmapDescriptor sourceIcon = BitmapDescriptor.defaultMarker;
  BitmapDescriptor destinationIcon = BitmapDescriptor.defaultMarker;
  BitmapDescriptor currentLocationIcon = BitmapDescriptor.defaultMarker;
  Future<void> setCustomMarkerIcon() async {
    final Uint8List markerIcon1 =
        await getBytesFromAsset('assets/Pin_source.png', 50);
    setState(() {
      sourceIcon = BitmapDescriptor.fromBytes(markerIcon1);
    });

    final Uint8List markerIcon2 =
        await getBytesFromAsset('assets/Pin_destination.png', 80);
    setState(() {
      destinationIcon = BitmapDescriptor.fromBytes(markerIcon2);
    });

    final Uint8List markerIcon3 =
        await getBytesFromAsset('assets/Badge.png', 50);
    setState(() {
      currentLocationIcon = BitmapDescriptor.fromBytes(markerIcon3);
    });
    // BitmapDescriptor.fromAssetImage(
    //         ImageConfiguration.empty, "assets/Pin_source.png")
    //     .then(
    //   (icon) {
    //     sourceIcon = icon;
    //   },
    // );
    // BitmapDescriptor.fromAssetImage(
    //         ImageConfiguration.empty, "assets/Pin_destination.png")
    //     .then(
    //   (icon) {
    //     destinationIcon = icon;
    //   },
    // );
    // BitmapDescriptor.fromAssetImage(
    //         ImageConfiguration.empty, "assets/Badge.png")
    //     .then(
    //   (icon) {
    //     currentLocationIcon = icon;
    //   },
    // );
  }

  @override
  void initState() {
    // TODO: implement initState

    getCurrentLocation();
    setCustomMarkerIcon();
    super.initState();
  }

  @override
  void dispose() {
    // Dispose of the location subscription when the page is no longer active
    locationSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color.fromRGBO(242, 242, 242, 1),
        body: Stack(
          children: [
            currentLocation == null
                ? const Center(child: Text("Loading"))
                : GoogleMap(
                    initialCameraPosition: CameraPosition(
                      target: LatLng(currentLocation!.latitude!,
                          currentLocation!.longitude!),
                      zoom: 13.5,
                    ),
                    markers: {
                      Marker(
                        markerId: MarkerId("currentLocation"),
                        icon: currentLocationIcon,
                        position: LatLng(currentLocation!.latitude!,
                            currentLocation!.longitude!),
                      ),
                      Marker(
                        markerId: MarkerId("source"),
                        icon: sourceIcon,
                        position: sourceLocation,
                      ),
                      Marker(
                        markerId: MarkerId("destination"),
                        icon: destinationIcon,
                        position: destination,
                      ),
                    },
                    onMapCreated: (mapController) {
                      _controller.complete(mapController);
                    },
                    polylines: {
                      Polyline(
                        polylineId: const PolylineId("route"),
                        points: polylineCoordinates,
                        color: AppColor.primaryColor,
                        width: 6,
                      ),
                    },
                  ),
            // Positioned(
            //     bottom: Get.height * 0.3,
            //     left: Get.width * 0.05,
            //     child: Container(
            //       height: Get.height * 0.19,
            //       width: Get.width * 0.9,
            //       decoration: BoxDecoration(
            //         color: Colors.white,
            //         borderRadius: BorderRadius.all(Radius.circular(20)),
            //       ),
            //       child: Column(
            //         children: [
            //           SizedBox(
            //             height: Get.height * 0.02,
            //           ),
            //           Row(
            //             children: [
            //               SizedBox(
            //                 width: Get.width * 0.05,
            //               ),
            //               Text(
            //                 'Delivery Your Order',
            //                 style: TextStyle(
            //                     fontSize: 16,
            //                     fontWeight: FontWeight.w400,
            //                     fontFamily: 'RammettoOne',
            //                     color: Color.fromRGBO(9, 64, 94, 1)),
            //               ),
            //             ],
            //           ),
            //           SizedBox(
            //             height: Get.height * 0.005,
            //           ),
            //           Row(
            //             children: [
            //               SizedBox(
            //                 width: Get.width * 0.05,
            //               ),
            //               Text(
            //                 'Extimated within 20 minutes',
            //                 style: TextStyle(
            //                     fontSize: 14,
            //                     fontWeight: FontWeight.w400,
            //                     fontFamily: 'Poppins',
            //                     color: Color.fromRGBO(119, 119, 119, 1)),
            //               ),
            //             ],
            //           ),
            //           Padding(
            //             padding: const EdgeInsets.only(left: 12, right: 12),
            //             child: Divider(),
            //           ),
            //           SizedBox(
            //             height: Get.height * 0.005,
            //           ),
            //           Row(
            //             children: [
            //               Column(
            //                 crossAxisAlignment: CrossAxisAlignment.start,
            //                 children: [
            //                   Row(
            //                     children: [
            //                       SizedBox(
            //                         width: Get.width * 0.05,
            //                       ),
            //                       Text(
            //                         'Crispy Chicken',
            //                         style: TextStyle(
            //                           fontSize: 16,
            //                           fontWeight: FontWeight.w700,
            //                           fontFamily: 'Poppins',
            //                         ),
            //                       ),
            //                     ],
            //                   ),
            //                   Row(
            //                     children: [
            //                       SizedBox(
            //                         width: Get.width * 0.05,
            //                       ),
            //                       Text(
            //                         "\$" + '20.99',
            //                         style: TextStyle(
            //                             fontSize: 14,
            //                             fontWeight: FontWeight.w700,
            //                             fontFamily: 'Poppins',
            //                             color: AppColor.primaryColor),
            //                       ),
            //                       SizedBox(
            //                         width: Get.width * 0.01,
            //                       ),
            //                       Icon(Icons.circle,
            //                           size: 8,
            //                           color: Color.fromRGBO(119, 119, 119, 1)),
            //                       SizedBox(
            //                         width: Get.width * 0.01,
            //                       ),
            //                       Text(
            //                         '2 items',
            //                         style: TextStyle(
            //                             fontSize: 14,
            //                             fontWeight: FontWeight.w400,
            //                             fontFamily: 'Poppins',
            //                             color: Color.fromRGBO(119, 119, 119, 1)),
            //                       ),
            //                       SizedBox(
            //                         width: Get.width * 0.01,
            //                       ),
            //                       Icon(Icons.circle,
            //                           size: 8,
            //                           color: Color.fromRGBO(119, 119, 119, 1)),
            //                       SizedBox(
            //                         width: Get.width * 0.01,
            //                       ),
            //                       Text(
            //                         'Credit Card',
            //                         style: TextStyle(
            //                             fontSize: 14,
            //                             fontWeight: FontWeight.w400,
            //                             fontFamily: 'Poppins',
            //                             color: Color.fromRGBO(119, 119, 119, 1)),
            //                       ),
            //                     ],
            //                   ),
            //                 ],
            //               ),
            //               Column(
            //                 crossAxisAlignment: CrossAxisAlignment.start,
            //                 children: [
            //                   Row(
            //                     children: [
            //                       SizedBox(
            //                         width: Get.width * 0.07,
            //                       ),
            //                       GestureDetector(
            //                         onTap: () {},
            //                         child: Container(
            //                           height: Get.height * 0.035,
            //                           width: Get.width * 0.17,
            //                           decoration: BoxDecoration(
            //                               color: AppColor.primaryColor,
            //                               borderRadius: BorderRadius.all(
            //                                   Radius.circular(60))),
            //                           child: Center(
            //                             child: Text(
            //                               'Detail',
            //                               style: TextStyle(
            //                                   fontSize: 10,
            //                                   fontWeight: FontWeight.w400,
            //                                   fontFamily: 'RammettoOne',
            //                                   color: Colors.white),
            //                             ),
            //                           ),
            //                         ),
            //                       ),
            //                     ],
            //                   ),
            //                 ],
            //               ),
            //             ],
            //           ),
            //           SizedBox(
            //             height: Get.height * 0.005,
            //           ),
            //         ],
            //       ),
            //     )),
            Positioned(
              top: 10,
              left: 10,
              child: GestureDetector(
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
            ),
            Positioned(
                bottom: 8,
                left: Get.width * 0.05,
                child: Container(
                  height: Get.height * 0.38,
                  width: Get.width * 0.9,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        height: Get.height * 0.01,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: Get.width * 0.05,
                          ),
                          Column(
                            children: [
                              Icon(Icons.circle,
                                  size: 20, color: AppColor.primaryColor),
                              Dash(
                                  direction: Axis.vertical,
                                  length: 70,
                                  dashLength: 5,
                                  dashColor: Colors.grey),
                              Icon(
                                Icons.location_pin,
                                size: 28,
                                color: AppColor.primaryColor,
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  SizedBox(
                                    width: Get.width * 0.05,
                                  ),
                                  Text(
                                    '1453 Ave Los Angeles',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                      fontFamily: 'Poppins',
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: Get.height * 0.005,
                              ),
                              Row(
                                children: [
                                  SizedBox(
                                    width: Get.width * 0.04,
                                  ),
                                  SizedBox(
                                    width: Get.width * 0.01,
                                  ),
                                  Text(
                                    'Restaurant',
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        fontFamily: 'Poppins',
                                        color:
                                            Color.fromRGBO(119, 119, 119, 1)),
                                  ),
                                  SizedBox(
                                    width: Get.width * 0.01,
                                  ),
                                  Icon(Icons.circle,
                                      size: 8,
                                      color: Color.fromRGBO(119, 119, 119, 1)),
                                  SizedBox(
                                    width: Get.width * 0.01,
                                  ),
                                  Text(
                                    '21:00',
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        fontFamily: 'Poppins',
                                        color:
                                            Color.fromRGBO(119, 119, 119, 1)),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: Get.height * 0.03,
                              ),
                              Row(
                                children: [
                                  SizedBox(
                                    width: Get.width * 0.05,
                                  ),
                                  Text(
                                    'You - 49th St Los Angeles',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                      fontFamily: 'Poppins',
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: Get.height * 0.005,
                              ),
                              Row(
                                children: [
                                  SizedBox(
                                    width: Get.width * 0.04,
                                  ),
                                  Text(
                                    'Home',
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        fontFamily: 'Poppins',
                                        color:
                                            Color.fromRGBO(119, 119, 119, 1)),
                                  ),
                                  SizedBox(
                                    width: Get.width * 0.01,
                                  ),
                                  Icon(Icons.circle,
                                      size: 8,
                                      color: Color.fromRGBO(119, 119, 119, 1)),
                                  SizedBox(
                                    width: Get.width * 0.01,
                                  ),
                                  Text(
                                    '21:00',
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        fontFamily: 'Poppins',
                                        color:
                                            Color.fromRGBO(119, 119, 119, 1)),
                                  ),
                                ],
                              ),
                            ],
                          )
                        ],
                      ),
                      SizedBox(
                        height: Get.height * 0.01,
                      ),
                      Container(
                        height: Get.height * 0.09,
                        width: Get.width * 0.8,
                        decoration: BoxDecoration(
                            color: Color.fromRGBO(214, 51, 72, 0.08),
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        child: Row(
                          children: [
                            SizedBox(
                              width: Get.width * 0.03,
                            ),
                            CircleAvatar(
                              radius: Get.width * 0.06,
                              backgroundImage: NetworkImage(
                                  "https://t4.ftcdn.net/jpg/03/64/21/11/360_F_364211147_1qgLVxv1Tcq0Ohz3FawUfrtONzz8nq3e.jpg"),
                              backgroundColor: Colors.transparent,
                            ),
                            SizedBox(
                              width: Get.width * 0.04,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: Get.height * 0.02,
                                ),
                                Text(
                                  'Philippe Troussier',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                    fontFamily: 'Poppins',
                                  ),
                                ),
                                SizedBox(
                                  height: Get.height * 0.005,
                                ),
                                Text(
                                  '0145425765',
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      fontFamily: 'Poppins',
                                      color: Color.fromRGBO(119, 119, 119, 1)),
                                ),
                              ],
                            ),
                            SizedBox(
                              width: Get.width * 0.045,
                            ),
                            Container(
                                height: Get.height * 0.06,
                                width: Get.width * 0.1,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: AppColor.primaryColor),
                                child: Icon(
                                  Icons.call,
                                  size: 25,
                                  color: Colors.white,
                                )),
                            SizedBox(
                              width: Get.width * 0.01,
                            ),
                            Container(
                                height: Get.height * 0.06,
                                width: Get.width * 0.1,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Color.fromRGBO(9, 64, 94, 1)),
                                child: Icon(
                                  Icons.message,
                                  size: 22,
                                  color: Colors.white,
                                )),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: Get.height * 0.025,
                      ),
                      GestureDetector(
                        onTap: () {
                          showDialogSuccessfull();
                        },
                        child: Container(
                          height: Get.height * 0.065,
                          width: Get.width * 0.5,
                          decoration: BoxDecoration(
                              color: AppColor.primaryColor,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(60))),
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
                              'Delivered',
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: 'RammettoOne',
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ))
          ],
        ),
      ),
    );
  }

  Future<void> showDialogSuccessfull() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true, // user must tap button!

      builder: (BuildContext context) {
        return Dialog(
          elevation: 0,
          backgroundColor: Colors.white,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
            ),
            height: Get.height * 0.52,
            width: Get.width * 0.8,
            child: Column(
              children: [
                SizedBox(
                  height: Get.height * 0.04,
                ),
                CircleAvatar(
                  radius: Get.width * 0.1,
                  backgroundColor: Colors.white,
                  child: Image.asset(
                    'assets/images/good_s.png',
                    fit: BoxFit.contain,
                  ),
                ),
                SizedBox(
                  height: Get.height * 0.02,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Order is successfully \ndelivered',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'RammettoOne',
                        color: Color.fromRGBO(9, 64, 94, 1),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: Get.height * 0.02,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text.rich(TextSpan(
                        text: 'Your order ',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'Poppins',
                          color: Color.fromRGBO(176, 169, 162, 1),
                        ),
                        children: <InlineSpan>[
                          TextSpan(
                            text: '#33-A45E',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Colors.black),
                          ),
                          TextSpan(
                            text:
                                ' has been \nsuccessfully delivered to your \nlocation. ',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              fontFamily: 'Poppins',
                              color: Color.fromRGBO(176, 169, 162, 1),
                            ),
                          )
                        ])),
                    // Text(
                    //   'Your order',
                    //   style: TextStyle(
                    //     fontSize: 12,
                    //     fontWeight: FontWeight.w400,
                    //     fontFamily: 'Poppins',
                    //     color: Color.fromRGBO(9, 64, 94, 1),
                    //   ),
                    // ),
                    // Text(
                    //   '#33-A45E',
                    //   style: TextStyle(
                    //     fontSize: 12,
                    //     fontWeight: FontWeight.w400,
                    //     fontFamily: 'Poppins',
                    //     color: Color.fromRGBO(9, 64, 94, 1),
                    //   ),
                    // ),
                    // Text(
                    //   ' has been \nsuccessfully delivered to your \nlocation. ',
                    //   style: TextStyle(
                    //     fontSize: 12,
                    //     fontWeight: FontWeight.w400,
                    //     fontFamily: 'Poppins',
                    //     color: Color.fromRGBO(9, 64, 94, 1),
                    //   ),
                    // ),
                  ],
                ),
                SizedBox(
                  height: Get.height * 0.03,
                ),
                GestureDetector(
                  onTap: () {
                    Get.back();
                    cashCollectSuccessfull();
                    // Get.to(() => IncomingRequestSinglePage());
                    // Get.off(MenuScreen());
                  },
                  child: Container(
                    height: Get.height * 0.06,
                    width: Get.width * 0.6,
                    decoration: BoxDecoration(
                      color: AppColor.primaryColor,
                      borderRadius: BorderRadius.circular(60),
                    ),
                    child: Center(
                      child: Text(
                        'Continue',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'RammettoOne',
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: Get.height * 0.025,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        // Get.offAllNamed(RouteName.tabBarScreen);
                      },
                      child: Text(
                        'Received payment only cash on\ndelivery',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          decoration: TextDecoration.underline,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Poppins',
                          color: Color.fromRGBO(9, 64, 94, 1),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> cashCollectSuccessfull() async {
    return showModalBottomSheet(
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
                Text(
                  "25,80",
                  style: TextStyle(
                    fontSize: 30,
                    fontFamily: "RammettoOne",
                    color: Color.fromRGBO(225, 143, 71, 1),
                  ),
                ),
                SizedBox(
                  height: Get.height * 0.02,
                ),
                Text(
                  "Placed order is Cod",
                  style: TextStyle(fontSize: 18, fontFamily: "RammettoOne"),
                ),
                SizedBox(
                  height: Get.height * 0.01,
                ),
                Text(
                  "Have you recevied a payment",
                  style: TextStyle(
                      fontSize: 16,
                      color: Color.fromRGBO(119, 119, 119, 1),
                      fontFamily: "Poppins"),
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
                        decoration: BoxDecoration(
                            color: Color.fromRGBO(9, 64, 94, 1),
                            borderRadius:
                                BorderRadius.all(Radius.circular(60))),
                        child: Center(
                          child: Text(
                            'No',
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                fontFamily: 'RammettoOne',
                                color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.back();
                        DeliverdSuccessfull();
                        // deleteAccountController
                        //     .DeleteAccountApi();
                      },
                      child: Container(
                        height: Get.height * 0.05,
                        width: Get.width * 0.4,
                        decoration: BoxDecoration(
                            color: AppColor.primaryColor,
                            borderRadius:
                                BorderRadius.all(Radius.circular(60))),
                        child: Center(
                          child:
                              //  (deleteAccountController
                              //             .rxRequestStatus ==
                              //         Status.LOADING)
                              //     ? CircularProgressIndicator(
                              //         color: Colors.white,
                              //       )
                              //     :
                              Text(
                            'Yes',
                            style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w400,
                                fontFamily: 'RammettoOne',
                                color: Colors.white),
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
  }

  Future<void> DeliverdSuccessfull() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true, // user must tap button!

      builder: (BuildContext context) {
        return Dialog(
          elevation: 0,
          backgroundColor: Colors.white,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
            ),
            height: Get.height * 0.52,
            width: Get.width * 0.8,
            child: Column(
              children: [
                SizedBox(
                  height: Get.height * 0.04,
                ),
                CircleAvatar(
                  radius: Get.width * 0.13,
                  backgroundColor: Colors.white,
                  child: Image.asset(
                    'assets/images/good_s.png',
                    fit: BoxFit.contain,
                  ),
                ),
                SizedBox(
                  height: Get.height * 0.02,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Payment received \nsuccessfully',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'RammettoOne',
                        color: Color.fromRGBO(9, 64, 94, 1),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: Get.height * 0.02,
                ),
                Text(
                  "25,80",
                  style: TextStyle(
                    fontSize: 30,
                    fontFamily: "RammettoOne",
                    color: Color.fromRGBO(225, 143, 71, 1),
                  ),
                ),
                SizedBox(
                  height: Get.height * 0.03,
                ),
                GestureDetector(
                  onTap: () {
                    Get.offAll(() => MyTabView());
                    // cashCollectSuccessfull();
                    // Get.to(() => IncomingRequestSinglePage());
                    // Get.off(MenuScreen());
                  },
                  child: Container(
                    height: Get.height * 0.06,
                    width: Get.width * 0.6,
                    decoration: BoxDecoration(
                      color: AppColor.primaryColor,
                      borderRadius: BorderRadius.circular(60),
                    ),
                    child: Center(
                      child: Text(
                        'Back to home',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'RammettoOne',
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: Get.height * 0.025,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<List<LatLng>> getPolylinePoints(
    LatLng start, // Delivery boy's location
    LatLng end, // Delivery location
  ) async {
    List<LatLng> polylineCoordinates = [];
    PolylinePoints polylinePoints = PolylinePoints();

    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      'AIzaSyACG0YonxAConKXfgaeVYj7RCRdXazrPYI', // Replace with your Google Maps API key
      PointLatLng(start.latitude, start.longitude),
      PointLatLng(end.latitude, end.longitude),
      travelMode: TravelMode.driving,
    );

    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    }

    return polylineCoordinates;
  }
}
