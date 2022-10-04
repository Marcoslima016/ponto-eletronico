import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import '../lib.imports.dart';
import '../app.imports.dart';
import 'app.controller.dart';

class App extends StatelessWidget {
  String initialRoute;

  // AppController appController = AppController.instance;

  static Widget _appCache;

  App(this.initialRoute) {}

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height / 100;
    double w = MediaQuery.of(context).size.width / 100;
    if (_appCache == null) _appCache = _buildApp(initialRoute);
    return _appCache;
  }

  static Widget _buildApp(String initialRoute) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      // theme: ThemeData(
      //   // brightness: Brightness.dark,
      //   // primarySwatch: customBlue,
      //   primarySwatch: Colors.blue,
      //   primaryColor: Colors.blue,
      // ),
      initialRoute: initialRoute,
      // home: LoginView(),
      getPages: AppRoutes.routes,
      // initialBinding: AppBinding(),
    );
  }
}
