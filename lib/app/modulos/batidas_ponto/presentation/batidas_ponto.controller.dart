import '../../../../lib.imports.dart';
import '../../modulos.imports.dart';

class BatidasPontoController {
  //

  Future startRegistrarPonto() async {
    await showRegistrarPontoBottomSheet();
  }

  Future showRegistrarPontoBottomSheet() async {
    await RegistrarPonto().redirectToModule();
  }

  ///Recarrega a lista de batidas do dia, disparada principalmente quando o app volta do estado minimizado
  Future appFoiMinimizado() async {
    await PontoVirtual.instance.pontoPessoal.tratarAppMinimizado();
  }

  Future appFoiRetomado() async {
    await PontoVirtual.instance.pontoPessoal.tratarAppRetomado();
  }
}
