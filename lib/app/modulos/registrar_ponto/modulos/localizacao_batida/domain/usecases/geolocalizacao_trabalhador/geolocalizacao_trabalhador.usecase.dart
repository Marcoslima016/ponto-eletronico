import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

import '../../../localizacao_batida.imports.dart';
import 'geolocalizacao_trabalhador.imports.dart';

abstract class IGeolocalizacaoTrabalhador {
  Future<Either<FalhaNaLocalizacao, LocalizacaoObtida>> call();
}

class LocalizacaoObtida {
  GeoPosition position;
  //Futuramente: tipo de permissao
  LocalizacaoObtida({
    @required this.position,
  });
}

class FalhaNaLocalizacao {
  List<TipoFalhaLocalizacao> falhasOcorridas = [];
  FalhaNaLocalizacao({@required this.falhasOcorridas});
}

///Enum que disponibiliza os tipos de falhas
enum TipoFalhaLocalizacao {
  permissao, //// Permissao nao foi aceita
  indisponivel, //// Indica que o servico de localizacao esta indisponivel (desativado pelo usuario)
}

//_______________________________________________ IMPLEMENTACAO _______________________________________________

///Classe responsavel por recuperar a geolocalizacao do trabalhador.
///[OBS:] Essa classe é especifica em obter a localizacao geral do usuário, e não tem a responsabilidade de
/// com base na geolocalizacao identificar dentro de qual local o usuario esta
class GeolocalizacaoTrabalhador implements IGeolocalizacaoTrabalhador {
  //

  IGeolocationDriver driver;

  //=== USECASES ===

  ICheckPermission checkPermission;

  ICheckStatusLocalizacao checkStatusLocalizacao;

  GeolocalizacaoTrabalhador({
    @required this.driver,
  }) {
    checkPermission = CheckPermission(driver: this.driver);
    checkStatusLocalizacao = CheckStatusLocalizacao(driver: this.driver);
  }

  @override
  Future<Either<FalhaNaLocalizacao, LocalizacaoObtida>> call() async {
    //

    List<TipoFalhaLocalizacao> falhasAoObterLocalizacao = [];

    //Solicitar / Verificar permissoes
    bool permissaoAceita = await checkPermission();
    if (permissaoAceita == false) {
      falhasAoObterLocalizacao.add(TipoFalhaLocalizacao.permissao);
    }

    //Verificar status de disponibilidade do serviço de geolocalização
    StatusLocalizacao statusLocalizacao = await checkStatusLocalizacao();
    if (statusLocalizacao == StatusLocalizacao.indisponivel) {
      falhasAoObterLocalizacao.add(TipoFalhaLocalizacao.indisponivel);
    }

    ///Se houve alguma falha, retorna erro
    if (falhasAoObterLocalizacao.length > 0) {
      return Left(
        FalhaNaLocalizacao(falhasOcorridas: falhasAoObterLocalizacao),
      );
    }

    //Recuperar localizacao
    GeoPosition position = await driver.getPosition();

    return Right(LocalizacaoObtida(position: position));
  }
}
