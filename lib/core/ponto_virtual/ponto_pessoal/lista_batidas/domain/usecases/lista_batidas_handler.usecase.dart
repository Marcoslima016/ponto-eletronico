import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../lib.imports.dart';
import '../../../../../core.imports.dart';
import '../../../ponto_pessoal.imports.dart';
import '../domain.imports.dart';

abstract class IListaBatidasHandler {
  Rx<ListState> state;
  RxList<Batida> get list;
  Future loadList({@required String data});
}

class ListaBatidasHandler implements IListaBatidasHandler {
  //
  Rx<ListState> state = Rx<ListState>(ListState.waiting);

  @override
  RxList<Batida> get list => batidasRepository.listaDeBatidas;

  IBatidasRepository batidasRepository;

  ListaBatidasHandler({
    @required this.batidasRepository,
  });

  Future loadList({@required String data}) async {
    state.value = ListState.loading;

    Either<Exception, ExecutionSuccess> resultadoConsultaDeBatidas = await batidasRepository.carregarBatidas(data: data);
    resultadoConsultaDeBatidas.fold((Exception l) {
      // left
    }, (ExecutionSuccess r) {
      // right
    });
    //
    state.value = ListState.loaded;
  }
}
