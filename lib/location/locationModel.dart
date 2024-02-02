class Location {
  final double lat;
  final double lng;

  Location({
    required this.lat,
    required this.lng,
  });

  // Add an unnamed constructor to fix the issue
  Location.fromJson(Map<String, dynamic> json)
      : lat = json['lat'] as double,
        lng = json['lng'] as double;
}
