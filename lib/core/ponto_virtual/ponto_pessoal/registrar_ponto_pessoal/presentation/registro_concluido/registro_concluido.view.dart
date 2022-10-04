import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../../lib.imports.dart';

class RegistroConcluido extends StatelessWidget {
  // RegistrandoBatidaController controller = RegistrandoBatidaController();

  double w;
  double h;

  @override
  Widget build(BuildContext context) {
    h = MediaQuery.of(context).size.height / 100;
    w = MediaQuery.of(context).size.width / 100;
    // controller.viewContext = context;

    Future.delayed(const Duration(milliseconds: 4500), () {
      Get.back();
      // Get.back();
    });

    return Scaffold(
      backgroundColor: AppController.instance.style.colors.primary,
      body: Container(
        width: w * 100,
        height: h * 100,
        padding: EdgeInsets.only(left: w * 10, right: w * 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.check_circle_outline,
              color: Colors.grey[350],
              size: h * 18,
            ),
            SizedBox(height: h * 7),
            Text(
              "PONTO REGISTRADO",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 46.sp,
                fontFamily: 'Montserrat',
                // fontFamily: "OpenSans",
              ),
            ),
          ],
        ),
      ),
      // body: FutureBuilder(
      //   future: controller.loadView(),
      //   builder: (context, snapshot) {
      //     if (snapshot.hasData) {

      //     } else {

      //     }
      //   },
      // ),
    );
  }
}
