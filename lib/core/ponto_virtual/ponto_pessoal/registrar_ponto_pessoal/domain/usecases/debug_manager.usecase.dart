import '../../../ponto_pessoal.imports.dart';

class DebugManager {
  // PontoPessoalDebugController debugController = PontoPessoalDebugController.instance;

  Future notificarInicioDoProcesso() async {
    // debugController.inicioProcessoDeBatida();
  }

  Future notificarTrabalhadorValidado() async {
    // debugController.trabalhadorValidado();
  }

  Future notificarContabilizarIniciado(RegistroBatida dadosNovaBatida) async {
    // debugController.iniciadoContabilizar(dadosNovaBatida);
  }

  Future notificarStatusDeBatidaJaExistenteNoHorario(bool status) async {
    // debugController.statusBatidaJaExistenteNoHorario(status: status);
  }

  Future notificarConcluindoContabilizar() async {
    // debugController.concluidoContabilizar();
  }
}
