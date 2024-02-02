import 'package:peschef_delivery/res/colors/app_color.dart';
import 'package:peschef_delivery/view/customerTrack.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_dash/flutter_dash.dart';

class RestaurantTrackScreen extends StatefulWidget {
  const RestaurantTrackScreen({super.key});

  @override
  State<RestaurantTrackScreen> createState() => _RestaurantTrackScreenState();
}

class _RestaurantTrackScreenState extends State<RestaurantTrackScreen> {
  GoogleMapController? mapController;
  final LatLng deliveryBoyLocation = LatLng(
      26.963542752000617, 75.76901367301714); // Sample delivery boy location
  final LatLng customerLocation =
      LatLng(26.967425254818586, 75.77169862327624); // Sample delivery location
  // final LatLng drop1 = LatLng(26.95931197574436, 75.77130452433698);
  List<LatLng> polylineCoordinates = []; // Store the polyline points
  // List<LatLng> polylineCoordinates2 = [];
  final LatLng caemraPoint =
      LatLng(26.963542752000617 - 0.005, 75.76901367301714 + 0.001);
  @override
  void initState() {
    super.initState();
    fetchPolylinePoints();
    // fetchPolylinePoints2();
  }

  // Function to fetch and store polyline points
  void fetchPolylinePoints() async {
    polylineCoordinates =
        await getPolylinePoints(deliveryBoyLocation, customerLocation);
    setState(() {});
  }

  // void fetchPolylinePoints2() async {
  //   polylineCoordinates2 = await getPolylinePoints(drop1, customerLocation);
  //   setState(() {});
  // }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color.fromRGBO(242, 242, 242, 1),
        body: Stack(
          children: [
            GoogleMap(
              onMapCreated: (controller) {
                setState(() {
                  mapController = controller;
                });
              },
              initialCameraPosition: CameraPosition(
                target: caemraPoint,
                zoom: 15.0,
              ),
              markers: {
                Marker(
                  markerId: MarkerId('DeliveryBoyMarker'),
                  position: deliveryBoyLocation,
                  icon: BitmapDescriptor.defaultMarker,
                ),
                //  Marker(
                //   markerId: MarkerId('drop1'),
                //   position: drop1,
                //   icon: BitmapDescriptor.defaultMarker,
                // ),
                Marker(
                  markerId: MarkerId('DeliveryLocationMarker'),
                  position: customerLocation,
                  icon: BitmapDescriptor.defaultMarkerWithHue(
                      BitmapDescriptor.hueYellow),
                  infoWindow: InfoWindow(title: 'Delivery Location'),
                ),
              },
              polylines: {
                Polyline(
                  polylineId: PolylineId('route1'),
                  color: Colors.blue,
                  width: 5,
                  points: polylineCoordinates,
                ),
                // Polyline(
                //   polylineId: PolylineId('route2'),
                //   color: Colors.blue,
                //   width: 5,
                //   points: polylineCoordinates2,
                // ),
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
            //       SizedBox(
            //         height: Get.height * 0.005,
            //       ),
            //     ],
            //   ),
            // )),
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
                  height: Get.height * 0.28,
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
                      // SizedBox(
                      //   height: Get.height * 0.01,
                      // ),
                      // Container(
                      //   height: Get.height * 0.09,
                      //   width: Get.width * 0.8,
                      //   decoration: BoxDecoration(
                      //       color: Color.fromRGBO(214, 51, 72, 0.08),
                      //       borderRadius: BorderRadius.all(Radius.circular(20))),
                      //   child: Row(
                      //     children: [
                      //       SizedBox(
                      //         width: Get.width * 0.03,
                      //       ),
                      //       CircleAvatar(
                      //         radius: Get.width * 0.06,
                      //         backgroundImage: NetworkImage(
                      //             "https://t4.ftcdn.net/jpg/03/64/21/11/360_F_364211147_1qgLVxv1Tcq0Ohz3FawUfrtONzz8nq3e.jpg"),
                      //         backgroundColor: Colors.transparent,
                      //       ),
                      //       SizedBox(
                      //         width: Get.width * 0.04,
                      //       ),
                      //       Column(
                      //         crossAxisAlignment: CrossAxisAlignment.start,
                      //         children: [
                      //           SizedBox(
                      //             height: Get.height * 0.02,
                      //           ),
                      //           Text(
                      //             'Philippe Troussier',
                      //             style: TextStyle(
                      //               fontSize: 14,
                      //               fontWeight: FontWeight.w700,
                      //               fontFamily: 'Poppins',
                      //             ),
                      //           ),
                      //           SizedBox(
                      //             height: Get.height * 0.005,
                      //           ),
                      //           Text(
                      //             '0145425765',
                      //             style: TextStyle(
                      //                 fontSize: 14,
                      //                 fontWeight: FontWeight.w400,
                      //                 fontFamily: 'Poppins',
                      //                 color: Color.fromRGBO(119, 119, 119, 1)),
                      //           ),
                      //         ],
                      //       ),
                      //       SizedBox(
                      //         width: Get.width * 0.045,
                      //       ),
                      //       Container(
                      //           height: Get.height * 0.06,
                      //           width: Get.width * 0.1,
                      //           decoration: BoxDecoration(
                      //               shape: BoxShape.circle,
                      //               color: AppColor.primaryColor),
                      //           child: Icon(
                      //             Icons.call,
                      //             size: 25,
                      //             color: Colors.white,
                      //           )),
                      //       SizedBox(
                      //         width: Get.width * 0.01,
                      //       ),
                      //       Container(
                      //           height: Get.height * 0.06,
                      //           width: Get.width * 0.1,
                      //           decoration: BoxDecoration(
                      //               shape: BoxShape.circle,
                      //               color: Color.fromRGBO(9, 64, 94, 1)),
                      //           child: Icon(
                      //             Icons.message,
                      //             size: 22,
                      //             color: Colors.white,
                      //           )),
                      //     ],
                      //   ),
                      // )
                      SizedBox(
                        height: Get.height * 0.025,
                      ),
                      GestureDetector(
                        onTap: () {
                          Get.to(() => CustomerTrackScreen());
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
                        height: Get.height * 0.01,
                      ),
                    ],
                  ),
                ))
          ],
        ),
      ),
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
