import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../modulos.imports.dart';
import 'widgets/widgets.imports.dart';

class ClockTimerView extends StatelessWidget {
  ClockTimerController controller;
  ClockTimerView() {
    ClockTimerBinding().dependencies();
    controller = Get.find<ClockTimerController>();
  }
  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height / 100;
    var w = MediaQuery.of(context).size.width / 100;

    // return GetBuilder<ClockTimerController>(
    //   initState: (_) => ClockTimerBinding().dependencies(),
    //   builder: (_) => ClockTimerViewBody(),
    // );

    return ClockTimerViewBody(
      controller: this.controller,
    );
  }
}

class ClockTimerViewBody extends GetView<ClockTimerController> {
  ClockTimerController controller;

  ClockTimerViewBody({
    @required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height / 100;
    var w = MediaQuery.of(context).size.width / 100;

    // controller.runClock();

    return Container(
      width: w * 100,
      child: Column(
        children: [
          LayoutD(controller: this.controller),
        ],
      ),
    );
  }
}
