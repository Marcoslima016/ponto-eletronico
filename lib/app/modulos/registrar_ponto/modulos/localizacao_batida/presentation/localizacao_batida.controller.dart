import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../registrar_ponto.imports.dart';
import '../localizacao_batida.imports.dart';

class ViewPreferences {
  // double get mapAreaWidth{
  //   return
  // };
  // double get mapAreaHeight;
}

class LocalizacaoBatidaController extends GetxController {
  //
  ///[=================== VARIAVEIS ===================]

  ///Indica o estado da página
  /// [PageState.initial] -> Estado inicial da página, onde ainda não foi iniciado o carregamento
  /// [PageState.loading] -> Carregando os dados da página ( Recuperando a localização da batida )
  /// [PageState.loadingCompleted] -> Carregamento concluido ( Localização da batida foi obtida )
  // REMOVIDO: /// [PageState.loadingFail] -> Falha no carregamento da página ( Falha ao obter a localização do trab. )
  Rx<PageState> pageState = Rx<PageState>(PageState.initial);

  IRecuperarLocalDaBatida recuperarLocalDaBatida;

  /// Se true, indica que a batida foi feita dentro de algum dos locais onde é permitido bater o ponto.
  RxBool batidaFeitaEmLocalPermitido = false.obs;

  ///Indica se houver falha na localizacao, por exemplo: Permissao não foi aceita, servico indisponivel.
  RxBool falhaNaLocalizacao = false.obs;

  ///Armazena o local onde foi realizada a batida, o local pode ser do tipo definido, ou seja,
  ///é um dos locais permitidos bater ponto; E também pode ser "Nao definido", que indica que a batida não foi feita -
  ///dentro de algum dos locais permitidos a bater o ponto.
  ILocalDaBatida localDaBatida;

  ICheckPermission checkPermission;

  IGeolocationDriver driver;

  bool localObtido = false;

  ///[=================== CONSTRUTOR ===================]
  ///
  LocalizacaoBatidaController({
    @required this.recuperarLocalDaBatida,
    @required this.driver,
  }) {
    checkPermission = CheckPermission(driver: this.driver);
  }

  ///[============================================================== METODOS ==============================================================]
  ///[=====================================================================================================================================]

  //[--------------------------------------- INITIALIZE ---------------------------------------]

  Future<InititalizeFinish> loadView() async {
    //
    pageState.value = PageState.loading;

    if (localObtido == false) {
      await _recuperarLocalDaBatida();
      localObtido = true;
    }

    pageState.value = PageState.loadingCompleted;

    return InititalizeFinish();
  }

  Future initialize() async {
    await _recuperarLocalDaBatida();
    localObtido = true;
  }

  //[-------------------------------- RECUPERAR LOCAL DA BATIDA --------------------------------]

  ///Metodo que verifica se o trabalhador esta dentro de um dos locais permitidos para bater ponto, e
  /// se estiver, verifica dentro de qual local o usuário esta
  Future _recuperarLocalDaBatida() async {
    Either<LocalNaoDefinido, LocalDefinido> _recuperarLocalDaBatida = await recuperarLocalDaBatida();
    if (_recuperarLocalDaBatida.isRight()) {
      //
      //================= LOCAL DEFINIDO =================
      //
      falhaNaLocalizacao.value = false;

      batidaFeitaEmLocalPermitido.value = true;
      localDaBatida = await _recuperarLocalDaBatida.fold((l) => null, (LocalDefinido local) => local);
    } else {
      //
      //=============== SEM LOCAL DEFINIDO ===============

      batidaFeitaEmLocalPermitido.value = false;
      localDaBatida = await _recuperarLocalDaBatida.fold((LocalNaoDefinido local) => local, (r) => null);
      await _tratarBatidaSemLocalDefinido(localDaBatida);
    }
  }

  Future _tratarBatidaSemLocalDefinido(LocalNaoDefinido local) async {
    ///Verificar se houve falhas na obtencao da localizacao
    if (local.falhaNaLocalizacao != null) {
      falhaNaLocalizacao.value = true;
      //Exibir popup
    }
  }
}

///Classe retornda ao concluir o processo de inicialização do modulo
class InititalizeFinish {}

enum PageState {
  initial,
  loading,
  loadingCompleted,
  // loadingFail,
}
