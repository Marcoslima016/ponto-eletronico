import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../lib.imports.dart';

class HorarioBatida extends StatelessWidget {
  int itemIndex;
  List<Batida> batidasList;

  HorarioBatida({
    @required this.itemIndex,
    @required this.batidasList,
  });

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height / 100;
    double w = MediaQuery.of(context).size.width / 100;
    Batida itemBatida = batidasList[itemIndex];
    return Text(
      itemBatida.hr,
      style: TextStyle(
        fontSize: h * 2.8,
        fontWeight: FontWeight.w500,
        color: Colors.grey,
      ),
      textAlign: TextAlign.right,
    );
    // return Obx(
    //   () {
    //     Batida itemBatida = batidasList[itemIndex];
    //     return Text(
    //       itemBatida.hr,
    //       style: TextStyle(
    //         fontSize: h * 2.8,
    //         fontWeight: FontWeight.w500,
    //         color: Colors.grey,
    //       ),
    //       textAlign: TextAlign.right,
    //     );
    //   },
    // );
  }
}
