import 'package:flutter/material.dart';
import 'package:flutter_screenutil/size_extension.dart';
import 'package:get/get.dart';
import 'package:numeric_keyboard/numeric_keyboard.dart';
import '../../../../../../lib.imports.dart' as lib;
import 'numeric_keyboard.controller.dart';
import 'presentation.imports.dart';

// class KeyboardPageView extends KeyboardView {
//   //
// }

class KeyboardView extends StatelessWidget {
  double h;
  double w;

  // keyboardPageController keyboardPageController = keyboardPageController();
  KeyboardPageController keyboardPageController;

  NumericKeyboardPreferences keyboardPreferences;

  KeyboardView({
    @required this.keyboardPreferences,
  }) {
    keyboardPageController = KeyboardPageController(preferences: this.keyboardPreferences);
  }

  @override
  Widget build(BuildContext context) {
    h = MediaQuery.of(context).size.height / 100;
    w = MediaQuery.of(context).size.width / 100;

    return Scaffold(
      backgroundColor: lib.TotemStyle().primaryColor,
      body: FutureBuilder(
          future: keyboardPageController.initialize(),
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
                                keyboardPreferences.title,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 26,
                                  fontFamily: "Nunito",
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),

                            keyboardPreferences.subtitle.isNotEmpty && keyboardPreferences.subtitle != ""
                                ? Padding(
                                    padding: EdgeInsets.only(left: w * 10, right: w * 10),
                                    child: Text(
                                      keyboardPreferences.subtitle,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.grey[300],
                                        fontSize: 18,
                                        fontFamily: "Nunito",
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  )
                                : Container(),

                            //------- CODE FIELD -------

                            Padding(
                              padding: EdgeInsets.only(top: h * 7),
                              child: CodeInputFieldV2(
                                keyboardPageController: keyboardPageController,
                              ),
                            ),

                            //---- NUMERIC KEYBOARD ----

                            Padding(
                              padding: EdgeInsets.only(top: h * 3.5),
                              child: Container(
                                width: w * 100,
                                child: NumericKeyboard(
                                  // marginZero:
                                  onKeyboardTap: keyboardPageController.typeNumber,
                                  textColor: Colors.white,
                                  rightButtonFn: keyboardPageController.deleteNumber,
                                  rightIcon: Icon(
                                    Icons.backspace,
                                    color: Colors.white,
                                    size: 32,
                                  ),
                                  leftButtonFn: () {
                                    // keyboardPageController.validarViaDigital();
                                    keyboardPreferences.leftButtonPreferences.onClick(keyboardPageController.finalCode);
                                    print('left button clicked');
                                  },
                                  leftIcon: keyboardPreferences.leftButtonPreferences != null
                                      ? Icon(
                                          keyboardPreferences.leftButtonPreferences.icon,
                                          color: Colors.white,
                                          size: 35,
                                        )
                                      : null,
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

class CodeInputFieldV2 extends StatelessWidget {
  double h;
  double w;

  KeyboardPageController keyboardPageController;

  CodeInputFieldV2({
    @required this.keyboardPageController,
  });

  @override
  Widget build(BuildContext context) {
    h = MediaQuery.of(context).size.height / 100;
    w = MediaQuery.of(context).size.width / 100;

    return Obx(() {
      List<String> valuesList = keyboardPageController.numberFieldsValues.value;

      KeyboardViewStateV2 state = keyboardPageController.keyboardViewState.value;

      if (keyboardPageController.type == NumericKeyboardType.definedValue) {
        //
        //---------------- VALOR DEFINIDO ----------------
        //
        List<Widget> fields = [];

        int i = 0;
        for (int i = 0; i < keyboardPageController.qtdDigits; i++) {
          fields.add(
            digitFieldObscure(valuesList[i], state),
          );
          //Se não for o ultimo campo, adiciona espacamento apos o campo
          if (i + 1 < keyboardPageController.qtdDigits) {
            fields.add(SizedBox(width: w * 2.4));
          }
          // i++;
        }

        return Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: fields,
        );
      } else {
        //
        //---------------- VALOR INDEFINIDO ----------------
        //
        // fields.add(Container());

        String stringValues = "";
        for (String value in valuesList) {
          stringValues = stringValues + value;
        }

        return Container(
          width: w * 100,
          // height: 60,
          margin: EdgeInsets.only(right: w * 12, left: w * 12),
          padding: EdgeInsets.only(top: h * 3.2, bottom: h * 3.2),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.05),
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
          child: Center(
            child: Text(
              stringValues,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 23.sp,
              ),
            ),
          ),
        );
      }
    });
  }

  //------------------------------------- MONTAR DIGITO  -------------------------------------

  Widget digitFieldObscure(String value, KeyboardViewStateV2 state) {
    //
    //Widget de preenchimento do campo
    Widget fillWidget = Container();

    Color borderColor = Colors.white;

    //AGUARDANDO ESTADO (SEM ESTADO)
    if (state == KeyboardViewStateV2.waiting) {
      if (value == "") {
        fillWidget = Container();
      } else {
        fillWidget = fillContainer(color: Colors.white);
      }
    }
    //ESTADO DE ERRO ( NÃO AUTENTICADO )
    if (state == KeyboardViewStateV2.error) {
      borderColor = Colors.red[600];
      fillWidget = fillContainer(color: Colors.red[700]);
    }
    //ESTADO DE SUCESSO ( AUTENTICADO )
    if (state == KeyboardViewStateV2.success) {
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
