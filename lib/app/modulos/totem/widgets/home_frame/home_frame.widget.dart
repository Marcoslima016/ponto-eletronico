import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

import '../../../../../lib.imports.dart';
import 'home_frame.controller.dart';

Widget homeFrame(Widget child) {
  return HomeFrame(
    child: child,
  );
}

class HomeFrame extends StatelessWidget {
  HomeFrameController controller = HomeFrameController();
  Widget child;

  HomeFrame({
    @required this.child,
  });

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height / 100;
    double w = MediaQuery.of(context).size.width / 100;

    return FutureBuilder(
      future: controller.init(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          double t1 = Get.statusBarHeight;

          double totalHeight = h * 100;
          double appBarHeight = AppBar().preferredSize.height;
          double topHeight = AppBar().preferredSize.height + Get.statusBarHeight;
          double bodyheight = totalHeight - topHeight;
          double safeHeight = bodyheight - (h * 0.02);
          var p = "";

          return Scaffold(
            backgroundColor: TotemStyle().primaryColor,
            appBar: AppBar(
              backgroundColor: TotemStyle().primaryColor,
              elevation: 0,
              centerTitle: true,

              //--------------------- INDICADOR QTD BATIDAS NA FILA ---------------------

              leading: Container(
                width: h * 6.5,
                height: h * 6.5,
                margin: EdgeInsets.only(left: w * 5.2),
                decoration: BoxDecoration(
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
              title: Obx(() {
                return Text(
                  controller.time.value,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 36.sp,
                  ),
                );
              }),
            ),
            body: Container(
              width: w * 100,
              child: Stack(
                children: [
                  Container(width: w * 100, height: h * 100),
                  //

                  Column(
                    children: [
                      // SizedBox(height: h * 4),

                      ///------------------------------- LOGO -------------------------------
                      ///
                      // Container(
                      //   width: w * 80,
                      //   child: Image.asset("assets/assets_ptem2/images/logo_white.png"),
                      // ),

                      ///----------------------------- CHILD -----------------------------

                      Container(
                        // height: h * 64,
                        height: safeHeight,
                        margin: EdgeInsets.only(left: w * 4.8, right: w * 4.8, top: h * 0.2),
                        decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(7))),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: child,
                        ),
                      ),

                      ///----------------------- BOTAO "ESTOU SEM QR" -----------------------

                      // GestureDetector(
                      //   onTap: () {
                      //     // controller.onTapEstouSemCodigoQR();
                      //   },
                      //   child: Container(
                      //     // width: w * 90,
                      //     height: h * 10.4,
                      //     margin: EdgeInsets.only(left: w * 5.2, right: w * 5.2, top: h * 5),

                      //     decoration: BoxDecoration(
                      //       color: Color(0xFF01518e).withOpacity(1.0),
                      //       boxShadow: [
                      //         //BOX SHADOW
                      //         BoxShadow(
                      //           // color: Colors.grey[700].withOpacity(1.0),
                      //           color: Color(0xFF002b4c).withOpacity(0.52),
                      //           spreadRadius: 0.3,
                      //           blurRadius: 3.4,
                      //           offset: Offset(0, 0), // changes position of shadow
                      //         ),
                      //       ],
                      //       //BORDER RADIUS
                      //       borderRadius: BorderRadius.all(Radius.circular(6)),
                      //     ),
                      //     child: Center(
                      //       child: Text(
                      //         "Estou sem o código QR",
                      //         style: TextStyle(
                      //           color: Colors.white,
                      //           fontSize: 20.sp,
                      //         ),
                      //       ),
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),

                  ///==== FOOT ====
                  // Positioned(
                  //   bottom: h * 6,
                  //   child: Container(
                  //     width: w * 100,
                  //     child: Column(
                  //       mainAxisAlignment: MainAxisAlignment.center,
                  //       crossAxisAlignment: CrossAxisAlignment.center,
                  //       children: [
                  //       ],
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }
}
