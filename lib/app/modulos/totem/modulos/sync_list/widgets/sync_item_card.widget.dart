import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../../lib.imports.dart';

class SyncItemCard extends StatelessWidget {
  BatidaTotem itemBatida;
  double w;
  double h;

  SyncItemCard({
    @required this.itemBatida,
  });

  @override
  Widget build(BuildContext context) {
    h = MediaQuery.of(context).size.height / 100;
    w = MediaQuery.of(context).size.width / 100;
    var teste = itemBatida;
    var point = "";

    return Container(
      margin: EdgeInsets.only(top: h * 3.2, left: w * 3.8, right: w * 3.8),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        elevation: 8,
        //color: ColorsThemeApp.primaryColor.withOpacity(0.5),
        child: InkWell(
          borderRadius: BorderRadius.circular(5),
          child: Container(
            padding: EdgeInsets.only(left: 15, right: 15, top: 19, bottom: 19),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                //
                //----------------------------- NOME ---------------------------

                Text(
                  itemBatida.nome,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 20.sp,
                  ),
                ),

                //-------------------------- DATA / HORA ------------------------

                Padding(
                  padding: EdgeInsets.only(top: h * 2.5),
                  child: Text(
                    itemBatida.dthrBatida,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: Colors.grey[500],
                    ),
                  ),
                ),

                //-------------------------- INDICADOR DE ERRO ------------------------

                Obx(() {
                  return itemBatida.hasError.value
                      ? Container(
                          margin: EdgeInsets.only(top: h * 4),
                          child: Row(
                            children: [
                              Icon(
                                Icons.warning,
                                color: Colors.red,
                              ),
                              SizedBox(width: w * 1.2),
                              Text(
                                "FALHA NA SINCRONIZAÇÃO",
                                style: TextStyle(
                                  color: Colors.red,
                                ),
                              ),
                            ],
                          ),
                        )
                      : Container();
                }),

                //-------------------------- LOADING BAR ------------------------

                Padding(
                  padding: EdgeInsets.only(top: h * 4),
                  child: LinearProgressIndicator(
                      //value: controller.percent(index),
                      ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
