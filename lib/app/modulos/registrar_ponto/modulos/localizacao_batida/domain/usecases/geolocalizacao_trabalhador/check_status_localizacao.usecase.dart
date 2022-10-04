import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

import '../../../localizacao_batida.imports.dart';

abstract class ICheckStatusLocalizacao {
  Future<StatusLocalizacao> call();
}

enum StatusLocalizacao {
  disponivel,
  indisponivel,
}

//_____________________________________ IMPLEMENTACAO _______________________________________

///Usecase responsavel em verificar se o servico de localizacao do smartphone esta disponivel
class CheckStatusLocalizacao implements ICheckStatusLocalizacao {
  IGeolocationDriver driver;
  CheckStatusLocalizacao({
    @required this.driver,
  });

  @override
  Future<StatusLocalizacao> call() async {
    bool serviceIsEnable = await driver.locationIsEnable();
    return serviceIsEnable ? StatusLocalizacao.disponivel : StatusLocalizacao.indisponivel;
  }
}
