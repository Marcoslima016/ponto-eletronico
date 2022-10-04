import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../lib.imports.dart';

class LocalBatida extends StatelessWidget {
  int itemIndex;
  List<Batida> batidasList;

  LocalBatida({
    @required this.itemIndex,
    @required this.batidasList,
  });

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height / 100;
    double w = MediaQuery.of(context).size.width / 100;

    String finalTxt = "";
    Batida itemBatida = batidasList[itemIndex];
    if (itemBatida.localBatida != null) finalTxt = itemBatida.localBatida;
    if (itemBatida.localBatida == null) finalTxt = "Local não cadastrado";

    return Padding(
      padding: EdgeInsets.only(top: h * 2.1),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(Icons.location_on, size: h * 2.5, color: Colors.grey[300]),
          SizedBox(width: w * 0.4),
          Text(
            finalTxt,
            style: TextStyle(
              fontSize: h * 2,
              fontWeight: FontWeight.w500,
              color: Colors.grey[400],
            ),
            textAlign: TextAlign.left,
          ),
        ],
      ),
    );
  }
}
