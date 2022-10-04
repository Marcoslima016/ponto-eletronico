import 'package:dartz/dartz.dart';

import '../totem.imports.dart';

abstract class ITotemDatasource {
  Future<Either<Exception, Map>> login(LoginCredentials credentials) {}

  Future<List> getAllColab() {}
}
