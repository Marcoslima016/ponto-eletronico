import 'package:dartz/dartz.dart';

import '../../lock_screen.imports.dart';

abstract class IBiometricDriver {
  Future<Either<BiometricFail, BiometricAuthenticated>> authFingerPrint();

  Future<Either<BiometricFail, BiometricAuthenticated>> anyAuthMethod();

  Future<Either<BiometricFail, BiometricAuthenticated>> authFace();
}
