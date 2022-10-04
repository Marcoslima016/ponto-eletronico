import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../lib.imports.dart';

class AppRoutes {
  ///* [ IMPLEMENTAR:  */  Implements MobEngineRoutes , RoutesManager (tem um metodo que cria a lista de rotas)
  //
  /* [------------ INITIAL ROUTE ------------ */

  static Future<String> get initialRoute async {
    // String initialRoute = await AppController.instance.setInitialRoute();
    // return initialRoute;
  }

  /* [-------- REFERENCIAS DAS ROTAS -------- */

  static const LOGIN = '/login';
  static const SIGNUP = '/signup';
  static const HOME = '/home';

  /* [---------------- ROTAS --------------- */

  static List<GetPage> routes = [
    // GetPage(
    //   name: HOME,
    //   page: () => HomeView(),
    // ),
  ];
}

class LoginViewTEste extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
