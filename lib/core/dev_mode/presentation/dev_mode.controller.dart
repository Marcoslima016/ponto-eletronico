import 'package:get/get.dart';

import '../../../lib.imports.dart';
import '../../core.imports.dart';

class DevModeController {
  //

  IDevModeTriggers usecaseTriggers = DevModeTriggers();

  RxBool popupOpen = false.obs;

  Future init() async {
    await listenTriggerFired();
  }

  Future listenTriggerFired() async {
    usecaseTriggers.triggerFired.stream.listen((event) {
      if (popupOpen.value == true) return;
      popupOpen.value = true;
      PopupDevMode(devModeController: this).show();
    });
  }

  Future alterarAmbiente(IAppConfig newEnvironment) async {
    AppController.instance.updateAppConfig(newEnvironment);
  }
}
