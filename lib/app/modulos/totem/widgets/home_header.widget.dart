import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

import '../../../../lib.imports.dart';
import '../totem.imports.dart';

AppBar homeHeader() {
  final w = MediaQuery.of(Get.context).size.width / 100;
  final h = MediaQuery.of(Get.context).size.height / 100;
  return AppBar(
    // backgroundColor: TotemStyle().primaryColor,
    backgroundColor: Colors.black.withOpacity(0.2),
    elevation: 0,
    centerTitle: true,

    //--------------------- INDICADOR QTD BATIDAS NA FILA ---------------------

    leading: Container(
      width: h * 6.5,
      height: h * 6.5,
      margin: EdgeInsets.only(left: w * 5.2),
      decoration: BoxDecoration(
        // color: Color(0xFF01518e).withOpacity(1.0),
        color: Color(0xFF01518e).withOpacity(1.0),
        shape: BoxShape.circle,
      ),
      child: Obx(() {
        return Container(
          width: h * 6.5,
          height: h * 6.5,
          child: Stack(
            children: [
              Center(
                child: Container(
                  width: h * 6.5,
                  height: h * 6.5,
                  child: Center(
                    child: Text(
                      TotemController.instance.listaBatidas.length.toString(),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
              Center(
                child: TotemController.instance.listaBatidas.length > 0
                    ? SpinKitDualRing(
                        color: Colors.white,
                        lineWidth: 3.6,
                        size: h * 4.2,
                      )
                    : Container(),
              ),
            ],
          ),
        );
      }),
    ),
    //
    //------------------------------ BOTAO CONFIG ------------------------------
    //
    actions: [
      //BOTAO MENU/CONFIG
      Padding(
        padding: EdgeInsets.only(right: w * 5.2),
        child: GestureDetector(
          onTap: () {
            Get.to(MenuView());
          },
          child: Icon(Icons.settings, color: Colors.white),
        ),
      ),
    ],
    //----------------------------------- TIMER -----------------------------------
    // title: Obx(() {
    //   return Text(
    //     // controller.time.value,
    //     "00:00",
    //     style: TextStyle(
    //       color: Colors.white,
    //       fontSize: 36.sp,
    //     ),
    //   );
    // }),
  );
}
