import 'package:flutter/material.dart';

import '../debug.imports.dart';

abstract class IPontoPessoalDebugDatasource {
  Future<bool> getDebugStatus();
  Future setInicioProcessoDeBatida({@required DadosProcesso dadosProcesso});
  Future setFimProcessoDeBatida({@required DadosProcesso dadosProcesso});

  Future setOffline({@required DadosProcesso dadosProcesso});

  Future setTrabalhadorValidado({@required DadosProcesso dadosProcesso});

  Future setListaDeBatidasNoInicioDoProcesso({@required DadosProcesso dadosProcesso, @required Map listaDeBatidas});
  Future setListaDeBatidasNoFimDoProcesso({@required DadosProcesso dadosProcesso, @required Map listaDeBatidas});

  Future setIniciadoContabilizar({@required DadosProcesso dadosProcesso, @required DadosContabilizar dadosContabilizar});
  Future setStatusBatidaJaExistente({@required DadosProcesso dadosProcesso, @required bool status});
  Future setConcluidoContabilizar({@required DadosProcesso dadosProcesso, @required ContabilizarConcluido dadosConclusaoContabilizar});
}
