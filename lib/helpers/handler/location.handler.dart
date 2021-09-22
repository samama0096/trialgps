import 'package:geolocator/geolocator.dart';
import 'package:trialgps/helpers/handler/permission.handler.dart';

class LocationHandler {
  getLocation() async {
    final location = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.medium);

    return location;
  }
}
