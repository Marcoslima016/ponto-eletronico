import 'package:get/get.dart';

/// Solução "quebra-alha", adotada com o objetivo de resgatar variaveis que estao presenter na aplicação e que
/// precisam ser utilizadas pelo ptem2.0
class VariaveisGlobais {
  //
  static final VariaveisGlobais instance = VariaveisGlobais._(); //// Armazena a instancia utilizada no singleton
  VariaveisGlobais._() {}

  //---------------- PIN ----------------

  List<int> pin = [];
  int pinLenght = 0;

  //----------- DADOS USUARIO -----------

  String token = "";
  String email;
  String nome;
  RxString rxNome = "".obs;
  int grempId = 0;
  bool batePonto = true; 
}
