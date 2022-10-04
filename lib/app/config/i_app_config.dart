import 'config.imports.dart';

abstract class IAppConfig {
  EnviromentOptions enviroment;
  String displayText;
  String get baseUrl;
  String get graphqlUrl;
  String get graphqlUrlTotem;
}
