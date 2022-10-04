import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:numeric_keyboard/numeric_keyboard.dart';

import '../../../app.imports.dart';
import 'presentation.imports.dart';

class LockScreenView extends StatelessWidget {
  double h;
  double w;

  LockScreenController lockScreenController = LockScreenController();

  LockScreenView();

  @override
  Widget build(BuildContext context) {
    h = MediaQuery.of(context).size.height / 100;
    w = MediaQuery.of(context).size.width / 100;

    return Scaffold(
      backgroundColor: AppController.instance.style.colors.primary,
      body: FutureBuilder(
          future: lockScreenController.initialize(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Container(
                width: w * 100,
                height: h * 100,
                // color: Style().colors.primary,
                color: Colors.transparent,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Get.back();
                        },
                        child: Container(
                          width: w * 100,
                          height: h * 10,
                          margin: EdgeInsets.only(top: h * 4, left: h * 3.5),
                          child: Row(
                            children: [
                              Icon(
                                Icons.arrow_back,
                                color: Colors.white,
                              ),
                            ],
                          ),
                        ),
                      ),

                      //==================== BOX SUPERIOR ================
                      // Container(
                      //   width: w * 100,
                      //   height: h * 45,
                      //   // color: Style().colors.primary,
                      //   child: Column(
                      //     mainAxisAlignment: MainAxisAlignment.center,
                      //     children: [
                      //       Padding(
                      //         padding: EdgeInsets.only(top: h * 4),
                      //         child: Text(
                      //           "Senior Safer",
                      //           style: TextStyle(
                      //             // color: Style().colors.primary,
                      //             color: Style().colors.primary,
                      //             fontSize: h * 6.2,
                      //             fontWeight: FontWeight.bold,
                      //             fontFamily: Style().fonts.op1,
                      //           ),
                      //         ),
                      //       ),
                      //     ],
                      //   ),
                      // ),

                      //==================== FORM ================

                      Container(
                        width: w * 100,
                        height: h * 85,
                        // color: Style().colors.primary,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            //---- TEXTO ----

                            // SizedBox(height: h * 2.6),

                            Padding(
                              padding: EdgeInsets.only(left: w * 10, right: w * 10, bottom: h * 2.8),
                              child: Text(
                                "Digite seu PIN",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 26,
                                  fontFamily: "Nunito",
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),

                            Padding(
                              padding: EdgeInsets.only(left: w * 10, right: w * 10),
                              child: Text(
                                "Ou se preferir, utilize a leitura de digital",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.grey[300],
                                  fontSize: 18,
                                  fontFamily: "Nunito",
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),

                            //------- CODE FIELD -------

                            Padding(
                              padding: EdgeInsets.only(top: h * 8),
                              child: CodeInputField(
                                lockScreenController: lockScreenController,
                              ),
                            ),

                            //---- NUMERIC KEYBOARD ----

                            Padding(
                              padding: EdgeInsets.only(top: h * 4),
                              child: Container(
                                width: w * 100,
                                child: NumericKeyboard(
                                  // marginZero:
                                  onKeyboardTap: lockScreenController.typeNumber,
                                  textColor: Colors.white,
                                  rightButtonFn: lockScreenController.deleteNumber,
                                  rightIcon: Icon(
                                    Icons.backspace,
                                    color: Colors.white,
                                    size: 32,
                                  ),
                                  leftButtonFn: () {
                                    lockScreenController.validarViaDigital();
                                    print('left button clicked');
                                  },
                                  leftIcon: Icon(
                                    Icons.fingerprint,
                                    color: Colors.white,
                                    size: 35,
                                  ),
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                ),
                              ),
                            ),

                            SizedBox(height: h * 2),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            } else {
              return Container();
            }
          }),
    );
  }
}

///[=================================================== CODE INPUT FIELD ==================================================]
///[=======================================================================================================================]

class CodeInputField extends StatelessWidget {
  double h;
  double w;

  LockScreenController lockScreenController;

  CodeInputField({
    @required this.lockScreenController,
  });

  @override
  Widget build(BuildContext context) {
    h = MediaQuery.of(context).size.height / 100;
    w = MediaQuery.of(context).size.width / 100;

    return Obx(() {
      List<String> valuesList = lockScreenController.numberFieldsValues.value;

      KeyboardViewState state = lockScreenController.keyboardViewState.value;

      List<Widget> fields = [];

      int i = 0;
      for (int i = 0; i < lockScreenController.qtdDigits; i++) {
        fields.add(
          digitField(valuesList[i], state),
        );
        //Se não for o ultimo campo, adiciona espacamento apos o campo
        if (i + 1 < lockScreenController.qtdDigits) {
          fields.add(SizedBox(width: w * 2.4));
        }
        // i++;
      }

      return Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: fields,
      );
    });
  }

  //---------------------- MONTAR DIGITO ----------------------

  Widget digitField(String value, KeyboardViewState state) {
    //
    //Widget de preenchimento do campo
    Widget fillWidget = Container();

    Color borderColor = Colors.white;

    //AGUARDANDO ESTADO (SEM ESTADO)
    if (state == KeyboardViewState.waiting) {
      if (value == "") {
        fillWidget = Container();
      } else {
        fillWidget = fillContainer(color: Colors.white);
      }
    }
    //ESTADO DE ERRO ( NÃO AUTENTICADO )
    if (state == KeyboardViewState.error) {
      borderColor = Colors.red[600];
      fillWidget = fillContainer(color: Colors.red[700]);
    }
    //ESTADO DE SUCESSO ( AUTENTICADO )
    if (state == KeyboardViewState.success) {
      borderColor = Colors.green[600];
      fillWidget = fillContainer(color: Colors.green[800]);
    }

    return Container(
      width: w * 5.5,
      height: w * 5.5,
      decoration: BoxDecoration(
        // color: Colors.grey[800],
        // color: Color.fromRGBO(1, 68, 134, 1.0),
        borderRadius: BorderRadius.circular(200.0),
        border: Border.all(color: borderColor, width: 2.8),
      ),
      child: Center(
        child: fillWidget,
      ),
    );
  }

  //Container utilizado para preencher o circulo do digito. A cor a ser preenchida depende do estado
  Widget fillContainer({Color color}) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(200.0),
      ),
    );
  }
}
