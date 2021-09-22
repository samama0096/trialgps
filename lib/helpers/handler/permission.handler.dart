import 'package:geolocator/geolocator.dart';

class PermissionHandler {
  getPermission() async {
    LocationPermission isGranted = await Geolocator.checkPermission();
    if (isGranted == LocationPermission.denied) {
      isGranted = await Geolocator.requestPermission();
      if (isGranted == LocationPermission.denied) {
        return;
      }
    } else {
      return true;
    }
  }
}
