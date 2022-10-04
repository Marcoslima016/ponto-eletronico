import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../lib.imports.dart';

class IndicadorOffline extends StatelessWidget {
  int itemIndex;
  List<Batida> batidasList;

  IndicadorOffline({
    @required this.itemIndex,
    @required this.batidasList,
  });
  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height / 100;
    double w = MediaQuery.of(context).size.width / 100;

    Batida itemBatida = batidasList[itemIndex];
    if (itemBatida.tipo == TipoBatida.offline) {
      return Container(
        margin: EdgeInsets.only(left: 8),
        padding: EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: Colors.yellow[50],
          borderRadius: BorderRadius.all(Radius.circular(3)),
        ),
        child: Row(
          children: [
            Icon(
              Icons.wifi_off_outlined,
              color: Colors.grey[500],
              size: h * 2.5,
            ),
            SizedBox(width: 3),
            Text(
              "OFFLINE",
              style: TextStyle(
                color: Colors.grey[500],
                fontSize: h * 1.7,
              ),
            ),
          ],
        ),
      );
    } else {
      return Container();
    }
  }
}
