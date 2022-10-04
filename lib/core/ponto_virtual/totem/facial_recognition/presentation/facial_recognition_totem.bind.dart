import 'package:get/get.dart';

import '../../totem.imports.dart';
import '../facial_recognition.imports.dart';

class FacialRecognitionTotemBind extends Bindings {
  @override
  void dependencies() {
    Get.put<IRegistrarColab>(
      RegistrarColab(
        usecaseEncontrarColabViaMatricula: Get.find<IEncontrarColabViaMatricula>(),
      ),
    );
  }
}
