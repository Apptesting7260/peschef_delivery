import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class OrderTrackingPage extends StatefulWidget {
  const OrderTrackingPage({Key? key}) : super(key: key);
  @override
  State<OrderTrackingPage> createState() => OrderTrackingPageState();
}

class OrderTrackingPageState extends State<OrderTrackingPage> {
  final Completer<GoogleMapController> _controller = Completer();
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
    Location location = Location();
    location.getLocation().then(
      (location) {
        currentLocation = location;
        getPolyPoints();
      },
    );
    GoogleMapController googleMapController = await _controller.future;
    location.onLocationChanged.listen(
      (newLoc) {
        currentLocation = newLoc;
        print("chala${currentLocation}");
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

  BitmapDescriptor sourceIcon = BitmapDescriptor.defaultMarker;
  BitmapDescriptor destinationIcon = BitmapDescriptor.defaultMarker;
  BitmapDescriptor currentLocationIcon = BitmapDescriptor.defaultMarker;
  void setCustomMarkerIcon() {
    BitmapDescriptor.fromAssetImage(
            ImageConfiguration.empty, "assets/Pin_source.png")
        .then(
      (icon) {
        sourceIcon = icon;
      },
    );
    BitmapDescriptor.fromAssetImage(
            ImageConfiguration.empty, "assets/Pin_destination.png")
        .then(
      (icon) {
        destinationIcon = icon;
      },
    );
    BitmapDescriptor.fromAssetImage(
            ImageConfiguration.empty, "assets/Badge.png")
        .then(
      (icon) {
        currentLocationIcon = icon;
      },
    );
  }

  @override
  void initState() {
    // TODO: implement initState

    getCurrentLocation();
    setCustomMarkerIcon();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: currentLocation == null
          ? const Center(child: Text("Loading"))
          : GoogleMap(
              initialCameraPosition: CameraPosition(
                target: LatLng(
                    currentLocation!.latitude!, currentLocation!.longitude!),
                zoom: 13.5,
              ),
              markers: {
                Marker(
                  markerId: MarkerId("currentLocation"),
                  icon: currentLocationIcon,
                  position: LatLng(
                      currentLocation!.latitude!, currentLocation!.longitude!),
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
                  color: const Color(0xFF7B61FF),
                  width: 6,
                ),
              },
            ),
    );
  }
}
