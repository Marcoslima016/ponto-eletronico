import 'package:flutter/material.dart';

import '../debug.imports.dart';

class PontoPessoalDebugRepository implements IPontoPessoalDebugRepository {
  IPontoPessoalDebugDatasource remoteDatasource;

  PontoPessoalDebugRepository({
    @required this.remoteDatasource,
  });

  Future<bool> getDebugStatus() async {
    return await remoteDatasource.getDebugStatus();
  }

  //SET INICIO PROCESSO DE BATIDA
  @override
  Future setInicioProcessoDeBatida({@required DadosProcesso dadosProcesso}) async {
    await remoteDatasource.setInicioProcessoDeBatida(
      dadosProcesso: dadosProcesso,
    );
  }

  //SET FIM PROCESSO DE BATIDA
  @override
  Future setFimProcessoDeBatida({@required DadosProcesso dadosProcesso}) async {
    await remoteDatasource.setFimProcessoDeBatida(
      dadosProcesso: dadosProcesso,
    );
  }

  //Setar batida como offline
  @override
  Future setOffline({@required DadosProcesso dadosProcesso}) async {
    await remoteDatasource.setOffline(dadosProcesso: dadosProcesso);
  }

  //SETAR TRABALHADOR VALIDADO
  @override
  Future setTrabalhadorValidado({@required DadosProcesso dadosProcesso}) async {
    await remoteDatasource.setTrabalhadorValidado(dadosProcesso: dadosProcesso);
  }

  //---------------------------- LISTA DE BATIDAS INTERNA ----------------------------

  @override
  Future setListaDeBatidasNoInicioDoProcesso({@required DadosProcesso dadosProcesso, @required Map listaDeBatidas}) async {
    await remoteDatasource.setListaDeBatidasNoInicioDoProcesso(dadosProcesso: dadosProcesso, listaDeBatidas: listaDeBatidas);
  }

  @override
  Future setListaDeBatidasNoFimDoProcesso({@required DadosProcesso dadosProcesso, @required Map listaDeBatidas}) async {
    await remoteDatasource.setListaDeBatidasNoFimDoProcesso(dadosProcesso: dadosProcesso, listaDeBatidas: listaDeBatidas);
  }

  //------------------------------ PROCESSO CONTABILIZAR ------------------------------

  //SETAR INICIADO PROCESSO CONTABILIZAR
  @override
  Future setIniciadoContabilizar({@required DadosProcesso dadosProcesso, @required DadosContabilizar dadosContabilizar}) async {
    await remoteDatasource.setIniciadoContabilizar(dadosProcesso: dadosProcesso, dadosContabilizar: dadosContabilizar);
  }

  Future setConcluidoContabilizar({@required DadosProcesso dadosProcesso, @required ContabilizarConcluido dadosConclusaoContabilizar}) async {
    await remoteDatasource.setConcluidoContabilizar(dadosProcesso: dadosProcesso, dadosConclusaoContabilizar: dadosConclusaoContabilizar);
  }

  //SETAR STATUS DE BATIDA JA EXISTENTE NO HORARIO
  @override
  Future setStatusBatidaJaExistente({@required DadosProcesso dadosProcesso, @required bool status}) async {
    await remoteDatasource.setStatusBatidaJaExistente(dadosProcesso: dadosProcesso, status: status);
  }
  //

}
