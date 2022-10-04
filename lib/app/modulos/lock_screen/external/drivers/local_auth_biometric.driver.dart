import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:local_auth/local_auth.dart';
import '../../lock_screen.imports.dart';

class LocalAuthBiometric implements IBiometricDriver {
  final LocalAuthentication auth = LocalAuthentication();

  //================================================= AUTENTICACAO GENERICA =================================================

  // Autentica tanto por facial quanto por digital

  @override
  Future<Either<BiometricFail, BiometricAuthenticated>> anyAuthMethod() async {
    List<BiometricType> availableBiometrics = await auth.getAvailableBiometrics();
    if (Platform.isIOS) {
      //IOS
      List<BiometricType> availableBiometrics = await auth.getAvailableBiometrics();
      if (availableBiometrics.contains(BiometricType.fingerprint)) {
        return await authFingerPrint();
      }

      if (availableBiometrics.contains(BiometricType.face)) {
        return await authFace();
      }

      // Se nenhum servico estiver disponivel
      return Left(BiometricFail.serviceUnavailable);
    } else {
      //ANDROID
      try {
        bool didAuthenticate = await auth.authenticate(
          localizedReason: 'Faça a autenticação para concluir a batida.',
          biometricOnly: false,
        );

        if (didAuthenticate == true) {
          return Right(BiometricAuthenticated());
        } else {
          return Left(BiometricFail.notAuthorized);
        }
      } catch (e) {
        return Left(BiometricFail.serviceUnavailable);
      }
    }
  }

  //=================================================== AUTH FINGER PRINT ===================================================

  @override
  Future<Either<BiometricFail, BiometricAuthenticated>> authFingerPrint() async {
    // List<BiometricType> availableBiometrics = await auth.getAvailableBiometrics();
    if (Platform.isIOS) {
      //IOS
      List<BiometricType> availableBiometrics = await auth.getAvailableBiometrics();
      if (availableBiometrics.contains(BiometricType.fingerprint)) {
        bool didAuthenticate = await auth.authenticate(
          localizedReason: 'Use sua digital para autenticação',
          biometricOnly: true,
        );
        if (didAuthenticate == true) {
          return Right(BiometricAuthenticated());
        } else {
          return Left(BiometricFail.notAuthorized);
        }
      } else {
        // Se o serviço fingerprint nao estiver disponivel
        return Left(BiometricFail.serviceUnavailable);
      }
    } else {
      //ANDROID
      try {
        bool didAuthenticate = await auth.authenticate(
          localizedReason: 'Use sua digital para autenticação',
          biometricOnly: true,
        );

        if (didAuthenticate == true) {
          return Right(BiometricAuthenticated());
        } else {
          return Left(BiometricFail.notAuthorized);
        }
      } catch (e) {
        return Left(BiometricFail.serviceUnavailable);
      }
    }
  }

  //====================================================== AUTH FACE ======================================================

  @override
  Future<Either<BiometricFail, BiometricAuthenticated>> authFace() async {
    // List<BiometricType> availableBiometrics = await auth.getAvailableBiometrics d();
    if (Platform.isIOS) {
      //IOS
      List<BiometricType> availableBiometrics = await auth.getAvailableBiometrics();
      if (availableBiometrics.contains(BiometricType.face)) {
        bool didAuthenticate = await auth.authenticate(
          localizedReason: 'Autenticação via reconhecimento facial',
          biometricOnly: false,
        );
        if (didAuthenticate == true) {
          return Right(BiometricAuthenticated());
        } else {
          return Left(BiometricFail.notAuthorized);
        }
      } else {
        // Se o serviço fingerprint nao estiver disponivel
        return Left(BiometricFail.serviceUnavailable);
      }
    } else {
      //ANDROID
      try {
        bool didAuthenticate = await auth.authenticate(
          localizedReason: 'Autenticação via reconhecimento facial',
          biometricOnly: false,
        );

        if (didAuthenticate == true) {
          return Right(BiometricAuthenticated());
        } else {
          return Left(BiometricFail.notAuthorized);
        }
      } catch (e) {
        return Left(BiometricFail.serviceUnavailable);
      }
    }
  }
}
