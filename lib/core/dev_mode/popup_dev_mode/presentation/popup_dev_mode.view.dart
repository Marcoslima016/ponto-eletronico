import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ptem2/app/app.imports.dart';

import '../../presentation/presentation.imports.dart';
import '../popup_dev_mode.imports.dart';

class PopupDevMode {
  double w;
  double h;

  DevModeController devModeController;

  PopupDevModeController controller;

  PopupDevMode({
    @required this.devModeController,
  }) {
    controller = PopupDevModeController(
      devModeController: this.devModeController,
      configOptions: [
        AppConfigProd(),
        AppConfigDev(),
        AppConfigTest(),
        AppConfigHML(),
      ],
    );
  }

  //====================================================== SHOW ======================================================

  Future show() async {
    return await showDialog(
      barrierDismissible: false,
      context: Get.context,
      builder: (BuildContext context) {
        h = MediaQuery.of(context).size.height / 100;
        w = MediaQuery.of(context).size.width / 100;

        return Dialog(
          insetPadding: EdgeInsets.zero,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          // contentPadding: EdgeInsets.zero
          elevation: 0,
          backgroundColor: Colors.black.withOpacity(0.5),
          child: Container(
            child: Stack(
              children: [
                ///[****************************** OUT TAP ****************************]
                ///
                GestureDetector(
                  onTap: () {
                    Navigator.pop(Get.context);
                  },
                  child: Container(
                    width: w * 100,
                    height: h * 100,
                    color: Colors.transparent,
                  ),
                ),

                ///[******************************** BODY ******************************]
                ///
                body(),
              ],
            ),
          ),
        );
      },
    ).then((val) {
      devModeController.popupOpen.value = false;
      return val;
    });
  }

  Widget body() {
    return Container(
      width: w * 100,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: w * 85,
            // height: h * 30,
            padding: EdgeInsets.only(
              left: w * 4.4,
              right: w * 4.4,
              // top: 6,
              top: w * 4,
              bottom: w * 4,
            ),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Dev Mode",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 21.sp,
                    color: Colors.grey[800],
                    fontFamily: "Nunito",
                  ),
                ),
                Text(
                  "Configurações de desenvolvedor",
                  // textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 17.sp,
                    color: Colors.grey,
                    fontFamily: "Nunito",
                  ),
                ),

                SizedBox(height: 4),

                Divider(),
                //

                SizedBox(height: 20),

                Text(
                  "Ambiente",
                  // textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 19.sp,
                    color: Colors.grey[800],
                    fontFamily: "Nunito",
                  ),
                ),

                SizedBox(height: 4),

                //Radio Options
                FutureBuilder(
                  future: controller.mountRadioOptions(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      List<RadioOption> radioOptions = snapshot.data;
                      List<Widget> optionsRows = [];
                      for (RadioOption option in radioOptions) {
                        optionsRows.add(
                          radioRow(
                            displayTxt: option.displayText,
                            optionValue: option.value,
                          ),
                        );
                      }

                      return Column(children: optionsRows);
                    } else {
                      return Container();
                    }
                  },
                ),

                // radioRow(displayTxt: 'Dev', optionValue: 'Dev'),
                // radioRow(displayTxt: 'Teste', optionValue: 'Teste'),
                // radioRow(displayTxt: 'Produção', optionValue: 'Prod'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget radioRow({String displayTxt, String optionValue}) {
    return Obx(() {
      return Row(
        children: [
          Radio<String>(
            fillColor: MaterialStateColor.resolveWith((states) => const Color(0xFF01579B)),
            focusColor: MaterialStateColor.resolveWith((states) => const Color(0xFF01579B)),
            activeColor: Colors.grey[700],
            value: optionValue,
            groupValue: controller.currentRadioValue.value,
            // groupValue: "Dev",
            onChanged: (String value) {
              controller.onSelectAmbienteOption(value);
              // controller.selectAtualValue.value = optionValue;
              // controller.onSelectOption();
            },
          ),
          Text(displayTxt),
        ],
      );

      // return Row(
      //   children: [
      //     Radio<String>(
      //       fillColor: MaterialStateColor.resolveWith((states) => const Color(0xFF01579B)),
      //       focusColor: MaterialStateColor.resolveWith((states) => const Color(0xFF01579B)),
      //       activeColor: Colors.grey[700],
      //       value: optionValue,
      //       // groupValue: controller.selectAtualValue.value,
      //       groupValue: "teste1",
      //       onChanged: (String value) {
      //         // controller.selectAtualValue.value = optionValue;
      //         // controller.onSelectOption();
      //       },
      //     ),
      //     Text(displayTxt),
      //   ],
      // );
    });
  }
}
