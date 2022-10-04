import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ConfirmaBatidaView extends StatelessWidget {
  String dthr;
  String nome;
  var context;
  ConfirmaBatidaView({
    this.dthr,
    this.nome,
  }) {
    if (dthr == null) dthr = "24/03/2022 12:14";
    if (nome == null) nome = "Marcos";
    Future.delayed(const Duration(milliseconds: 4200), () {
      // GetIt.I<TotemController>().navigate(route: '/qrcodescan');

      // Navigator.pushReplacement(
      //   Get.context,
      //   PageRouteBuilder(
      //     pageBuilder: (c, a1, a2) => QrCodeScanView(args: ModalRoute.of(context).settings.arguments),
      //     transitionsBuilder: (c, anim, a2, child) => FadeTransition(opacity: anim, child: child),
      //     transitionDuration: Duration(milliseconds: 900),
      //   ),
      // );

      Get.back();
    });
  }
  @override
  Widget build(BuildContext context) {
    this.context = context;
    double h = MediaQuery.of(context).size.height / 100;
    double w = MediaQuery.of(context).size.width / 100;

    return Scaffold(
      // backgroundColor: Theme.of(context).accentColor,
      backgroundColor: Color(0xFF01579B),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5),
        child: Container(
          width: w * 100,
          height: h * 100,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: h * 8,
              ),
              Icon(
                Icons.check_circle_outline,
                color: Colors.grey[350],
                size: h * 18,
              ),
              Padding(
                padding: EdgeInsets.only(top: h * 7, left: w * 6, right: w * 6),
                child: Text(
                  "PONTO REGISTRADO COM SUCESSO",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 35,
                    height: 1.4,
                    color: Colors.white,
                    fontFamily: "Open Sans",
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: h * 5),
                child: Text(
                  dthr,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 22,
                    color: Colors.grey[350],
                    fontFamily: "Open Sans",
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: h * 15),
                child: Text(
                  "Bem vindo(a), " + nome,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.grey[200],
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
