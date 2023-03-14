import 'package:geolocator/geolocator.dart';
import 'package:jolobbi_app_new/cores/utils/utils.dart';
import 'package:location/location.dart';

class LocationHelper {
  static final Location location = Location();

  Future<LocationData?> getUserCurrentLocation() async {
    bool serviceEnabled;
    PermissionStatus permissionGranted;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return null;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return null;
      }
    }

    final LocationData data = await location.getLocation();
    LoggerHelper.log(data.toString());
    return data;
  }

  Future<double> getDistanceFromLatLonInKm(double lat, double lon) async {
    final LocationData? data = await getUserCurrentLocation();

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
