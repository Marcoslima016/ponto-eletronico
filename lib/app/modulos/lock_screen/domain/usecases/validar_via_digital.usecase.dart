import 'package:dartz/dartz.dart';
import 'package:get/get.dart';

import '../../lock_screen.imports.dart';

abstract class IValidarViaDigital {
  Future<Either<BiometricFail, BiometricAuthenticated>> call();
}

class ValidarViaDigital implements IValidarViaDigital {
  @override
  Future<Either<BiometricFail, BiometricAuthenticated>> call() async {
    return await Get.find<IBiometricDriver>().anyAuthMethod();
  }
}
