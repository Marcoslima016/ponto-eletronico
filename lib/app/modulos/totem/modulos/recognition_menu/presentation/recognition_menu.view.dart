import 'package:camera/camera.dart';
import 'package:custom_app/lib.imports.dart';
import 'package:flutter/material.dart';
import 'package:custom_components/app_bars/app_bars.imports.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ptem2/app/app.controller.dart';
import 'package:flutter_recognize/src/src.imports.dart';

import '../../../../../../lib.imports.dart';
import '../../../../../app.imports.dart';

class RecognitionMenuView extends StatelessWidget {
  double w;
  double h;
  @override
  Widget build(BuildContext context) {
    h = MediaQuery.of(context).size.height / 100;
    w = MediaQuery.of(context).size.width / 100;
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        centerTitle: false,
        titleSpacing: 0,
        title: Text(
          "Reconhecimento Facial",
          style: TextStyle(
            // fontFamily: Style().fonts.op1,
            fontFamily: Style().fonts.op1,
            color: Colors.grey[800],
            fontSize: 23.sp,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
      body: Container(
        width: w * 100,
        padding: EdgeInsets.only(left: w * 6, right: w * 6),
        child: SingleChildScrollView(
          child: Column(
            children: [
              //----------------------------------------------- CARD OPCOES TOTEM ---------------------------------------------

              menuCard(
                tituloCard: "Modo Totem",
                menuOptions: [
                  //
                  //---------- REGISTRAR COLAB ----------

                  menuOption(
                    txt: "Registrar Colaborador",
                    onClick: () {
                      TotemController.instance.facialRecognition.registrarColab();
                    },
                  ),

                  //----------- POSICAO CAMERA -----------

                  Obx(
                    () {
                      CameraLensDirection cameraLensDirection = FlutterRecognize.instance.cameraDirection.last;
                      String txtPos = "";
                      if (cameraLensDirection == CameraLensDirection.back) {
                        txtPos = "Traseira";
                      } else if (cameraLensDirection == CameraLensDirection.front) {
                        txtPos = "Frontal";
                      }

                      return menuOption(
                        onClick: () {
                          FlutterRecognize.instance.changeCameraDirection();
                        },
                        txt: "Posição Câmera",
                        value: txtPos,
                      );
                    },
                  ),

                  //-------------- CALIBRAR --------------

                  // menuOption(txt: "Calibrar", onClick: () {}),
                ],
              ),

              //------------------------------------------- CARD OPCOES APP TRABALHADOR ----------------------------------------

              // menuCard(
              //   tituloCard: "App do Trabalhador",
              //   menuOptions: [
              //     menuOption(txt: "Registrar Colaborador", onClick: () {}),
              //   ],
              // ),
            ],
          ),
        ),
      ),
    );
  }

  //============================================================= WIDGETS =============================================================
  //===================================================================================================================================

  //-------------------------------------------- MENU CARD --------------------------------------------

  Widget menuCard({@required List<Widget> menuOptions, @required String tituloCard}) {
    List<Widget> optionsList = [];

    //Montar lista de botoes
    int i = 0;
    for (Widget option in menuOptions) {
      i++;
      optionsList.add(option);
      if (i < menuOptions.length) optionsList.add(Divider());
    }

    //Widget
    return Container(
      width: w * 100,
      // height: h * 38,
      margin: EdgeInsets.only(top: h * 5),
      padding: EdgeInsets.only(top: w * 4, right: w * 5, left: w * 5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(9.4),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //-- TITULO --
          Text(
            tituloCard,
            style: TextStyle(
              fontFamily: Style().fonts.op1,
              color: Colors.grey[800],
              fontSize: 20.sp,
              fontWeight: FontWeight.w800,
            ),
          ),

          SizedBox(height: h * 1.6),

          //-- BOTOES --
          Column(
            children: optionsList,
          ),

          SizedBox(height: h * 1.6),
        ],
      ),
    );
  }

  //------------------------------------------- MENU OPTION --------------------------------------------

  Widget menuOption({@required String txt, @required Function() onClick, Widget rightWidget, String value}) {
    if (rightWidget == null) {
      rightWidget = Icon(
        Icons.arrow_forward_ios_rounded,
        color: Colors.grey[400],
        size: 19.sp,
      );
    }
    return GestureDetector(
      onTap: onClick,
      child: Container(
        width: w * 100,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // SizedBox(height: h * 3),
            // Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                //------------ TEXTO -----------
                Container(
                  padding: EdgeInsets.only(top: h * 1.5, bottom: h * 1.5),
                  child: Text(
                    txt,
                    style: TextStyle(
                      // fontFamily: Style().fonts.op1,
                      color: Colors.grey[900],
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),

                Row(
                  children: [
                    //------------ VALOR -----------

                    value != null
                        ? Padding(
                            padding: EdgeInsets.only(right: 5),
                            child: Text(
                              value,
                              style: TextStyle(
                                // fontFamily: Style().fonts.op1,
                                color: Colors.grey[400],
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          )
                        : Container(),

                    //---- RIGHT WIDGET (BOTAO) ----

                    rightWidget,
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
