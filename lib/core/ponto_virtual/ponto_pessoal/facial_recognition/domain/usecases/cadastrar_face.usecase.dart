import '../../../../../../lib.imports.dart';
import '../../../../../core.imports.dart';
import '../../../ponto_pessoal.imports.dart';
import 'package:flutter_recognize/src/src.imports.dart' as recognize;

abstract class ICadastrarFace {
  Future call();
}

class CadastrarFace implements ICadastrarFace {
  //

  ILocalStorageDriver cacheStorageDriver = SharedPreferencesDriver();

  Future call() async {
    // bool codeValidated = await runCodeValidation();
    bool codeValidated = true;
    if (codeValidated) {
      await Future.delayed(const Duration(milliseconds: 600), () {});
      await CustomLoad().show();
      await Future.delayed(const Duration(milliseconds: 600), () {});

      //Ler coordenadas do rosto
      List prediction = await recognize.FlutterRecognize.instance.register();

      await Future.delayed(const Duration(milliseconds: 300), () async {
        await CustomLoad().hide();
      });

      if (prediction.isNotEmpty) {
        //Salvar prediction do usuario (coordenadas do rosto)
        bool saveUserSuccess = await saveUserPrediction(prediction);
        if (saveUserSuccess) {
          //Exibir popup  de sucesso
          await Popup(
            closeDialogOnPressButton: true,
            type: PopupType.OkButton,
            hasIcon: false,
            blocked: true,
            txtTitle: "Concluído",
            txtText: "Cadastro realizado com sucesso. Agora você pode realizar batidas via reconhecimento facial.",
            txtBtnOk: "Continuar",
          ).show();
        }
      }
    }
  }

  Future runCodeValidation() async {
    bool codeValidated = await PopupValidationCode().show();
    return codeValidated;
  }

  Future<bool> saveUserPrediction(List prediction) async {
    UserRecognizePonto user = UserRecognizePonto(
      id: 0,
      prediction: prediction,
      timestampLastDetection: 0,
    );

    try {
      await cacheStorageDriver.put(key: "recognize_user", value: user.toJson());
    } catch (e) {
      return false;
    }
    FacialRecognitionPontoPessoalController.instance.userRecognize = user;

    return true;
  }
}
