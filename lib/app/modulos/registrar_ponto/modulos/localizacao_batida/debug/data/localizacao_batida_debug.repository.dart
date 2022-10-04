import 'package:flutter/material.dart';
import 'package:ptem2/app/modulos/registrar_ponto/modulos/localizacao_batida/debug/domain/repositories/i_localizacao_batida_debug.repository.dart';

import '../../../../../../../lib.imports.dart';
import 'data.imports.dart';

class LocalizacaoBatidaDebugRepository implements ILocalizacaoBatidaDebugRepository {
  ILocalizacaoBatidaDebugDatasource datasource;

  String emailUsuario;

  LocalizacaoBatidaDebugRepository({
    @required this.datasource,
  });

  Future<bool> getDebugStatus() async {
    return await datasource.getDebugStatus();
  }

  @override
  Future setInicioProcesso({@required int timestamp, @required String emailUsuario}) async {
    this.emailUsuario = emailUsuario;
    await datasource.setInicioProcesso(timestamp: timestamp, emailUsuario: emailUsuario);
  }

  @override
  Future setEnderecoLog({@required Local local, @required String distancia}) async {
    await datasource.setEnderecoLog(local: local, distancia: distancia, emailUsuario: this.emailUsuario);
  }

  @override
  Future setErrorLog({String descrErro}) async {
    await datasource.setErrorLog(descrErro: descrErro, emailUsuario: this.emailUsuario);
  }
  //
}
