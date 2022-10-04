import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../domain.imports.dart';
import '../usecases.imports.dart';

abstract class IBatidasHandler {
  //

  RxList<BatidaTotem> get listaBatidas;

  Future carregarBatidas();

  Future tentarRegistrarBatidaViaQr({@required String scanResult});

  Future tentarRegistrarBatidaViaMatricula();

  Future tentarRegistrarBatidaViaColab({@required Colab colab});

  Future removerBatidasJaSincronizadas();

  Future atualizarStatusDaBatida({@required int batidaInternalID, @required BatidaStatus status});

  Future setHasError({@required int batidaInternalID, @required bool statusHasError});
}

class BatidasHandler implements IBatidasHandler {
  //
  ICarregarBatidas usecaseCarregarBatidas;
  ITentarRegistrarBatidaViaQr usecaseTentarRegistrarBatidaViaQr;
  ITentarRegistrarBatidaViaMatricula usecaseTentarRegistrarBatidaViaMatricula;
  ITentarRegistrarBatidaViaColab usecaseTentarRegistrarBatidaViaColab;
  IBatidasTotemRepository repository;

  RxList<BatidaTotem> get listaBatidas => repository.listaBatidas;

  BatidasHandler({
    @required this.usecaseTentarRegistrarBatidaViaQr,
    @required this.usecaseTentarRegistrarBatidaViaMatricula,
    @required this.usecaseTentarRegistrarBatidaViaColab,
    @required this.usecaseCarregarBatidas,
    @required this.repository,
  });

  //--------------------------------- CARREGAR BATIDAS ---------------------------------

  //Metodo que faz o carregamento das batidas na inicializacao do totem
  Future carregarBatidas() async {
    await usecaseCarregarBatidas();
  }

  //------------------------------ REGISTRAR BATIDA VIA QR ------------------------------

  @override
  Future tentarRegistrarBatidaViaQr({@required String scanResult}) async {
    await usecaseTentarRegistrarBatidaViaQr(scanResult: scanResult);
  }

  //--------------------------- REGISTRAR BATIDA VIA MATRICULA ---------------------------

  @override
  Future tentarRegistrarBatidaViaMatricula() async {
    await usecaseTentarRegistrarBatidaViaMatricula();
  }

  //----------------------------- REGISTRAR BATIDA VIA COLAB -----------------------------

  Future tentarRegistrarBatidaViaColab({@required Colab colab}) async {
    await usecaseTentarRegistrarBatidaViaColab(colab: colab);
  }

  //--------------------- REMOVER BATIDAS QUE JA FORAM SINCRONIZADAS ---------------------

  @override
  Future removerBatidasJaSincronizadas() async {
    listaBatidas.removeWhere((BatidaTotem batida) => batida.status == BatidaStatus.synchronized);
    await repository.salvarListaDeBatidas();
  }

  //------------------------------------- SETAR ERRO -------------------------------------

  @override
  Future setHasError({@required int batidaInternalID, @required bool statusHasError}) async {
    for (BatidaTotem batida in listaBatidas) {
      if (batida.internalId == batidaInternalID) batida.hasError.value = statusHasError;
    }
    await repository.salvarListaDeBatidas(); //// Apos alterar o status da batida, persisti a lista em cache
  }

  //----------------------------- ATUALIZAR STATUS DA BATIDA -----------------------------

  @override
  Future atualizarStatusDaBatida({@required int batidaInternalID, BatidaStatus status}) async {
    for (BatidaTotem batida in listaBatidas) {
      if (batida.internalId == batidaInternalID) batida.status = status;
    }
    await repository.salvarListaDeBatidas(); //// Apos alterar o status da batida, persisti a lista em cache
  }

  // Future registrarBatida() async {
  //   //
  // }
}
