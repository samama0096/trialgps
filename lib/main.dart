import 'package:flutter/material.dart';
import 'package:trialgps/ui/home.ui.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: HomeView(),
  ));
}
