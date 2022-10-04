import 'package:get/get.dart';
import 'package:ptem2/app/app.imports.dart';

class ClockTimerBinding extends Bindings {
  @override
  void dependencies() {
    //
    Get.put<ISetEditedTime>(SetEditedTime());
    Get.put<ISetEditedDate>(SetEditedDate());

    Get.put<IClockCore>(
      ClockCoreNTP(
        setEditedTimeUsecase: Get.find<ISetEditedTime>(),
        setEditedDateUsecase: Get.find<ISetEditedDate>(),
      ),
      permanent: true,
    );
    Get.put<IRunClock>(RunClockNTP());
    Get.put<IClockLoop>(ClockLoopNTP());
    Get.put<IGetAtualTime>(GetAtualTimeNTP());
    Get.put<IServerTimeRepository>(ServerTimeNTPRepository());

    Get.lazyPut<ClockTimerController>(() {
      return ClockTimerController();
    });
  }
  //
}
