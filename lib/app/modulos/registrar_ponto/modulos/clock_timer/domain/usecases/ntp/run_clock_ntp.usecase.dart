import 'package:get/get.dart';

import '../usecases.imports.dart';

class RunClockNTP implements IRunClock {
  @override
  Future call() async {
    //
    //Recuperar o primeiro time
    IGetAtualTime getAtualTime = Get.find<IGetAtualTime>();
    await getAtualTime();

    // Disparar loop de atualização
    IClockLoop clockLoop = Get.find<IClockLoop>();
    Get.find<IClockCore>().setCurrentDateString();
    await clockLoop.fireLoop();
  }
  //
}
