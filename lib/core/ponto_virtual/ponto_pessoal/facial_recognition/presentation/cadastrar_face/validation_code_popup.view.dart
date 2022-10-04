import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'cadastrar_face.imports.dart';

class PopupValidationCode {
  double w;
  double h;

  PopupValidationCode() {}

  //====================================================== SHOW ======================================================

  Future<bool> show() async {
    return await showDialog(
      barrierDismissible: false,
      context: Get.context,
      builder: (BuildContext context) {
        h = MediaQuery.of(context).size.height / 100;
        w = MediaQuery.of(context).size.width / 100;

        return Dialog(
          insetPadding: EdgeInsets.zero,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          // contentPadding: EdgeInsets.zero,
          elevation: 0,
          backgroundColor: Colors.black.withOpacity(0.5),
          child: SingleChildScrollView(
            child: Container(
              child: Stack(
                children: [
                  ///[****************************** OUT TAP ****************************]
                  ///
                  GestureDetector(
                    onTap: () {
                      // Navigator.pop(context);
                    },
                    child: Container(
                      width: w * 100,
                      height: h * 100,
                      color: Colors.transparent,
                    ),
                  ),

                  ///[******************************** BODY ******************************]
                  ///
                  Container(
                    height: h*100,
                    child: ValidationCodePopupBody(),
                  ),
                  //
                ],
              ),
            ),
          ),
        );
      },
    ).then((val) {
      return val;
    });
  }

  // Widget body() {
  //   return Container(
  //     width: w * 100,
  //     child: Column(
  //       mainAxisAlignment: MainAxisAlignment.center,
  //       children: [
  //         Container(
  //           width: w * 85,
  //           // height: h * 30,
  //           padding: EdgeInsets.only(
  //             left: w * 4.4,
  //             right: w * 4.4,
  //             // top: 6,
  //             top: w * 4,
  //             bottom: w * 4,
  //           ),
  //           decoration: const BoxDecoration(
  //             color: Colors.white,
  //             borderRadius: BorderRadius.all(Radius.circular(10)),
  //           ),
  //           child: Column(
  //             crossAxisAlignment: CrossAxisAlignment.start,
  //             children: [
  //               Text(
  //                 "Alterar posição da câmera",
  //                 textAlign: TextAlign.center,
  //                 style: TextStyle(
  //                   fontWeight: FontWeight.w900,
  //                   fontSize: 21.sp,
  //                   color: Colors.grey[800],
  //                   fontFamily: "Nunito",
  //                 ),
  //               ),
  //               Text(
  //                 "Defina qual câmera será utilizada na batida de ponto.",
  //                 // textAlign: TextAlign.center,
  //                 style: TextStyle(
  //                   fontSize: 17.sp,
  //                   color: Colors.grey,
  //                   fontFamily: "Nunito",
  //                 ),
  //               ),
  //               //
  //               SizedBox(height: 20),
  //               //

  //               //
  //               SizedBox(height: 15),
  //             ],
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }
}
