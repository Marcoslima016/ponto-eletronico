import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../totem.imports.dart';

class BatidasTotemRepository implements IBatidasTotemRepository {
  //
  @override
  RxList<BatidaTotem> listaBatidas = List<BatidaTotem>().obs;

  IBatidasTotemDatasource localDatasource;

  BatidasTotemRepository({
    @required this.localDatasource,
  });

  //---------------------------------- CARREGAR BATIDAS ----------------------------------

  @override
  Future carregarBatidas() async {
    try {
      listaBatidas.clear();
      List<BatidaTotem> cachedList = await localDatasource.recuperarListaSalvaEmCache();
      for (BatidaTotem batidaCache in cachedList) {
        listaBatidas.add(batidaCache);
      }
    } catch (e) {
      Exception(e);
    }
  }

  //----------------------------------- REGISTRAR BATIDA ----------------------------------

  @override
  Future registrarBatida({@required BatidaTotem dadosBatida}) async {
    listaBatidas.add(dadosBatida);
    await localDatasource.salvarEmCache(listaBatidas: listaBatidas);
  }

  //-------------------------------- SALVAR LISTA DE BATIDAS -------------------------------
  //

  Future salvarListaDeBatidas() async {
    await localDatasource.salvarEmCache(listaBatidas: listaBatidas);
  }
}
