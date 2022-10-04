import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'popup_confirma_batida.body.dart';

class PopupConfirmaBatida {
  double w;
  double h;

  String dthr;
  String nome;

  PopupConfirmaBatida({
    @required this.dthr,
    @required this.nome,
  });

  //====================================================== SHOW ======================================================

  Future show() async {
    Future.delayed(const Duration(milliseconds: 4500), () {
      Get.back();
    });

    return await showDialog(
      barrierDismissible: true,
      context: Get.context,
      builder: (BuildContext context) {
        h = MediaQuery.of(context).size.height / 100;
        w = MediaQuery.of(context).size.width / 100;

        return Dialog(
          insetPadding: EdgeInsets.zero,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          // contentPadding: EdgeInsets.zero
          elevation: 0,
          backgroundColor: Colors.black.withOpacity(0.7),
          child: Container(
            child: Stack(
              children: [
                ///[****************** OUT TAP ****************]
                GestureDetector(
                  onTap: () {
                    // if (blocked == false) Navigator.pop(_dialogContext);
                  },
                  child: Container(
                    width: w * 100,
                    height: h * 100,
                    color: Colors.transparent,
                  ),
                ),

                ///[*******************************************]
                ///
                ///--- CONTAINER POPUP: ----

                PopupConfirmaBatidaBody(
                  dthr: dthr,
                  nome: nome,
                ),
              ],
            ),
          ),
        );
      },
    ).then((val) {
      // tapClose();
    });
  }
}
