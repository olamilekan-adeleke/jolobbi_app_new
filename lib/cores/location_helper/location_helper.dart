import 'package:geolocator/geolocator.dart';

class LocationHelper {
  Future<Position?> getUserCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw Exception('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw Exception('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      throw Exception(
        'Location permissions are permanently denied, we cannot request permissions.',
      );
    }

    final Position position = await Geolocator.getCurrentPosition();

    // LoggerHelper.log("${position.latitude} ${position.longitude}");

    return position;
  }

  Future<double> getDistanceFromLatLonInKm(double lat, double lon) async {
    final Position? data = await getUserCurrentLocation();

    if (data?.latitude == null && data?.longitude == null) return 0;

    double distanceInMeters = Geolocator.distanceBetween(
      data?.latitude ?? 0,
      data?.longitude ?? 0,
      lat,
      lon,
    );

    return distanceInMeters / 1000;
  }
}
