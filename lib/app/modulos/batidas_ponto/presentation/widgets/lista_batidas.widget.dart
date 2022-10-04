import 'package:custom_app/clean-arch/clean-arch.imports.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../lib.imports.dart';
import 'widgets.imports.dart';

class ListaBatidas extends StatelessWidget {
  double w;
  double h;

  ListaBatidas() {}

  //======================================================= REMOVER DUPLICADAS =======================================================

  bool removendoDuplicadas = false;

  Future<List<Batida>> removerDuplicadas(List<Batida> batidas) async {
    //
    removendoDuplicadas = true;

    while (removendoDuplicadas) {
      int indexDuplicada = await identificarDuplicadas(batidas);
      if (indexDuplicada != null) {
        List<Batida> novaLista = await removerBatidaDaLista(batidas, indexDuplicada);
        batidas = novaLista;
      } else {
        removendoDuplicadas = false;
      }
    }

    return batidas;
  }

  //IDENTIFICAR DUPLICADAS
  Future<int> identificarDuplicadas(List<Batida> batidas) async {
    List<String> hrList = [];
    int i = 0;
    for (Batida batida in batidas) {
      for (String hr in hrList) {
        if (batida.hr == hr) {
          return i;
        }
      }
      hrList.add(batida.hr);
      i++;
    }
    return null;
  }

  //REMOVER BATIDA DA LISTA
  Future<List<Batida>> removerBatidaDaLista(List<Batida> batidas, int index) async {
    batidas.removeAt(index);
    return batidas;
  }

  //========================================================== WIDGET BUILD ==========================================================

  @override
  Widget build(BuildContext context) {
    h = MediaQuery.of(context).size.height / 100;
    w = MediaQuery.of(context).size.width / 100;

    return Obx(
      () {
        List<Batida> batidasList = PontoVirtual.instance.pontoPessoal.batidasDoDia.value;
        List<Batida> finalBatidasList = [];
        for (Batida batida in batidasList) finalBatidasList.add(batida);
        finalBatidasList.removeWhere((Batida item) => item.dateExpired == true); //// Remover batidas expiradas

        return FutureBuilder(
          future: removerDuplicadas(finalBatidasList),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              finalBatidasList = snapshot.data;

              if (finalBatidasList.length > 0) {
                return CleanListBody(
                  listBuilder: (context, index) {
                    if (index < finalBatidasList.length) {
                      //
                      //----------------------------------- CARD BATIDA ---------------------------------
                      //
                      // return CardBatida(index);
                      return listItemConstructor(index, finalBatidasList);
                    } else {
                      return Container(
                        height: h * 18,
                      ); //// ???
                    }
                  },
                  listLenght: finalBatidasList.length,
                );
              } else {
                ///------------------------------------- LIST EMPTY -------------------------------------
                ///
                return CleanBody(
                  child: Center(
                    child: Container(
                      margin: EdgeInsets.only(left: w * 15, right: w * 15),
                      width: w * 100,
                      height: (h * 100 - (h * 16.5)) - 50,
                      color: Colors.transparent,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.watch_later_outlined,
                            color: Colors.grey[300],
                            size: h * 7.2,
                          ),
                          SizedBox(height: h * 2),
                          Text(
                            "Você ainda não marcou seu ponto hoje",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.grey[300],
                              fontSize: h * 2.6,
                            ),
                          ),
                          SizedBox(height: h * 10),
                        ],
                      ),
                    ),
                  ),
                );
              }
            } else {
              //snapshot sem valor:
              return CleanBody(
                child: Container(),
              );
            }
          },
        );
      },
    );
  }

  //- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

  ///Futuramente esse metodo deve ficar dentro da camada presentation do ponto virtual, para poder ficar acessivel
  ///a diferentes modulos que trabalham com lista
  Widget listItemConstructor(int index, List<Batida> batidasList) {
    List<Widget> widgetsList = [];

    //ADICIONA CARD DA BATIDA
    widgetsList.add(
      CardBatida(index, batidasList),
    );

    //ADICIONA INTERVALO DEPOIS DE CADA ITEM DE NUMERO PAR (SE NAO FOR O ULTIMO ITEM)
    if (index + 1 < batidasList.length) {
      if ((index + 1).isEven) {
        var dthr1 = batidasList[index].data + " " + batidasList[index].hr;
        var dthr2 = batidasList[index + 1].data + " " + batidasList[index + 1].hr;
        var datetime1 = DateTime.now().getdatebystring(dthr2);
        var datetime2 = DateTime.now().getdatebystring(dthr1);
        var intervalo = datetime1.differenceTime(datetime2);
        String txtDuracaoIntervalo = intervalo.split(":")[0] + ":" + intervalo.split(":")[1];

        widgetsList.add(
          Padding(
            padding: EdgeInsets.only(top: h * 3),
            child: Container(
              width: w * 100,
              height: h * 6.8,
              // color: Colors.grey[400],
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 2),
                    Text(
                      "Intervalo",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.grey[700],
                      ),
                    ),
                    SizedBox(height: 2),
                    Text(
                      "Duração: " + txtDuracaoIntervalo,
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      }
    }

    //ADICIONAR ESPACAMENTO NO ULTIMO ITEM
    if (index + 1 == batidasList.length) {
      widgetsList.add(
        Container(
          height: h * 18,
        ),
      );
    }

    //------------

    return Container(
      child: Column(
        children: widgetsList,
      ),
    );
  }
}
