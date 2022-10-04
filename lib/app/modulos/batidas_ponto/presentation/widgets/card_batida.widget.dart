import 'package:flutter/material.dart';

import '../../../../../lib.imports.dart';
import 'indicador_tipo_batida.widget.dart';
import 'widgets.imports.dart';

class CardBatida extends StatelessWidget {
  int itemIndex;
  double w;
  double h;

  List<Batida> batidasList;

  CardBatida(
    this.itemIndex,
    this.batidasList,
  );

  // static definirTipoDeEventoDaBatida(int itemIndex) {
  //   String finalText = "";

  //   var newIndex = itemIndex % 2 == 0 ? (((itemIndex + 1) / 2) + 0.5).toInt() : (((itemIndex) / 2) + 0.5).toInt();
  //   newIndex = newIndex == 0 ? 1 : newIndex;

  //   if (itemIndex % 2 == 0) {
  //     finalText = '$newIndexª Entrada';
  //   } else {
  //     finalText = '$newIndexª Saída';
  //   }

  //   return finalText;
  // }

  @override
  Widget build(BuildContext context) {
    h = MediaQuery.of(context).size.height / 100;
    w = MediaQuery.of(context).size.width / 100;

    return Padding(
      padding: EdgeInsets.only(top: h * 3, left: w * 5.1, right: w * 5.1),
      child: Container(
        width: w * 100,
        //_________________ DECORATION _________________
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey[200]),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
            bottomLeft: Radius.circular(10),
            bottomRight: Radius.circular(10),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey[200].withOpacity(0.8),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(1.8, 1.8), // changes position of shadow
            ),
          ],
        ),
        //_____________________________________________
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: h * 2.8, horizontal: w * 3.8),
          child: Container(
            // color: Colors.grey[300],
            child: Row(
              children: [
                //------------------------------- ICONE - INDICADOR TIPO DE EVENTO -------------------------------

                // TipoDeEvento(itemIndex: this.itemIndex),

                //- - - - -
                Container(
                  width: w * 63,
                  // color: Colors.red,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          //------------------------------- ICONE - INDICADOR TIPO DE EVENTO -------------------------------

                          TipoDeEvento(
                            itemIndex: this.itemIndex,
                            batidasList: this.batidasList,
                          ),

                          //------------------------------ INDICADOR EVENTO DA BATIDA ------------------------------

                          EventoBatida(
                            itemIndex: this.itemIndex,
                            batidasList: this.batidasList,
                          ),

                          //----------------------------------- INDICADOR OFFLINE -----------------------------------

                          IndicadorOffline(
                            itemIndex: this.itemIndex,
                            batidasList: this.batidasList,
                          ),
                        ],
                      ),

                      //------------------------------------------- LOCAL -------------------------------------------

                      LocalBatida(
                        itemIndex: this.itemIndex,
                        batidasList: this.batidasList,
                      ),

                      //----------------------------------- INDICADOR STATUS SYNC -----------------------------------

                      IndicadorSync(
                        itemIndex: this.itemIndex,
                        batidasList: this.batidasList,
                      ),
                    ],
                  ),
                ),
                //- - - - -

                Spacer(),

                //--------------------------------------- INDICADOR DE HORARIO ---------------------------------------

                HorarioBatida(
                  itemIndex: this.itemIndex,
                  batidasList: this.batidasList,
                ),
                // Container(
                //   width: w * 8,
                //   height: w * 8,
                //   color: Colors.blue,
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
