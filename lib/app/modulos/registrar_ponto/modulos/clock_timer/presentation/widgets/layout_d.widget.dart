import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../app.imports.dart';
import '../presentation.imports.dart';

class LayoutD extends StatelessWidget {
  ClockTimerController controller;

  var h;
  var w;

  LayoutD({
    @required this.controller,
  });

  //======================================== BUILDER ========================================

  @override
  Widget build(BuildContext context) {
    h = MediaQuery.of(context).size.height / 100;
    w = MediaQuery.of(context).size.width / 100;

    String finalTime = "";

    return Obx(() {
      //-------------- DEFINIR VALOR HORARIO --------------
      String finalTime = "00:00";

      String _timeApart = controller.timeWithFuso.split(" ")[0];
      var _timeSplit = _timeApart.split(":");

      String hr = "00";
      String min = "00";

      if (_timeSplit.length >= 2) {
        finalTime = _timeSplit[0] + ":" + _timeSplit[1];
        hr = _timeSplit[0];
        min = _timeSplit[1];
      }

      //---------------- DEFINIR VALOR DATA ----------------

      String finalDate = "00/00";

      String completeDate = controller.currentDate;

      if (completeDate.split("/").length > 1) {
        finalDate = completeDate.split("/")[0] + "/" + completeDate.split("/")[1];
      }

      //------------------- MONTAR WIDGET -------------------

      return Padding(
        padding: EdgeInsets.only(left: w * 6, right: w * 6, top: h * 0.6, bottom: h * 0.6),
        child: Container(
          width: w * 100,
          padding: EdgeInsets.only(
            top: h * 2.6,
            bottom: h * 2.6,
            left: h * 1.8,
            right: h * 1.8,
          ),
          decoration: BoxDecoration(
            // color: AppController.instance.style.colors.primary.withOpacity(0.03),
            borderRadius: BorderRadius.all(Radius.circular(7)),
            // border: Border.all(color: Colors.grey[300]),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey[200].withOpacity(0.9), //color of shadow
                spreadRadius: 1, //spread radius
                blurRadius: 2, // blur radius
                offset: Offset(0, 0), // changes position of shadow
              )
            ],
          ),
          child: Column(
            children: [
              //------- PRIMEIRA LINHA -------
              row(
                value: finalTime,
                icon: Icons.alarm,
                valueFontSize: h * 3.1,
                editTxt: "Editar horário",
                onClickEdit: controller.editTime,
              ),

              //DIVIDER
              SizedBox(height: h * 1),
              Opacity(
                opacity: 0.6,
                child: Divider(),
              ),
              SizedBox(height: h * 1),

              //-------- SEGUNDA LINHA --------
              row(
                value: finalDate,
                icon: Icons.calendar_today,
                valueFontSize: h * 3.1,
                editTxt: "Editar data",
                onClickEdit: controller.editDate,
              ),
              // Divider(),
            ],
          ),
        ),
      );
    });
  }

  //============================================ WIDGET ROW ============================================

  Widget row({@required String value, @required IconData icon, @required double valueFontSize, @required String editTxt, @required Future Function() onClickEdit}) {
    return Container(
      width: w * 100,
      child: Row(
        // crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            child: Row(
              children: [
                //

                //-------------- ICONE --------------

                Padding(
                  padding: EdgeInsets.only(top: h * 0.1),
                  child: Icon(
                    icon,
                    size: h * 4.2,
                    // color: Colors.grey[300],
                    color: Colors.grey[400],
                  ),
                ),

                //------------- TXT VALOR -------------

                SizedBox(width: w * 3.4),
                Text(
                  value,
                  style: TextStyle(
                    // fontFamily: "OpenSans",
                    fontSize: valueFontSize,
                    color: Colors.grey[600],
                    // color: AppController.instance.style.colors.primary,
                    // fontWeight: FontWeight.w600,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),

          //------------- BOTAO EDITAR -------------

          // GestureDetector(
          //   onTap: () {
          //     onClickEdit();
          //   },
          //   child: Text(
          //     editTxt,
          //     style: TextStyle(
          //       fontSize: h * 2.2,
          //       color: Colors.grey[350],
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
