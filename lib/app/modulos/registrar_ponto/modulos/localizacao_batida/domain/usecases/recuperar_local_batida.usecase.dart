import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ptem2/core/ponto_virtual/ponto_virtual.imports.dart';

import '../../localizacao_batida.imports.dart';
import '../domain.imports.dart';

abstract class IRecuperarLocalDaBatida {
  Future<Either<LocalNaoDefinido, LocalDefinido>> call();
}

class RecuperarLocalDaBatida implements IRecuperarLocalDaBatida {
  IDeterminarLocalComBaseNaPosicao determinarLocalComBaseNaPosicao;
  PontoVirtual pontoVirtual;

  RecuperarLocalDaBatida({
    @required this.determinarLocalComBaseNaPosicao,
  });

  @override
  Future<Either<LocalNaoDefinido, LocalDefinido>> call() async {
    //
    final IGeolocalizacaoTrabalhador recuperarGeolocalizacao = Get.find<IGeolocalizacaoTrabalhador>();

    LocalizacaoBatidaDebugController.instance.inicioProcesso();

    final Either<FalhaNaLocalizacao, LocalizacaoObtida> geoPositionAttempt = await recuperarGeolocalizacao(); ////Recuperar localizacao geografica do trabalhador
    if (geoPositionAttempt.isRight()) {
      //
      //--------- LOCALIZACAO OBTIDA --------

      return await geoPositionAttempt.fold(
        (l) => null,
        (LocalizacaoObtida geoPositionAttemptResult) async {
          final LocalDefinido local = await determinarLocalComBaseNaPosicao(geoLocalizacao: geoPositionAttemptResult.position);
          if (local == null) {
            //Se a localizalicao do trabalhador nao estiver dentro de nenhum dos locais permitidos bater ponto,
            // é retornado status de local não definido
            return Left(LocalNaoDefinido(geoPosition: geoPositionAttemptResult.position, parametroTeste: "testando!"));
          } else {
            return Right(local);
          }
        },
      );
    } else {
      //
      //----- FALHA AO OBTER LOCALIZACAO -----

      FalhaNaLocalizacao detalhesFalha = await geoPositionAttempt.fold((FalhaNaLocalizacao l) => l, (r) => null);

      //*** DEBUG ***/
      String strFalhasOcorridas = "";
      for (TipoFalhaLocalizacao tipoFalhaLocalizacao in detalhesFalha.falhasOcorridas) {
        strFalhasOcorridas = strFalhasOcorridas + " | " + tipoFalhaLocalizacao.toString();
      }
      LocalizacaoBatidaDebugController.instance.errorLog(descrErro: strFalhasOcorridas);
      //*************/

      return Left(
        LocalNaoDefinido(
          falhaNaLocalizacao: await geoPositionAttempt.fold((FalhaNaLocalizacao l) => l, (r) => null),
        ),
      );
    }
  }
}
