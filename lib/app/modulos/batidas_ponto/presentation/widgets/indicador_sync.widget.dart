import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../lib.imports.dart';

class IndicadorSync extends StatelessWidget {
  int itemIndex;
  List<Batida> batidasList;

  IndicadorSync({
    @required this.itemIndex,
    @required this.batidasList,
  });

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height / 100;
    double w = MediaQuery.of(context).size.width / 100;

    Batida itemBatida = batidasList[itemIndex];

    if (itemBatida.syncStatus.value == SyncStatus.runningSync || itemBatida.syncStatus.value == SyncStatus.inQueue) {
      return Container(
        margin: EdgeInsets.only(top: h * 1.8, left: 3),
        child: Row(
          children: [
            Container(
              height: h * 1.6,
              width: h * 1.6,
              child: CircularProgressIndicator(
                strokeWidth: 1.8,
                backgroundColor: Colors.white,
                valueColor: AlwaysStoppedAnimation<Color>(AppController.instance.style.colors.primary),
              ),
            ),
            SizedBox(width: 6.5),
            Text(
              "Sincronizando",
              style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w500),
            ),
          ],
        ),
      );
    }
    return Container();
  }
}
