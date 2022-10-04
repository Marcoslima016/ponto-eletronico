import 'package:flutter/foundation.dart';

import 'config.imports.dart';

class AppConfigProd implements IAppConfig {
  String _baseUrlRelease = 'https://api.compliancehcm.com.br/ptem';
  String _baseUrlDebug = 'https://api.compliancehcm.com.br/ptem';

  @override
  EnviromentOptions enviroment = EnviromentOptions.prod;

  String displayText = "Produção";

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
