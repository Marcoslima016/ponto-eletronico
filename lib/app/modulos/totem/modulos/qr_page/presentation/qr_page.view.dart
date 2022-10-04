import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../lib.imports.dart';
import '../../../../../app.imports.dart';
import 'presentation.imports.dart';

class QrPageView extends StatelessWidget {
  CameraFacing cameraPosition;

  QrPageController controller = QrPageController();

  QrPageView({this.cameraPosition}) {
    if (cameraPosition == null) cameraPosition = CameraFacing.front;
    controller.cameraPosition = cameraPosition;
  }

  @override
  Widget build(BuildContext context) {
    print("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
    double h = MediaQuery.of(context).size.height / 100;
    double w = MediaQuery.of(context).size.width / 100;

    return FutureBuilder(
      future: controller.init(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
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
                Padding(
                  padding: EdgeInsets.only(right: w * 3.2),
                  child: GestureDetector(
                    onTap: () {
                      controller.changeCameraPosition();
                    },
                    child: Icon(Icons.change_circle, color: Colors.white),
                  ),
                ),

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

                      ///----------------------------- QR VIEW -----------------------------

                      // Container(
                      //   // width: w * 90,
                      //   height: h * 64,
                      //   margin: EdgeInsets.only(left: w * 5.2, right: w * 5.2, top: h * 2),
                      //   color: Colors.grey[200],
                      // ),
                      Container(
                        // width: w * 90,
                        height: h * 64,
                        margin: EdgeInsets.only(left: w * 5.2, right: w * 5.2, top: h * 2),
                        decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(15))),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Obx(
                            () {
                              return Container(
                                child: QRView(
                                  cameraFacing: cameraPosition,
                                  key: controller.qrKey,
                                  onQRViewCreated: controller.onQRViewCreated,
                                  overlay: QrScannerOverlayShape(
                                    borderColor: controller.qrDetected.value ? Colors.green : Colors.red,
                                    borderRadius: 10,
                                    borderLength: 35,
                                    borderWidth: 10,
                                    // cutOutSize: 300,
                                    cutOutSize: w * 65,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),

                      ///----------------------- BOTAO "ESTOU SEM QR" -----------------------

                      GestureDetector(
                        onTap: () {
                          controller.onTapEstouSemCodigoQR();
                        },
                        child: Container(
                          // width: w * 90,
                          height: h * 10.4,
                          margin: EdgeInsets.only(left: w * 5.2, right: w * 5.2, top: h * 5),

                          decoration: BoxDecoration(
                            color: Color(0xFF01518e).withOpacity(1.0),
                            boxShadow: [
                              //BOX SHADOW
                              BoxShadow(
                                // color: Colors.grey[700].withOpacity(1.0),
                                color: Color(0xFF002b4c).withOpacity(0.52),
                                spreadRadius: 0.3,
                                blurRadius: 3.4,
                                offset: Offset(0, 0), // changes position of shadow
                              ),
                            ],
                            //BORDER RADIUS
                            borderRadius: BorderRadius.all(Radius.circular(6)),
                          ),
                          child: Center(
                            child: Text(
                              "Estou sem o código QR",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20.sp,
                              ),
                            ),
                          ),
                        ),
                      ),
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
