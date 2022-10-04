import 'package:dartz/dartz.dart';
import 'package:get/get.dart';

import '../../domain.imports.dart';
import '../usecases.imports.dart';

class ClockLoopNTP extends ClockLoopUtils {
  //
  @override
  Future updateTime() async {
    IGetAtualTime getAtualTime = Get.find<IGetAtualTime>();
    await getAtualTime();
  }

  ///==================== GET TIME BY SERVER ====================

  // Future<Either<Exception, DateTime>> getTimeByServer() async {
  //   IServerTimeRepository getTimeRepository = Get.find<IServerTimeRepository>();
  //   Either<Exception, DateTime> getTimeFromServer = await getTimeRepository.getTime();
  //   // print(getTimeFromServer.toString());
  //   return getTimeFromServer;
  // }
}
