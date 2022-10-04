import '../../../../lib.imports.dart';

//// Tarefa disparada ao inicializar o app (autenticado)
/// - Essa tarefa ira inicializar o PontoVitual
///

abstract class IAuthenticatedInit {
  //
}

class AuthenticadeInit implements IAuthenticatedInit {
  Future call() async {
    // 1. Iniciar PontoVirtual
    // await PontoVirtual.instance.turnOn();
    await PontoVirtual.instance.pontoPessoal.inicializar();
  }
}
