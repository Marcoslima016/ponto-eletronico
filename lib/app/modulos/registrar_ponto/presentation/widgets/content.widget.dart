import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../lib.imports.dart';
import '../../../../app.controller.dart';
import '../../registrar_ponto.imports.dart';

class Content extends StatelessWidget {
  PontoVirtual pontoVirtualController = PontoVirtual.instance;
  PageRegistrarPontoController controller;

  Content({
    @required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height / 100;
    var w = MediaQuery.of(context).size.width / 100;

    return Container(
      width: w * 100,
      // height: h * 82,
      decoration: BoxDecoration(
        color: Colors.white,
        // borderRadius: BorderRadius.all(Radius.circular(12)),
        borderRadius: BorderRadius.only(topLeft: Radius.circular(14), topRight: Radius.circular(14)),
      ),
      child: Stack(
        children: [
          //

          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // SizedBox(height: h * 2),
              // Text("Registrar Ponto!!"),
              SizedBox(height: h * 1.5),

              //----------- Barra de minimização (apenas visual) -----------
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: w * 18,
                    height: h * 1.1,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.all(Radius.circular(4.5)),
                    ),
                  ),
                ],
              ),

              SizedBox(height: h * 3.5),

              //========================== LOCALIZACAO BATIDA ==============================

              controller.localizacaoBatidaView,

              SizedBox(height: h * 3),
              //

              //============================== CLOCK TIMER ==================================

              controller.clockTimerView,

              SizedBox(height: h * 0.6),

              SizedBox(height: h * 15),
              // SizedBox(height: h * 15),
            ],
          ),

          //============================= BOTAO REGISTRAR PONTO =============================
          Positioned(
            bottom: h * 3.2,
            child: Container(
              width: w * 100,
              child: Center(
                child: Container(
                  width: w * 88.9,
                  child: AppController.instance.components.buttons.primary(
                    onClick: () {
                      controller.onPressedRegistrarPonto();
                    },
                    text: "REGISTRAR PONTO",
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
