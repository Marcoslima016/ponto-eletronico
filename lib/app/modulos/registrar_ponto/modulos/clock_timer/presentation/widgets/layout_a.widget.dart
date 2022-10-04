import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../presentation.imports.dart';

class LayoutA extends StatelessWidget {
  ClockTimerController controller;
  LayoutA({
    @required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height / 100;
    var w = MediaQuery.of(context).size.width / 100;

    return Obx(() {
      return Padding(
        padding: EdgeInsets.only(left: w * 6, right: w * 6),
        child: Container(
          width: w * 100,
          padding: EdgeInsets.only(top: h * 2.6, bottom: h * 2.6),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey[200], width: 1.5),
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Icon(Icons.watch_later_outlined, size: h * 5.2, color: Colors.grey[300]),
              // SizedBox(width: w * 2),
              Text(
                controller.timeWithFuso,
                style: TextStyle(fontSize: h * 5.2, color: Colors.grey[400], fontWeight: FontWeight.w700),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      );
    });
  }
}
