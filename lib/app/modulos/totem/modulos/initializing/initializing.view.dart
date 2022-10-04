import 'package:flutter/material.dart';
import 'package:flutter_screenutil/size_extension.dart';

import '../../../../../lib.imports.dart';
import '../../../../app.imports.dart';

class InitializingView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height / 100;
    double w = MediaQuery.of(context).size.width / 100;

    return Scaffold(
      backgroundColor: TotemStyle().primaryColor,
      body: Container(
        width: w * 100,
        height: h * 100,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: w * 88,
              child: Image.asset("assets/assets_ptem2/images/logo_white.png"),
            ),
            SizedBox(
              height: h * 8,
            ),
            Text(
              "Inicializando o Totem",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 26.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
