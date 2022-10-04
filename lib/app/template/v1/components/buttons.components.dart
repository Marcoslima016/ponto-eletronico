import 'package:custom_app/lib.imports.dart';
import 'package:custom_components/buttons/buttons.imports.dart';
import 'package:flutter/material.dart';

import '../../../../lib.imports.dart';

class Buttons extends ButtonsComponents {
  double componentsWidth = 82;

  ///[======================================== PRIMARY ========================================]

  @override
  Widget primary({String text, Function onClick, TextPreferences textPreferences}) {
    double w = AppController.instance.deviceInfo.screenInfo.width;
    double h = AppController.instance.deviceInfo.screenInfo.height;

    return ButtonRounded(
      preferences: ButtonsPreferences(
        textPreferences: TextPreferences(
          size: h * 2.2,
          fontFamily: "OpenSans",
          // fontFamily: "NunitoBlack",
          fontWeight: FontWeight.w800,
        ),
        width: AppController.instance.deviceInfo.screenInfo.width * componentsWidth,
        height: AppController.instance.deviceInfo.screenInfo.height * 8.9,
        text: text,
        bgColor: Style().colors.primary,
        borderRadius: AppController.instance.deviceInfo.screenInfo.width * 2.6,
        onClick: onClick,
      ),
    );
  }

  // ///[======================================== SECONDARY ========================================]

  // @override
  // Widget secondary({String text, Function onClick}) {
  //   double w = AppController.instance.deviceInfo.screenInfo.width;
  //   double h = AppController.instance.deviceInfo.screenInfo.height;

  //   return ButtonRounded(
  //     preferences: ButtonsPreferences(
  //       textPreferences: TextPreferences(
  //         size: h * 3.4,
  //         textColor: Colors.grey[300],
  //         // textColor: Style().colors.bg1,
  //       ),
  //       width: AppController.instance.deviceInfo.screenInfo.width * componentsWidth,
  //       // height: AppController.instance.deviceInfo.screenInfo.height * 10,
  //       height: 88,
  //       text: text,
  //       // bgColor: Color.fromRGBO(29, 48, 91, 1),
  //       bgColor: Style().colors.primary,
  //       borderRadius: AppController.instance.deviceInfo.screenInfo.width * 2.2,
  //       onClick: onClick,
  //       // onClick: () {
  //       //   var point;
  //       // },
  //     ),
  //   );
  // }
}
