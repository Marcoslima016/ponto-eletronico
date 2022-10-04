import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

import '../../totem.imports.dart';
import '../domain.imports.dart';

abstract class ILoginTotem {
  Future<Either<Exception, String>> call(LoginCredentials credentials);
}

class LoginTotem implements ILoginTotem {
  ITotemRepository repository;

  LoginTotem({
    @required this.repository,
  });

  Future<Either<Exception, String>> call(LoginCredentials credentials) async {
    Either<Exception, String> requestResult = await repository.login(credentials);

    return requestResult.fold(
      (Exception erro) async {
        //Erro
        return Left(Exception(erro));
      },
      (String token) async {
        // Sucesso
        return Right(token);
      },
    );
  }
}
