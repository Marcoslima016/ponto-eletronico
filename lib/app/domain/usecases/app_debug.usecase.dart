import 'package:custom_app/no-arch/custom_app/out/app_controller/app_debug.dart';

import '../../../lib.imports.dart';
import '../../app.imports.dart';

class AppDebug extends IAppDebug {
  //

  bool debugLocalBatidaActive = false;
  bool debugRegistrarPontoActive = false;

  @override
  Future init() async {
    setAllDebugStatus();
  }

  Future setAllDebugStatus() async {
    debugLocalBatidaActive = false;
    debugRegistrarPontoActive = false;
    debugLocalBatidaActive = await LocalizacaoBatidaDebugController.instance.getDebugStatus();
    // debugRegistrarPontoActive = await PontoPessoalDebugController.instance.getDebugStatus();
    var p = "";
  }
}
