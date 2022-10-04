import 'package:dartz/dartz.dart';

import '../domain.imports.dart';

abstract class ITotemRepository {
  Future<Either<Exception, String>> login(LoginCredentials credentials);

  Future<Either<Exception, List<Colab>>> getColabList();
}
