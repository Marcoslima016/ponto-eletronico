import 'package:flutter/material.dart';
import 'package:flutter_screenutil/size_extension.dart';
import 'package:get/get.dart';
import 'package:ptem2/app/app.controller.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import '../../../../../../lib.imports.dart';
import '../activate.imports.dart';

class ActivateTotemView extends StatelessWidget {
  //
  ActivateTotemPageController controller;

  Future Function(String code) onReadCode;

  ActivateTotemView({
    @required this.onReadCode,
  }) {
    controller = ActivateTotemPageController(
      // onReadCode: onReadCode,
      onReadCode: onReadCode,
    );
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height / 100;
    double w = MediaQuery.of(context).size.width / 100;

    return Scaffold(
      backgroundColor: TotemStyle().primaryColor,
      body: Container(
        width: w * 100,
        child: Stack(
          children: [
            Container(width: w * 100, height: h * 100),
            //

            Column(
              children: [
                SizedBox(height: h * 4.8),

                ///------------------------------- LOGO -------------------------------
                ///
                Container(
                  width: w * 80,
                  child: Image.asset("assets/assets_ptem2/images/logo_white.png"),
                ),

                ///----------------------------- QR VIEW -----------------------------
                Container(
                  // margin: EdgeInsets.only(left: w * 4, right: w * 4, top: h * 2),
                  height: h * 54,
                  child: Stack(
                    children: [
                      Container(
                        // width: w * 90,
                        height: h * 54,
                        margin: EdgeInsets.only(left: w * 5.2, right: w * 5.2, top: h * 3),
                        decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(15))),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Obx(
                            () {
                              return Container(
                                child: QRView(
                                  cameraFacing: CameraFacing.back,
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
                      // Center(child: Text(""),)
                    ],
                  ),
                ),
              ],
            ),

            ///==== FOOT ====
            Positioned(
              bottom: h * 6,
              child: Container(
                width: w * 100,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ///---------------------------- BOTAO SAIR ----------------------------
                    ///
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: EdgeInsets.only(left: w * 4.8, right: w * 4.8, top: h * 2, bottom: h * 2),
                          decoration: BoxDecoration(
                            color: Color(0xFF01518e).withOpacity(1.0),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: GestureDetector(
                            onTap: () {
                              TotemController.instance.disconnectTotem();
                            },
                            child: Row(
                              children: [
                                Icon(
                                  Icons.exit_to_app,
                                  color: Colors.white,
                                ),
                                SizedBox(width: w * 2),
                                Text(
                                  "SAIR",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18.sp,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
