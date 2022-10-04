import 'package:custom_app/lib.imports.dart';
import 'package:custom_auth/src/versions/v2/v2.imports.dart';
import 'package:get/get.dart';

import '../lib.imports.dart';
import 'template/template.imports.dart';

class AppController extends CustomAppController {
  //

  // @override
  // AuthPreferences authPreferences = AuthPreferences(
  //   privateRoute: AppRoutes.PROFILE,
  //   afterDisconnectRoute: AppRoutes.LOBBY,
  //   userModel: User(),
  //   authClient: FirebaseAuthClient(),
  // );

  @override
  IAppComponents components = Components();

  @override
  IStyleTheme style = Style();

  @override
  IAppDebug debug = AppDebug();

  RxList<IAppConfig> _config = List<IAppConfig>().obs;

  // IAppConfig config = AppConfigProd();
  IAppConfig get config => _config.last;

  VersionHandlerController versionHandler;

  DevModeController devMode = DevModeController();

  ///[=================== CONSTRUTOR ===================]

  static final AppController instance = AppController._(); //// Armazena a instancia utilizada no singleton
  AppController._() {
    _config.add(AppConfigProd());
    versionHandler = VersionHandlerController.instance;
  }

  ///[================================================== METODOS ==================================================]
  ///[=============================================================================================================]
  ///

  @override
  Future implInitialize() async {
    await VersionHandlerController.instance.checkVersionCompatibility();
    await devMode.init();
    // await LogAppController.instance.init();
    // await LogAppController.instance.startCycle();
  }

  Future updateAppConfig(IAppConfig newConfig) async {
    _config.clear();
    _config.add(newConfig);
  }
}
