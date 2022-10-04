import 'package:custom_app/lib.imports.dart';
import 'package:custom_app/no-arch/custom_app/custom_app.config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../clock_timer.imports.dart';
import 'confirm_edit.imports.dart';

class ConfirmEditDateTimeView extends StatelessWidget {
  ConfirmEditDateTimeController controller;

  // Future Function(EditConfirmed editConfirmedResult) editConfirmed;
  // Future Function() editCanceled;

  double w;
  double h;

  ConfirmEditDateTimeView(
      // {
      //  @required this.editConfirmed,
      //  @required this.editCanceled,
      // }
      ) {
    controller = ConfirmEditDateTimeController(
        // editCanceled: this.editCanceled,
        // editConfirmed: this.editConfirmed,
        );
  }

  @override
  Widget build(BuildContext context) {
    h = MediaQuery.of(context).size.height / 100;
    w = MediaQuery.of(context).size.width / 100;
    return Scaffold(
      body: Container(
        // padding: EdgeInsets.only(left: w * 6, right: w * 6),
        child: Stack(
          children: [
            Container(height: h * 100),

            //------------------- BOTÃO VOLTAR -------------------
            Positioned(
              top: h * 5.5,
              left: w * 5.6,
              child: GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: Icon(Icons.arrow_back_ios, color: Colors.grey[350]),
              ),
            ),

            //COLUNA DO CONTEUDO
            Container(
              height: h * 82,
              padding: EdgeInsets.only(left: w * 6, right: w * 6),
              child: Column(
                children: [
                  SizedBox(height: h * 10.5),

                  //---------------------------------- TITULO / SUB TITULO ----------------------------------
                  Text(
                    "Motivo da alteração de horário/data",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      // fontFamily: "OpenSans",
                      // fontSize: h * 6,
                      fontSize: 26.sp,
                      color: Colors.grey[800],
                      fontWeight: FontWeight.w600,
                      height: 1.4.sp,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: h * 3.5),
                    child: Text(
                      "É preciso apresentar um motivo para realizar batidas fora do horário/data atual",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: "OpenSans",
                        fontSize: 18.sp,
                        color: Colors.grey[400],
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),

                  //-------------------------------------- LISTA DE MOTIVOS --------------------------------------

                  SizedBox(height: h * 1),

                  ListaDeMotivos(
                    controller: this.controller,
                  ),

                  // listaDeMotivos(),
                ],
              ),
            ),

            //--------------------------------------- BOTAO CONFIRMAR ---------------------------------------

            Obx(() {
              bool motivoSelecionado = controller.motivoFoiSelecionado.value;
              return Positioned(
                bottom: h * 3.4,
                child: Container(
                  width: w * 100,
                  padding: EdgeInsets.only(left: w * 6, right: w * 6),
                  child: Column(
                    children: [
                      Container(
                        width: w * 100,
                        height: h * 8.8,
                        child: CustomAppConfig.instance.appController.components.buttons.primary(
                          text: "Continuar",
                          onClick: motivoSelecionado ? controller.concluir : null,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
