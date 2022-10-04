import 'package:flutter/material.dart';

import '../../../../../../../lib.imports.dart';
import '../debug.imports.dart';

class LocalizacaoBatidaDebugController {
  ILocalizacaoBatidaDebugRepository repository;

  bool active = false;

  static final LocalizacaoBatidaDebugController instance = LocalizacaoBatidaDebugController._(); //// Armazena a instancia utilizada no singleton
  LocalizacaoBatidaDebugController._() {
    repository = LocalizacaoBatidaDebugRepository(
      datasource: LocalizacaoBatidaDebugFirebaseDatasource(),
    );
  }

  Future<bool> getDebugStatus() async {
    bool status = await repository.getDebugStatus();
    this.active = status;
    var p = "";
    return status;
  }

  //Gravar inicio do processo processo
  Future inicioProcesso() async {
    if (!active) return;
    int timestamp = DateTime.now().microsecondsSinceEpoch;
    await repository.setInicioProcesso(timestamp: timestamp, emailUsuario: VariaveisGlobais.instance.email);
  }

  //Gravar log de um endereço da lista de endereços
  Future logEndereco({@required Local local, @required String distancia}) async {
    if (!active) return;
    await repository.setEnderecoLog(local: local, distancia: distancia);
  }

  Future errorLog({String descrErro}) async {
    if (!active) return;
    await repository.setErrorLog(descrErro: descrErro);
  }
}
