import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../../../app.imports.dart';

class ListaDeMotivos extends StatelessWidget {
  ConfirmEditDateTimeController controller;

  double w;
  double h;

  ListaDeMotivos({
    @required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    h = MediaQuery.of(context).size.height / 100;
    w = MediaQuery.of(context).size.width / 100;

    return Expanded(
      child: Obx(() {
        return ListView.builder(
          shrinkWrap: true,
          itemCount: controller.motivos.length,
          itemBuilder: (context, index) {
            return Obx(() {
              Motivo item = controller.motivos[index];

              //----------------------------- CARD MOTIVO -----------------------------

              ///--- DEFINICAO DE OPCOES DE CORES ---
              ///
              Color unselectTitleColor = Colors.grey[400];
              Color selectedTitleColor = AppController.instance.style.colors.primary;
              FontWeight unselectTitleWeight = FontWeight.normal;
              FontWeight selectedTitleWeight = FontWeight.w700;

              Color unselectBorderColor = Colors.grey[300];
              Color selectedBorderColor = AppController.instance.style.colors.primary;
              double unselectBorderWidth = 1.0;
              double selectedBorderWidth = 2.5;

              //-- DEFINIR CORES COM BASE NO ITEM ESTAR SELECIONADO --

              Color titleColor = unselectTitleColor;
              FontWeight titleWeight = unselectTitleWeight;
              if (item.selected.value == true) {
                titleColor = selectedTitleColor;
                titleWeight = selectedTitleWeight;
              }

              Color borderColor = unselectBorderColor;
              double borderWidth = unselectBorderWidth;
              if (item.selected.value == true) {
                borderColor = selectedBorderColor;
                borderWidth = selectedBorderWidth;
              }

              //--- MONTAR WIDGET DO CARD ---

              return GestureDetector(
                onTap: () {
                  controller.onSelectMotivo(motivoIndex: item.index);
                },
                child: Container(
                  width: w * 100,
                  // height: h * 10.8,
                  margin: EdgeInsets.only(
                    top: h * 3,
                    // left: w * 4,
                    // right: w * 4,
                  ),
                  padding: EdgeInsets.only(top: h * 3.2, bottom: h * 3.2),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: borderColor,
                      width: borderWidth,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  child: Center(
                    child: Text(
                      item.title,
                      style: TextStyle(
                        fontFamily: "OpenSans",
                        fontSize: 21.sp,
                        color: titleColor,
                        fontWeight: titleWeight,
                      ),
                    ),
                  ),
                ),
              );
            });
          },
        );
      }),
    );
  }
}
