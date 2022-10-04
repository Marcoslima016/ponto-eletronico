import 'package:flutter/material.dart';

import '../../localizacao_batida.imports.dart';

class LocalDaBatida extends StatelessWidget {
  ILocalDaBatida infoLocalDaBatida;

  bool batidaFeitaEmLocalPermitido;

  LocalDaBatida(
    this.infoLocalDaBatida,
    this.batidaFeitaEmLocalPermitido,
  );

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height / 100;
    double w = MediaQuery.of(context).size.width / 100;
    String txtLocal = "";
    if (batidaFeitaEmLocalPermitido) {
      LocalDefinido localDefinido = infoLocalDaBatida;
      txtLocal = localDefinido.nomeLocal;
    } else {
      txtLocal = "Não cadastrado";
    }

    //----------------------- FRAME -----------------------
    return Container(
      width: w * 100,
      child: Padding(
        // padding: EdgeInsets.only(left: w * 11, right: w * 11),
        padding: EdgeInsets.only(left: w * 10, right: w * 10),
        //
        //----------------------- WHITE BOX -----------------------
        child: Container(
          decoration: BoxDecoration(
            // borderRadius: BorderRadius.all(Radius.circular(8)),
            borderRadius: BorderRadius.all(Radius.circular(55)),
            // border: Border.all(color: Colors.grey[200]),
            boxShadow: [
              BoxShadow(
                color: Colors.grey[350].withOpacity(0.5), //color of shadow
                spreadRadius: 2, //spread radius
                blurRadius: 3, // blur radius
                offset: Offset(0, 0), // changes position of shadow
              )
            ],
            color: Colors.white.withOpacity(1),
          ),
          child: Padding(
            // padding: EdgeInsets.only(top: h * 3, bottom: h * 3, left: w * 4.5, right: w * 4.5),
            padding: EdgeInsets.only(top: h * 2, bottom: h * 2, left: w * 4, right: w * 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              // crossAxisAlignment: CrossAxisAlignment.spa,
              children: [
                // Icon(
                //   Icons.my_location_sharp,
                //   size: h * 4.2,
                //   color: Colors.grey,
                // ),
                // SizedBox(
                //   width: w * 2.5,
                // ),

                Container(
                  // color: Colors.blue,
                  width: w * 60,
                  child: Row(
                    children: [
                      Text(
                        "Local: ",
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: Colors.grey[800],
                          fontFamily: "Open Sans",
                        ),
                      ),
                      Container(
                        constraints: BoxConstraints(maxWidth: w * 44),
                        // color: Colors.red,
                        child: Text(
                          // "",
                          txtLocal,
                          // " aaaa aaaa aaaa aaaa aaaa aaaa aaaa aaaa aaaa aaaa aaaa aaaa",
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.grey[600],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // SizedBox(
                //   width: w * 1.5,
                // ),
                Icon(
                  Icons.info,
                  color: Colors.grey[300],
                  size: 25,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
