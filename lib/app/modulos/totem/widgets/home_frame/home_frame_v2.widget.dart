import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

import '../../../../../lib.imports.dart';
import 'home_frame.controller.dart';

Widget homeFrameV2(Widget child) {
  return HomeFrameV2(
    child: child,
  );
}

class HomeFrameV2 extends StatelessWidget {
  HomeFrameController controller = HomeFrameController();
  Widget child;

  HomeFrameV2({
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
          double totalHeight = h * 100;
          double topHeight = AppBar().preferredSize.height + Get.statusBarHeight;
          double statusBarHeight = Get.statusBarHeight;
          double appbarHeight = AppBar().preferredSize.height;
          double v1 = h * 3;
          double safeHeight = (totalHeight - AppBar().preferredSize.height);

          var p = "";

          return Scaffold(
            backgroundColor: Colors.white,
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(h * 3), // here the desired height
              child: AppBar(
                systemOverlayStyle: SystemUiOverlayStyle(
                  // statusBarColor: Colors.green, // <-- SEE HERE
                  statusBarIconBrightness: Brightness.light, //<-- For Android SEE HERE (light icons)
                  // statusBarBrightness: Brightness.light, //<-- For iOS SEE HERE (light icons)
                  statusBarBrightness: Brightness.dark, //<-- For iOS SEE HERE (light icons)
                ),
                backgroundColor: Colors.black,
                leading: Container(),
                actions: [],
              ),
            ),
            body: Container(
              width: w * 100,
              child: Stack(
                children: [
                  Container(width: w * 100, height: h * 100),
                  //

                  ///=========================================== BODY ===========================================

                  Column(
                    children: [
                      // SizedBox(height: h * 4),

                      ///----------------------------- CHILD -----------------------------

                      Container(
                        // height: h * 64,
                        height: safeHeight,
                        // margin: EdgeInsets.only(left: w * 4.8, right: w * 4.8, top: h * 0.2),
                        decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(7))),
                        child: child,
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

                  ///============================================= HEADER =============================================

                  Container(
                    width: w * 100,
                    height: h * 9,
                    // color: Colors.red,
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.55),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        //
                        //------------- LOGO ------------
                        Padding(
                          padding: EdgeInsets.only(left: w * 1.4),
                          child: Container(
                            width: w * 16,
                            child: Image.asset("assets/assets_ptem2/images/logoapp.png"),
                          ),
                        ),

                        Row(
                          children: [
                            //
                            //------------- TIMER ------------

                            Obx(() {
                              return Padding(
                                padding: EdgeInsets.only(right: w * 2.4),
                                child: Text(
                                  controller.time.value,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 57.sp,
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
                              );
                            }),

                            Padding(
                              padding: EdgeInsets.only(right: w * 1.8),
                              child: Container(
                                height: h * 100,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    //------------- BTN CONFIG ------------
                                    GestureDetector(
                                      onTap: () {
                                        Get.off(MenuView());
                                      },
                                      child: Icon(Icons.settings, color: Colors.white),
                                    ),

                                    //------------- QTD BATIDAS ------------

                                    Container(
                                      width: h * 3,
                                      height: h * 3,
                                      margin: EdgeInsets.only(top: h * 0.82),
                                      decoration: BoxDecoration(
                                        // color: Color(0xFF01518e).withOpacity(1.0),
                                        color: Colors.white.withOpacity(0.2),
                                        shape: BoxShape.circle,
                                      ),
                                      child: Obx(() {
                                        return Container(
                                          width: h * 3,
                                          height: h * 3,
                                          child: Stack(
                                            children: [
                                              Center(
                                                child: Container(
                                                  width: h * 3,
                                                  height: h * 3,
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
                                                        lineWidth: 3.2,
                                                        size: h * 3.2,
                                                      )
                                                    : Container(),
                                              ),
                                            ],
                                          ),
                                        );
                                      }),
                                    ),
                                    SizedBox(height: h * 0.3),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  ///============================================= APP BAR =============================================

                  // Positioned(
                  //   top: 0,
                  //   child: PreferredSize(
                  //     preferredSize: Size.fromHeight(h * 15), // here the desired height
                  //     child: AppBar(
                  //       backgroundColor: Colors.black.withOpacity(0.3),
                  //       elevation: 0,
                  //       centerTitle: true,

                  //       //--------------------- INDICADOR QTD BATIDAS NA FILA ---------------------

                  //       leading: Container(
                  //         width: h * 6.5,
                  //         height: h * 6.5,
                  //         margin: EdgeInsets.only(left: w * 5.2),
                  //         decoration: BoxDecoration(
                  //           // color: Color(0xFF01518e).withOpacity(1.0),
                  //           color: Colors.transparent,
                  //           shape: BoxShape.circle,
                  //         ),
                  //         child: Obx(() {
                  //           return Container(
                  //             width: h * 6.5,
                  //             height: h * 6.5,
                  //             child: Stack(
                  //               children: [
                  //                 Center(
                  //                   child: Container(
                  //                     width: h * 6.5,
                  //                     height: h * 6.5,
                  //                     child: Center(
                  //                       child: Text(
                  //                         TotemController.instance.listaBatidas.length.toString(),
                  //                         textAlign: TextAlign.center,
                  //                       ),
                  //                     ),
                  //                   ),
                  //                 ),
                  //                 Center(
                  //                   child: TotemController.instance.listaBatidas.length > 0
                  //                       ? SpinKitDualRing(
                  //                           color: Colors.white,
                  //                           lineWidth: 3.6,
                  //                           size: h * 4.2,
                  //                         )
                  //                       : Container(),
                  //                 ),
                  //               ],
                  //             ),
                  //           );
                  //         }),
                  //       ),
                  //       //
                  //       //------------------------------ BOTAO CONFIG ------------------------------
                  //       //
                  //       actions: [
                  //         //BOTAO MENU/CONFIG
                  //         Padding(
                  //           padding: EdgeInsets.only(right: w * 5.2),
                  //           child: GestureDetector(
                  //             onTap: () {
                  //               Get.to(MenuView());
                  //             },
                  //             child: Icon(Icons.settings, color: Colors.white),
                  //           ),
                  //         ),
                  //       ],
                  //       //----------------------------------- TIMER -----------------------------------
                  //       title: Obx(() {
                  //         return Text(
                  //           controller.time.value,
                  //           style: TextStyle(
                  //             color: Colors.white,
                  //             fontSize: 36.sp,
                  //           ),
                  //         );
                  //       }),
                  //     ),
                  //   ),
                  // ),

                  ///============================ FOOT ============================
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
