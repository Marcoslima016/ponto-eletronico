import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../domain.imports.dart';
import '../usecases.imports.dart';

abstract class IEnderecosPonto {
  List<Local> locaisPonto;
  RxBool carregandoListaDeEnderecos;
  Future carregarEnderecos();
}

class EnderecosPonto implements IEnderecosPonto {
  //
  ICarregarEnderecos carregarEnderecosUsecase;

  @override
  List<Local> locaisPonto;

  RxBool carregandoListaDeEnderecos = false.obs;

  EnderecosPonto({
    @required this.carregarEnderecosUsecase,
  });

  @override
  Future carregarEnderecos() async {
    carregandoListaDeEnderecos.value = true;
    locaisPonto = await carregarEnderecosUsecase();
    carregandoListaDeEnderecos.value = false;
    var point = "";
  }
}
