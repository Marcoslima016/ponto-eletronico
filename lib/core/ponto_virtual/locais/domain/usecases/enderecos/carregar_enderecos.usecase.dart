import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

import '../../domain.imports.dart';

///
///Usecase responsável por fazer requisição para recuperar a lista de endereços
abstract class ICarregarEnderecos {
  Future<List<Local>> call();
}

class CarregarEnderecos implements ICarregarEnderecos {
  //
  IEnderecosRepository repository;

  CarregarEnderecos({
    @required this.repository,
  });

  @override
  Future<List<Local>> call() async {
    Either repoResponse = await repository.getEnderecos();
    if (repoResponse.isRight()) {
      return repoResponse.fold((l) => null, (r) => r);
    } else {
      /// [ Tratar erro. ( Exibir popup, por exemplo )]
      // throw ("ESSE ERRO DEVE SER TRATADO !!!!!");

      return []; //// Retorna uma lista vazia ( pq não conseguiu carregar seu conteudo )
    }
  }
}
