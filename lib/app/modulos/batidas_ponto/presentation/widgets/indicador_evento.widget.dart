import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../lib.imports.dart';

class EventoBatida extends StatelessWidget {
  int itemIndex;
  List<Batida> batidasList;

  EventoBatida({
    @required this.itemIndex,
    @required this.batidasList,
  });

  @override
  Widget build(BuildContext context) {
    String finalText = "";

    var newIndex = itemIndex % 2 == 0 ? (((itemIndex + 1) / 2) + 0.5).toInt() : (((itemIndex) / 2) + 0.5).toInt();
    newIndex = newIndex == 0 ? 1 : newIndex;

    if (itemIndex % 2 == 0) {
      finalText = '$newIndexª Entrada';
    } else {
      finalText = '$newIndexª Saída';
    }

    double h = MediaQuery.of(context).size.height / 100;
    double w = MediaQuery.of(context).size.width / 100;

    Batida itemBatida = batidasList[itemIndex];
    return Padding(
      padding: EdgeInsets.only(
        left: 1.2,
      ),
      child: Text(
        finalText,
        style: TextStyle(
          fontSize: h * 2.8,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
    // return Obx(
    //   () {
    //     Batida itemBatida = batidasList[itemIndex];
    //     return Padding(
    //       padding: EdgeInsets.only(
    //         left: 1.2,
    //       ),
    //       child: Text(
    //         finalText,
    //         style: TextStyle(
    //           fontSize: h * 2.8,
    //           fontWeight: FontWeight.w700,
    //         ),
    //       ),
    //     );
    //   },
    // );
  }
}
