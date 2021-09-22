import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:trialgps/helpers/handler/location.handler.dart';
import 'package:trialgps/helpers/handler/permission.handler.dart';
import 'package:trialgps/helpers/services/api.services.dart';

class HomeView extends StatefulWidget {
  HomeView({Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  LocationHandler locationHandler = LocationHandler();
  PermissionHandler permissionHandler = PermissionHandler();
  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  ApiService apiService = ApiService();
  Position? _location;
  String deviceName = "";
  getDeviceInfo() async {
    AndroidDeviceInfo info = await deviceInfo.androidInfo;
    setState(() {
      deviceName = info.product;
    });
  }

  getLocation() async {
    await permissionHandler.getPermission();
    final location = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.medium);
    setState(() {
      _location = location;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getLocation();
    getDeviceInfo();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              title: Text(" My Current Location!"),
            ),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("My Location is:"),
                  SizedBox(height: 30),
                  Text("${_location}"),
                  Text("My Device: $deviceName "),
                  SizedBox(height: 30),
                  IconButton(
                      onPressed: () async {
                        int response = await apiService.postLocation(
                            deviceName,
                            _location!.latitude.toString(),
                            _location!.longitude.toString());
                        if (response == 200) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              backgroundColor: Colors.greenAccent,
                              content: Text("Published!")));
                        } else if (response == 500) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              backgroundColor: Colors.redAccent,
                              content: Text("Database error occured!")));
                        }
                      },
                      icon: Icon(Icons.post_add))
                ],
              ),
            )));
  }
}
