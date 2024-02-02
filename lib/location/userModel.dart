import 'package:peschef_delivery/location/locationModel.dart';

class User {
  final String name;
  final Location location;

  User({
    required this.name,
    required this.location,
  });

  // Define the fromMap method to convert Firestore data to a User object
  factory User.fromMap(Map<String, dynamic> map) {
    final locationMap = map['location'] as Map<String, dynamic>;
    final location = Location(
      lat: locationMap['lat'] as double,
      lng: locationMap['lng'] as double,
    );

    return User(
      name: map['name'] as String,
      location: location,
    );
  }
}
