import 'package:custom_app/lib.imports.dart';

import '../lib.imports.dart';

class HybridConfig {
  Future initialize({AppController appControllerInstance}) async {
    CustomAppConfig.instance.initialize(appController: appControllerInstance);
  }
}
