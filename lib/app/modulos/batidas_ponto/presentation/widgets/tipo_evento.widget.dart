import 'package:custom_app/lib.imports.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../lib.imports.dart';

class TipoDeEvento extends StatelessWidget {
  int itemIndex;

  List<Batida> batidasList;

  TipoDeEvento({
    @required this.itemIndex,
    @required this.batidasList,
  });

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height / 100;
    double w = MediaQuery.of(context).size.width / 100;

    Icon finalIcon;

    var newIndex = itemIndex % 2 == 0 ? (((itemIndex + 1) / 2) + 0.5).toInt() : (((itemIndex) / 2) + 0.5).toInt();
    newIndex = newIndex == 0 ? 1 : newIndex;

    if (itemIndex % 2 == 0) {
      finalIcon = Icon(
        Icons.exit_to_app,
        // size: h * 5.6,
        // size: h * 6,
        size: h * 4,
        color: CustomAppConfig.instance.appController.style.colors.primary,
      );
    } else {
      finalIcon = Icon(
        Icons.exit_to_app,
        // size: h * 5.6,
        // size: h * 6,
        size: h * 4,
        color: Colors.red[700],
      );
    }

    Batida itemBatida = batidasList[itemIndex];
    return Padding(
      padding: EdgeInsets.only(
        // right: 12,
        right: 5,
      ),
      child: finalIcon,
    );

    // return Obx(
    //   () {
    //     Batida itemBatida = batidasList[itemIndex];
    //     return Padding(
    //       padding: EdgeInsets.only(
    //         // right: 12,
    //         right: 5,
    //       ),
    //       child: finalIcon,
    //     );
    //   },
    // );
  }
}
