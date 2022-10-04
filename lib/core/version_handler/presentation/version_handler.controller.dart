import 'package:ptem2/hybrid/hybrid.imports.dart';

import '../../../lib.imports.dart';
import '../version_handler.imports.dart';

class VersionHandlerController {
  //

  bool appBlocked = false;

  bool active = false;

  ICheckCompatibility checkCompatibility;

  static final VersionHandlerController instance = VersionHandlerController._(); //// Armazena a instancia utilizada no singleton
  VersionHandlerController._() {
    checkCompatibility = CheckCompability(
      repository: VersionHandlerRepository(
        datasource: VersionHandlerFirebaseDatasource(),
      ),
    );
  }

  Future checkVersionCompatibility() async {
    if (!active) {
      appBlocked = false;
      return;
    }

    bool compatible = await checkCompatibility();
    if (compatible) {
      appBlocked = false;
    } else {
      appBlocked = true;
    }
  }

  //Roda o processo que deve ser executado quando o app não esta com uma versao compativel ( por exemplo exibir popup que bloqueia o uso)
  bool messageSent = false;
  Future runBlockedProcess() async {
    if (!active) return;
    if (messageSent) return;

    ///Bloqueia funcionalidade se não estiver logado no usuario de teste
    if (VariaveisGlobais.instance.email != "trabalhador1@compliancesolucoes.com.br" && VariaveisGlobais.instance.email != "LUCASSAMPSOUZA@GMAIL.COM") {
      return;
    }

    messageSent = true;
    await Future.delayed(const Duration(milliseconds: 1500), () {});

    if (appBlocked == true) UpdateRequisitionView().show();
  }
}
