import 'dart:async';
import 'package:flutter/material.dart';
import 'app/presentation/app.view.dart';
import 'lib.imports.dart';
import 'package:get/get.dart';

void main() async {
  //
  WidgetsFlutterBinding.ensureInitialized();

  String initialRoute = AppRoutes.HOME;
  runApp(
    MainWidget(initialRoute),
  );
}

class MainWidget extends StatelessWidget {
  String initialRoute;
  MainWidget(this.initialRoute);
  static Widget _appCache;

  @override
  Widget build(BuildContext context) {
    if (_appCache == null) _appCache = _buildApp(initialRoute);
    return _appCache;
  }

  static Widget _buildApp(String initialRoute) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: App(initialRoute),
    );
  }
}
