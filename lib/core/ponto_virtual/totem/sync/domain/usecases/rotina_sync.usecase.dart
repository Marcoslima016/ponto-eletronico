import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

import '../../../totem.imports.dart';
import '../domain.imports.dart';

abstract class IRotinaSync {
  Future iniciarRotina();
}

class RotinaSync implements IRotinaSync {
  //
  Timer timerLoop;

  IBatidasHandler batidasHandler;
  ISyncRepository repository;

  bool limpandoLista = false;

  bool cicloStarted = false;

  RotinaSync({
    @required this.batidasHandler,
    @required this.repository,
  });

  Future iniciarRotina() async {
    if (cicloStarted == true) {
      return;
    }
    cicloStarted = true;

    Future.delayed(const Duration(seconds: 10), () async {
      dispararCiclo();
    });
  }

  Future dispararCiclo() async {
    await _limparLista();
    await _sincronizarBatidas();
    await _limparLista();
    Future.delayed(const Duration(seconds: 10), () async {
      dispararCiclo();
    });
  }

  //-------------------------- SINCRONIZAR BATIDAS --------------------------
  //Sincronizar batidas da lista;

  Future _sincronizarBatidas() async {
    //
    bool processing = true;
    int indexAtual = 0;

    List<int> batidasQueDevemSerRemovidas = [];

    if (batidasHandler.listaBatidas.length == 0) return;

    while (processing) {
      BatidaTotem batida = batidasHandler.listaBatidas[indexAtual];

      if (batida.status != BatidaStatus.synchronized) {
        Either<Exception, bool> verificarSeJaFoiSincronizadaResult = await _verificarSeJaFoiSincronizada(batida);
        if (verificarSeJaFoiSincronizadaResult.isRight()) {
          bool jaFoiSincronizada = false;
          verificarSeJaFoiSincronizadaResult.fold((l) => null, (r) {
            jaFoiSincronizada = r;
          });

          if (jaFoiSincronizada == false) {
            //--- SE AINDA NAO FOI SINCRONIZADA ---
            bool requestResult = await repository.contabilizarBatida(batida: batida);

            if (requestResult == true) {
              // print(">>>>>>>>>>> SYNC - BATIDA CONTABILIZADA COM SUCESSO");
              await batidasHandler.atualizarStatusDaBatida(batidaInternalID: batida.internalId, status: BatidaStatus.synchronized);
            } else {
              //
              await batidasHandler.setHasError(batidaInternalID: batida.internalId, statusHasError: true);
            }
          } else {
            //--- SE JA FOI SINCRONIZADA ---
            batidasQueDevemSerRemovidas.add(batida.internalId);
          }
        }
      }

      if (indexAtual + 1 == batidasHandler.listaBatidas.length) {
        processing = false;
      } else {
        indexAtual++;
      }
    }

    //Remover batidas que ja foram sincronizadas
    for (int id in batidasQueDevemSerRemovidas) {
      batidasHandler.listaBatidas.removeWhere((BatidaTotem batida) {
        if (batida.internalId == id) {
          return true;
        } else {
          return false;
        }
      });
    }
  }

  //-------------------------------------------- VERIFICAR SE BATIDA JA FOI SINCRONIZADA ---------------------------------------------

  Future<Either<Exception, bool>> _verificarSeJaFoiSincronizada(BatidaTotem batida) async {
    Either<Exception, List<BatidaTotem>> batidasServidorResult = await repository.carregarBatidas(
      data: batida.dthrBatida.split(" ")[0],
      pessoasId: batida.pessoasId,
    );

    if (batidasServidorResult.isRight()) {
      return batidasServidorResult.fold(
        (l) {
          return Left(Exception());
        },
        (List<BatidaTotem> listaDeBatidasServidor) {
          for (BatidaTotem batidaServidor in listaDeBatidasServidor) {
            if (batida.dthrBatida.split(" ")[1] == batidaServidor.dthrBatida.split(" ")[1]) {
              return Right(true);
            }
          }
          return Right(false);
        },
      );
    }
    return Left(Exception());
  }

  //------------------------------ LIMPAR LISTA ------------------------------
  //Processo responsável por remover da lista as batidas que ja foram sincronizadas

  Future _limparLista() async {
    // print(">>>>>>>>>>> SYNC - METODO _limparLista() disparado!!!");
    limpandoLista = true;
    await batidasHandler.removerBatidasJaSincronizadas();

    // print(">>>>>>>>>>> SYNC - Finalizado metodo _limparLista()");
    // print(">>>>>>>>>>> SYNC - Lista de batidas lenght: " + batidasHandler.listaBatidas.length.toString());
    limpandoLista = false;
  }
}
