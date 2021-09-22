import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class ApiService {
  Future<int> postLocation(String device, String lat, String long) async {
    Uri url = Uri.parse(
        'https://trialapilocales.herokuapp.com/post/save/$device/$lat/$long');
    http.Response res = await http.post(url);
    return res.statusCode;
  }
}
