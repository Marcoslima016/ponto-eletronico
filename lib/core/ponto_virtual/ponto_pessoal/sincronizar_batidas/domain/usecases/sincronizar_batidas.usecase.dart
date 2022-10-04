import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ptem2/core/core.imports.dart';

import '../../../ponto_pessoal.imports.dart';

abstract class ISincronizarBatidas {
  Timer timer;
  Future iniciarRotinaDeSincronizacao();
  Future dispararLoopDeCiclos();
  Future pararLoop();
}

class SincronizarBatidas implements ISincronizarBatidas {
  //
  @override
  Timer timer;

  int intervaloEntreCiclos = 10;

  BatidasDoDiaRepository repository;

  bool syncInProgress = false;

  bool syncActive = false;

  bool runningCycle = false;

  SincronizarBatidas({
    @required this.repository,
  });

  Future iniciarRotinaDeSincronizacao() async {
    // print("INICIAR ROTINA DE SINCRONIZACAO !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
    dispararLoopDeCiclos();
  }

  //--------------------------------------------------------- DISPARAR LOOP ---------------------------------------------------------

  @override
  Future dispararLoopDeCiclos() async {
    // print("DISPARAR LOOP DE CICOS !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");

    if (runningCycle) {
      while (runningCycle) {
        await Future.delayed(Duration(milliseconds: 900), () async {});
      }
    }

    if (syncActive) return;

    syncActive = true;
    await Future.delayed(Duration(seconds: 10), () async {
      if (syncInProgress == false) {
        // print(">>>>>>> 00000000000000000");
        await sincronizarBatidas();
      }
    });
    await runCycle();
  }

  Future runCycle() async {
    // print(">>>>>>> 111111111111111111");
    await Future.delayed(Duration(seconds: intervaloEntreCiclos), () async {
      runningCycle = true;
      // print(">>>>>>> 222222222222222222");

      if (syncInProgress == false) {
        await sincronizarBatidas();
      }

      runningCycle = false;
      // print(">>>>>>> 3333333333333333333");
      if (syncActive) runCycle();
    });
  }

  Future pararLoop() async {
    syncActive = false;
  }

  //------------------------------------------------------ SINCRONIZAR BATIDAS ------------------------------------------------------

