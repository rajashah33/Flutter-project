import 'package:flutter/material.dart';
// import 'package:new_login/Model/loginModel.dart';
import 'package:new_login/service_locator.dart';
import 'package:new_login/ui/home_view.dart';
import 'package:scoped_model/scoped_model.dart';

void main() {
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeView(),
    );
  }
}
