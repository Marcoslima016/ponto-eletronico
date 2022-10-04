import 'package:dartz/dartz.dart';

abstract class IServerTimeRepository {
  Future<Either<Exception, DateTime>> getTime();
}
