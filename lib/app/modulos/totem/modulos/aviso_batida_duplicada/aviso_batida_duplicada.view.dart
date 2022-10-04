import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AvisoBatidaDuplicada extends StatelessWidget {
  var context;
  AvisoBatidaDuplicada() {
    Future.delayed(const Duration(milliseconds: 5300), () {
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
      backgroundColor: Colors.white,
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
                Icons.warning_rounded,
                color: Colors.yellow[600],
                size: h * 16,
              ),
              Padding(
                padding: EdgeInsets.only(top: h * 7, left: w * 6, right: w * 6),
                child: Text(
                  "BATIDA DUPLICADA",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 35,
                    height: 1.4,
                    color: Colors.grey[900],
                    // fontFamily: "Open Sans",
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: h * 5, left: w * 6, right: w * 6),
                child: Text(
                  "Ja foi realizada uma batida nesse horário. A nova batida não será contabilizada",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.grey[600],
                    // fontFamily: "Open Sans",
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ),
              SizedBox(
                height: h * 6,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
