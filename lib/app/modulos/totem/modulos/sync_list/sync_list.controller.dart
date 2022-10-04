import 'package:get/get.dart';

import '../../../../../lib.imports.dart';

class SyncListController {
  //

  RxList<BatidaTotem> get listaBatidas => PontoVirtual.instance.totemController.listaBatidas;
}
