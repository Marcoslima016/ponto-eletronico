import 'package:flutter/foundation.dart';

import 'config.imports.dart';

class AppConfigDev implements IAppConfig {
  String _baseUrlRelease = 'https://dev-api.compliancehcm.com.br/ptem';
  String _baseUrlDebug = 'https://dev-api.compliancehcm.com.br/ptem';

  @override
  EnviromentOptions enviroment = EnviromentOptions.dev;

  String displayText = "Desenvolvimento";

  // AppConfigProd({
  //   String requestUrlDebug,
  //   String requestUrlRelease,
  // }) {
  //   _requestUrlRelease = requestUrlRelease;
  //   _requestUrlDebug = requestUrlDebug;
  // }

  String get baseUrl {
    return kReleaseMode ? _baseUrlRelease : _baseUrlRelease;
  }

  String get graphqlUrl {
    return kReleaseMode ? _baseUrlRelease + "/gql" : _baseUrlRelease + "/gql";
  }

  String get graphqlUrlTotem {
    return kReleaseMode ? _baseUrlRelease + "/gqltotem" : _baseUrlRelease + "/gqltotem";
  }
}
