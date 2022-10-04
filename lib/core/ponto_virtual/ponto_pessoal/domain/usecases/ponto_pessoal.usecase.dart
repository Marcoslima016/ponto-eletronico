import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../lib.imports.dart';
import '../../../ponto_virtual.imports.dart';
import '../../ponto_pessoal.imports.dart';

abstract class IPontoPessoal {
  RxList<Batida> get batidasDoDia;
  Rx<ListState> get listState;
  RxBool get timeoutHit;

  BuildContext contextRegistrarPontoPage;

  Future inicializar();
  Future registrarPontoPessoal({@required BuildContext contextRegistrarPontoPage});
  Future carregarBatidasDoDia();
  bool isOn = false;

  Future tratarAppMinimizado();
  Future tratarAppRetomado();
}

class PontoPessoal extends IPontoPessoal {
  //
  ///[=================== VARIAVEIS ===================]
  ///
  IEnderecosPonto get enderecosPonto => Get.find<IEnderecosPonto>();

  IListaBatidasHandler get listaBatidasHandler => Get.find<IListaBatidasHandler>();

  ISincronizarBatidas get sincronizarBatidasUsecase => Get.find<ISincronizarBatidas>();

  @override
  RxList<Batida> get batidasDoDia => listaBatidasHandler.list;

  @override
  Rx<ListState> get listState => listaBatidasHandler.state;

  String get txtEstagioProcesso => Get.find<IRegistrarPontoPessoal>().txtEstagioProcesso;

  @override
  RxBool get timeoutHit => Get.find<IRegistrarPontoPessoal>().timeoutHit;

  BuildContext contextRegistrarPontoPage;

  FacialRecognitionPontoPessoalController facialRecognition = FacialRecognitionPontoPessoalController.instance;

  ///[================================================== METODOS ==================================================]
  ///[=============================================================================================================]

  //---------------------------------------- INICIALIZAR ----------------------------------------

  @override
  Future inicializar() async {
    if (isOn == true) return;
    isOn = true;

    await facialRecognition.initFacialRecognition();

    //  Recuperar lista de endereços
    await enderecosPonto.carregarEnderecos();

    await carregarBatidasDoDia();

    await sincronizarBatidasUsecase.iniciarRotinaDeSincronizacao();

    await LogRegistrarPontoController.instance.init();
  }

  //---------------------------------- CARREGAR BATIDAS DO DIA ----------------------------------

  @override
  Future carregarBatidasDoDia() async {
    await listaBatidasHandler.loadList(data: await _getDateTime());
  }

  Future _getDateTime() async {
    dynamic day = DateTime.now().day;
    dynamic month = DateTime.now().month;
    var year = DateTime.now().year;

    if (day < 10) {
      day = '0$day';
    }
    if (month < 10) {
      month = '0$month';
    }
    return '$day/$month/$year';
  }

  //---------------------------------- REGISTRAR PONTO PESSOAL ----------------------------------

  @override
  Future registrarPontoPessoal({@required BuildContext contextRegistrarPontoPage}) async {
    this.contextRegistrarPontoPage = contextRegistrarPontoPage;
    await Get.find<IRegistrarPontoPessoal>().iniciarProcessoDeBatida();
  }

  //--------------------------------- TRATAR MINIMIZAÇÃO DO APP ---------------------------------

  //---- APP FOI MINIMIZADO ----

  Future tratarAppMinimizado() async {
    await Get.find<ISincronizarBatidas>().pararLoop();
    await LogAppController.instance.writeLogAppMinimizado();
  }

  //------ APP FOI ABERTO ------

  Future tratarAppRetomado() async {
    await PontoVirtual.instance.atualizarBatidasDoDia();
    await Get.find<ISincronizarBatidas>().dispararLoopDeCiclos();
    await LogAppController.instance.writeLogAppAberto();
  }
}