  String lastSyncDate = "";
  Future sincronizarBatidas() async {
    try {
      // print("SINCRONIZAR BATIDAS !!!!!!!!!!!!!!!!!!!!!!!!");

      if (syncInProgress == true || repository.carregandoBatidas == true) return;
      syncInProgress = true;

      bool atualizarRepository = false;

      // print("sincronizarBatidas() - METODO DISPARADO !!!!!!!!!");

      /// Armazena o id de batidas offline que devem ser removidas, por serem do dia anterior e ja terem sido sincronizadas,
      /// ou por serem batidas ja contabilizadas no servidor
      List<int> batidasOffQueDevemSerRemovidas = [];

      ///Se trocou de dia, atualiza a lista de batidas antes de sincronizar
      if (lastSyncDate != "" && lastSyncDate != await _getDateTime()) {
        await PontoVirtual.instance.atualizarBatidasDoDia();
        await Future.delayed(Duration(seconds: 10), () async {}); ////Adiciona 10 segundos antes de reiniciar o ciclo de sync (para ter certeza que a lista ja foi recarregada)
      }
      lastSyncDate = await _getDateTime();

      int i = 0;
      for (Batida batida in repository.listaDeBatidas) {
        if (batida.tipo == TipoBatida.offline && batida.syncStatus.value != SyncStatus.syncComplete) {
          // batida.syncStatus.value = SyncStatus.inQueue;
          int idBatidaRegistrada;
          bool batidaRegistradaComSucesso = false;

          Either<Exception, bool> verificarSeJaFoiSincronizadaResult = await _verificarSeJaFoiSincronizada(batida);

          if (verificarSeJaFoiSincronizadaResult.isRight()) {
            bool jaFoiSincronizada = false;
            verificarSeJaFoiSincronizadaResult.fold((l) => null, (r) {
              jaFoiSincronizada = r;
            });

            if (jaFoiSincronizada == true) {
              //
              //-- SE BATIDA OFF JA FOI SINCRONIZADA ANTERIORMENTE --

              // print("sincronizarBatidas() - BATIDA JA FOI SINCRONIZADA !!!!!!!!!");

              // batidaRegistradaComSucesso = true;
              batidasOffQueDevemSerRemovidas.add(batida.id);
              atualizarRepository = true;
            } else {
              //
              //----- SE A BATIDA OFF AINDA NAO FOI SINCRONIZADA -----

              // print("sincronizarBatidas() - Tentar sincronizar batida!!!");
              idBatidaRegistrada = await repository.sincronizarBatida(batida.dadosRegistro);
              if (idBatidaRegistrada != null && idBatidaRegistrada != 0) {
                batidaRegistradaComSucesso = true;
              }

              if (batidaRegistradaComSucesso == true) {
                if (batida.dateExpired == true) batidasOffQueDevemSerRemovidas.add(idBatidaRegistrada); //// Se estiver vencida, sera removida da lista
                batida.id = idBatidaRegistrada;
                batida.tipo = TipoBatida.offline;
                batida.syncStatus = SyncStatus.syncComplete.obs;
                atualizarRepository = true;
              }
            }
          } else {
            var p = "";
            //FALHA PARA RECUPERAR BATIDAS JA CONTABILIZADAS
            //(nada é feito, o processo de sincronização é pulado)
          }
        }
        i++;
      }

      //Remove da lista as batidas do dia anterior que ja foram sincronizadas, ou -
      // batidas que ja foram contabilizadas no servidor (evitar duplicacao)
      for (int id in batidasOffQueDevemSerRemovidas) {
        // print("sincronizarBatidas() - REMOVER BATIDA DA LISTA!!!");
        // repository.listaDeBatidas.removeAt(index);
        repository.listaDeBatidas.removeWhere((Batida batida) {
          if (batida.id == id) {
            return true;
          } else {
            return false;
          }
        });
      }

      //ATUALIZAR LISTA DO REPOSITORY
      if (atualizarRepository == true) {
        // print("sincronizarBatidas() -  Sincronização realizada!!!");

        // print("sincronizarBatidas() - ATUALIZAR REPOSITORY !!!!!!!!!");
        //PERSISTIR NOVA LISTA EM CACHE
        await repository.saveInCache();
        // await repository.carregarBatidas(data: await _getDateTime());
        await Get.find<IListaBatidasHandler>().loadList(data: await _getDateTime());
      }
      syncInProgress = false;
    } catch (e) {
      syncInProgress = false;
      print("************************** ERRO METODO sincronizarBatidas() - " + e.toString());
    }
  }

  //-------------------------------------------- VERIFICAR SE BATIDA JA FOI SINCRONIZADA ---------------------------------------------

  Future<Either<Exception, bool>> _verificarSeJaFoiSincronizada(Batida batida) async {
    Either<Exception, List<Batida>> batidasServidorResult = await repository.consultarBatidas(data: batida.data);
    if (batidasServidorResult.isRight()) {
      return batidasServidorResult.fold(
        (l) {
          return Left(Exception());
        },
        (List<Batida> listaDeBatidasServidor) {
          for (Batida batidaServidor in listaDeBatidasServidor) {
            if (batida.hr == batidaServidor.hr) {
              return Right(true);
            }
          }
          return Right(false);
        },
      );
    }
    return Left(Exception());
  }

  //---------------------------------------------------------- GET DATE TIME -----------------------------------------------------------

  Future _getDateTime() async {
    dynamic day = DateTime.now().day;
    dynamic month = DateTime.now().month;
    var year = DateTime.now().year;

    if (day < 10) {
      day = '0$day';
    }
    if (month < 10) {
      month = '0$month';
    }
    return '$day/$month/$year';
  }
}
