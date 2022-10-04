import 'package:get/get.dart';

import '../../domain.imports.dart';
import '../usecases.imports.dart';
import 'package:dartz/dartz.dart';

///************************************ ABORDAGEM 2 *************************************/
class GetAtualTimeNTP implements IGetAtualTime {
  //
  ///========================= call =========================
  ///
  @override
  Future call() async {
    ///
    Either<Exception, DateTime> tryGetTimeByServer = await getTimeByServer();
    IClockCore clockCore = Get.find<IClockCore>();

    DateTime currentTime;

    //Se conseguir obter o horario via servidor
    if (tryGetTimeByServer.isRight()) {
      //
      ///--- UTILIZAR HORARIO OBTIDO VIA SERVIDOR ---
      ///
      currentTime = tryGetTimeByServer.fold((l) => null, (r) => r);
      await clockCore.updateCurrentTime(currentTime);
      // return currentTime;
    } else {
      //
      ///--- UTILIZAR HORARIO DO DEVICE ---
      ///
      currentTime = DateTime.now();
      clockCore.currentTime = currentTime;
      await clockCore.updateCurrentTime(currentTime);
      // return currentTime;
    }
  }

  ///==================== GET TIME BY SERVER ====================

  Future<Either<Exception, DateTime>> getTimeByServer() async {
    IServerTimeRepository getTimeRepository = Get.find<IServerTimeRepository>();
    Either<Exception, DateTime> getTimeFromServer = await getTimeRepository.getTime();
    // print(getTimeFromServer.toString());
    return getTimeFromServer;
  }
  //
}

enum MethodStatus {
  success,
  fail,
}

///************************************ ABORDAGEM 1 *************************************/
// class GetAtualTimeNTP implements IGetAtualTime {
//   @override
//   Future call() {
//     ///
//     MethodStatus tryGetTimeByServer;

//     if (tryGetTimeByServer == MethodStatus.fail) {
//       //
//     }
//   }

//   Future<MethodStatus> getTimeByServer() async {
//     //
//   }
//   //
// }

// enum MethodStatus {
//   success,
//   fail,
// }
