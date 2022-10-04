import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_version/new_version.dart';
import '../../app.imports.dart';

class UpdateRequisitionView {
  //commit
  ///[OBS1: Transformar essa classe em single instance]
  ///[=================== VARIAVEIS ===================]
  AppController appController = AppController.instance;

  var h;
  var w;

  BuildContext context;

  ///[=================== CONSTRUTOR ===================]
  UpdateRequisitionView() {}

  ///[================================================== METODOS ==================================================]
  ///[=============================================================================================================]
  Future closePopup() async {
    print("FECHAR POPUP!!!!!");
  }

  ///[------------------------------------ SHOW POUP ------------------------------------]
  Future show() async {
    return await showDialog(
      barrierDismissible: true,
      context: Get.context,
      builder: (BuildContext context) {
        h = MediaQuery.of(context).size.height / 100;
        w = MediaQuery.of(context).size.width / 100;

        AppController.instance.deviceInfo.screenInfo.width = w;
        AppController.instance.deviceInfo.screenInfo.height = h;

        return Dialog(
          insetPadding: EdgeInsets.zero,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          // contentPadding: EdgeInsets.zero
          elevation: 0,
          backgroundColor: Colors.transparent,
          child: Container(
            child: Stack(
              children: [
                ///[****************** OUT TAP ****************]
                GestureDetector(
                  onTap: () {
                    // if (blocked == false) Navigator.pop(_dialogContext);
                  },
                  child: Container(
                    width: w * 100,
                    height: h * 100,
                    color: Colors.transparent,
                  ),
                ),

                ///[*******************************************]
                Container(
                  width: w * 100,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        //----------- POPUP WINDOW STYLE ----------
                        width: w * 90,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.white,
                          // color: Colors.green,
                        ),
                        //-----------------------------------------
                        child: Padding(
                          padding: EdgeInsets.only(top: h * 0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              //[=============================================== CONTEUDO POPUP ===============================================]

                              //

                              //--------------------- TITULO -------------------

                              Container(
                                width: w * 100,
                                height: h * 21.2,
                                decoration: BoxDecoration(
                                  color: AppController.instance.style.colors.primary.withOpacity(1.0),
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(12),
                                    topLeft: Radius.circular(12),
                                  ),
                                  border: Border.all(color: AppController.instance.style.colors.primary.withOpacity(1.0)),
                                  // color: Color(0xFF01579B),
                                  // color: Colors.blue,
                                ),
                                padding: EdgeInsets.only(right: w * 8, left: w * 8),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Atualizar",
                                      style: TextStyle(
                                        // color: Colors.white,
                                        color: Color(0xFF00345b),
                                        fontSize: 36.sp,
                                        fontFamily: Style().fonts.op3,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      "Nova versão",
                                      style: TextStyle(
                                        // color: Colors.white,
                                        color: Color(0xFF00345b).withOpacity(0.6),
                                        fontSize: 22.sp,
                                        fontFamily: Style().fonts.op3,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              //--------------------- CONTEUDO -------------------
                              Container(
                                padding: EdgeInsets.only(right: w * 6, left: w * 6, bottom: w * 6),
                                child: Column(
                                  children: [
                                    SizedBox(height: h * 6),
                                    Text(
                                      "Esta disponível uma nova versão com importantes alterações e melhorias. Para continuar usando o app, você deve atualizar para a versão mais recente.",
                                      style: TextStyle(
                                        color: Colors.grey[400],
                                        fontSize: 18.2.sp,
                                      ),
                                    ),
                                    SizedBox(height: h * 8),
                                    Container(
                                      width: w * 100,
                                      child: AppController.instance.components.buttons.primary(
                                        onClick: () {
                                          final newVersion = NewVersion(
                                              // iOSId: 'br.com.vertechit.ptem',
                                              // iOSId: '1490109095',
                                              // androidId: 'br.com.vertechit.ptem',
                                              );
                                          newVersion.showAlertIfNecessary(context: context);
                                        },
                                        text: "Atualizar",
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              //
                              //[==============================================================================================================]
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    ).then((val) {
      // tapClose();
    });
  }
}
