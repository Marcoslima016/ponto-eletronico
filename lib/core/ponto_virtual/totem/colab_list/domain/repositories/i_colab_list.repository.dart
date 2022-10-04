import 'package:dartz/dartz.dart';
import 'package:get/get.dart';

import '../../../totem.imports.dart';

abstract class IColabListRepository {
  //
  RxList<Colab> colabList = RxList<Colab>();
  Future<Either<Exception, List<Colab>>> loadColabList();
  Future updateColabList();
}
