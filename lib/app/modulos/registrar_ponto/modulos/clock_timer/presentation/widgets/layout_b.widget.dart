import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../app.imports.dart';
import '../presentation.imports.dart';

class LayoutB extends StatelessWidget {
  ClockTimerController controller;
  LayoutB({
    @required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height / 100;
    var w = MediaQuery.of(context).size.width / 100;

    String finalTime = "";

    return Obx(() {
      String finalTime = "";

      String _timeApart = controller.timeWithFuso.split(" ")[0];
      var _timeSplit = _timeApart.split(":");

      // finalTime = _timeSplit[0] + " : " + _timeSplit[1] + " : " + _timeSplit[2];
      finalTime = _timeSplit[0] + " : " + _timeSplit[1];

      return Padding(
        padding: EdgeInsets.only(left: w * 6, right: w * 6),
        child: Container(
          width: w * 100,
          padding: EdgeInsets.only(top: h * 2.6, bottom: h * 2.6),
          decoration: BoxDecoration(
            color: AppController.instance.style.colors.primary.withOpacity(0.03),
            // border: Border.all(
            //   // color: Colors.grey[200],
            //   color: AppController.instance.style.colors.primary,
            //   width: 1,
            // ),
            borderRadius: BorderRadius.all(Radius.circular(5)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Icon(Icons.watch_later_outlined, size: h * 5.2, color: Colors.grey[300]),
              // SizedBox(width: w * 2),
              Text(
                finalTime,
                style: TextStyle(
                  // fontFamily: "NunitoBlack",
                  fontFamily: "OpenSans",
                  fontSize: h * 7,
                  color: Colors.grey[900],
                  // fontWeight: FontWeight.bold,
                  fontWeight: FontWeight.w900,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      );
    });
  }
}
