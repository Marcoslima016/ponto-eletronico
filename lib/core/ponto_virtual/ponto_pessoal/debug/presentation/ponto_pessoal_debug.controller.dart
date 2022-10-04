import 'package:flutter/material.dart';

import '../../ponto_pessoal.imports.dart';
import '../debug.imports.dart';

class PontoPessoalDebugController {
  //

  IInicioProcessoBatida inicioProcessoBatidaUsecase;
  IPontoPessoalDebugRepository repository;
  IPontoPessoalDebugDatasource datasource;

  DadosProcesso dadosProcesso;

  bool active = false;

  static final PontoPessoalDebugController instance = PontoPessoalDebugController._(); //// Armazena a instancia utilizada no singleton
  PontoPessoalDebugController._() {
    datasource = PontoPessoalDebugDatasourceFirebase();
    repository = PontoPessoalDebugRepository(remoteDatasource: datasource);
    inicioProcessoBatidaUsecase = InicioProcessoBatida(repository: repository);
  }

  //========================================= PROCESSO DE BATIDA =========================================

  Future<bool> getDebugStatus() async {
    bool status = await repository.getDebugStatus();
    this.active = status;
    var p = "";
    return status;
  }

  //------------------------- INICIO PROCESSO DE BATIDA --------------------------

  Future inicioProcessoDeBatida() async {
    if (active) {
      dadosProcesso = await inicioProcessoBatidaUsecase();
    }
  }

  //--------------------------- FIM PROCESSO DE BATIDA ---------------------------

  Future fimProcessoDeBatida() async {
    //
  }

  //---------------------------- BATIDA FEITA OFFLINE ----------------------------

  Future offline() async {
    if (active) {
      repository.setOffline(dadosProcesso: dadosProcesso);
    }
  }

  //---------------------------- TRABALHADOR VALIDADO ----------------------------

  Future trabalhadorValidado() async {
    if (active) {
      repository.setTrabalhadorValidado(
        dadosProcesso: this.dadosProcesso,
      );
    }
  }

  //-------------------- INFORMACOES SOBRE A LISTA DE BATIDAS --------------------

  //INICIO DO PROCESSO
  Future listaDeBatidasDoInicioDoProcesso(BatidasDoDiaRepository batidasRepository) async {
    Map<String, dynamic> finalMap = {};
    int i = 0;
    for (Batida batida in batidasRepository.baseList) {
      finalMap[i.toString()] = batida.toMap();
      i++;
    }
    if (active) {
      repository.setListaDeBatidasNoInicioDoProcesso(dadosProcesso: dadosProcesso, listaDeBatidas: finalMap);
    }
  }

  //FIM DO PROCESSO
  Future listaDeBatidasDoFimDoProcesso(BatidasDoDiaRepository batidasRepository) async {
    Map<String, dynamic> finalMap = {};
    int i = 0;
    for (Batida batida in batidasRepository.baseList) {
      finalMap[i.toString()] = batida.toMap();
      i++;
    }
    if (active) {
      repository.setListaDeBatidasNoFimDoProcesso(dadosProcesso: dadosProcesso, listaDeBatidas: finalMap);
    }
  }

  //-------------------------------- CONTABILIZAR --------------------------------

  Future iniciadoContabilizar(RegistroBatida dadosNovaBatida) async {
    DadosContabilizar dadosContabilizar = DadosContabilizar(
      dadosNovaBatida: dadosNovaBatida,
      timestampStart: DateTime.now().millisecondsSinceEpoch,
    );
    if (active) {
      repository.setIniciadoContabilizar(
        dadosProcesso: dadosProcesso,
        dadosContabilizar: dadosContabilizar,
      );
    }
  }

  //STATUS BATIDA JA EXISTENTE NO HORARIO
  Future statusBatidaJaExistenteNoHorario({@required bool status}) async {
    if (active) {
      repository.setStatusBatidaJaExistente(dadosProcesso: dadosProcesso, status: status);
    }
  }

  //CONCLUIDO CONTABILIZAR
  Future concluidoContabilizar() async {
    ContabilizarConcluido dadosConclusaoContabilizar = ContabilizarConcluido(
      timestampFinish: DateTime.now().millisecondsSinceEpoch,
    );
    if (active) {
      repository.setConcluidoContabilizar(dadosProcesso: dadosProcesso, dadosConclusaoContabilizar: dadosConclusaoContabilizar);
    }
  }

  //-------------------------- FALHA PROCESSO DE BATIDA --------------------------

  Future falhaProcessoDeBatidas() async {
    //
  }

  //------------------------- TIMEOUT PROCESSO DE BATIDA -------------------------

  Future timeoutProcessoDeBatida() async {
    //
  }

  //============================================ SINCRONIZACAO ============================================

  Future iniciadoLoopDeSincronizacao() async {
    //
  }

  Future iniciadaSincronizacaoDeBatida() async {
    //
  }

  Future resultadoVerificacaoDeBatidasDuplicadas() async {
    //
  }
}
