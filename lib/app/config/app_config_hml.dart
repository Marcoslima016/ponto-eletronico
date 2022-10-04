import 'package:flutter/foundation.dart';

import 'config.imports.dart';

class AppConfigHML implements IAppConfig {
  String _baseUrlRelease = 'https://hml-api.compliancehcm.com.br/ptem';
  String _baseUrlDebug = 'https://hml-api.compliancehcm.com.br/ptem';

  @override
  EnviromentOptions enviroment = EnviromentOptions.hml;

  String displayText = "Homologação";

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
