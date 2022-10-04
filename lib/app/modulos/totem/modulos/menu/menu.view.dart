import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../../../../lib.imports.dart';
import '../../../../app.imports.dart';

class MenuView extends StatelessWidget {
  double w;
  double h;

  MenuController controller = MenuController();

  @override
  Widget build(BuildContext context) {
    // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    //   statusBarColor: Colors.red,
    //   statusBarIconBrightness: Brightness.dark,
    // ));
    h = MediaQuery.of(context).size.height / 100;
    w = MediaQuery.of(context).size.width / 100;
    return WillPopScope(
      onWillPop: () async {
        Get.off(TotemController.instance.usecaseTotemCore.homePage);
        return false;
      },
      child: Scaffold(
        backgroundColor: Colors.grey[100],
        appBar: AppBar(
          systemOverlayStyle: SystemUiOverlayStyle(
            // statusBarColor: Colors.green, // <-- SEE HERE
            // statusBarIconBrightness: Brightness.dark, //<-- For Android SEE HERE (dark icons)
            statusBarBrightness: Brightness.light, //<-- For iOS SEE HERE (dark icons)
          ),
          elevation: 0,
          backgroundColor: Colors.transparent,
          leading: Container(
            margin: EdgeInsets.only(left: w * 5.2),
            child: GestureDetector(
              onTap: () {
                // Get.back();
                Get.off(TotemController.instance.usecaseTotemCore.homePage);
              },
              child: Icon(Icons.arrow_back),
            ),
          ),
        ),
        body: FutureBuilder(
          future: controller.init(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Stack(
                children: [
                  Positioned(
                    top: h * 1,
                    child: Container(
                      width: w * 100,
                      child: Center(
                        child: Container(
                          width: w * 68,
                          child: Image.asset("assets/assets_ptem2/images/logo.png"),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: w * 100,
                    height: h * 100,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // SizedBox(height: h * 6),
                        //============================ LINHA 1 ============================
                        Container(
                          width: w * 100,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              //
                              //----------- SINCRONIZACAO -----------
                              //
                              menuButton(
                                Icons.sync,
                                "Sincronização",
                                () {
                                  Get.to(SyncListView());
                                },
                              ),
                              SizedBox(width: w * 6.5),

                              //------- RECONHECIMENTO FACIAL -------
                              //
                              menuButton(
                                Icons.face_retouching_natural,
                                "Reconhecimento Facial",
                                () {
                                  controller.onTapReconhecimentoFacial();
                                },
                              ),
                              // menuButton(Icons.import_export, "Exportar", () {}),
                            ],
                          ),
                        ),

                        // SizedBox(height: h * 15),

                        //============================ LINHA 2 ============================

                        SizedBox(height: w * 6.5),

                        Container(
                          width: w * 100,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              //
                              //------- DISCONNECT TOTEM -------
                              //
                              menuButton(Icons.exit_to_app, "Sair", () {
                                TotemController.instance.disconnectTotem();
                              }),
                              SizedBox(width: w * 6.5),
                              Container(
                                width: w * 40,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  //================================ VERSAO DO APP ================================

                  Positioned(
                    bottom: 15,
                    child: Container(
                      width: w * 100,
                      child: Text(
                        "Versão: " + controller.appVersion,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 19.sp,
                          color: Colors.grey[400],
                        ),
                      ),
                    ),
                  ),
                ],
              );
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }

  //------------------------------------------ WIDGET MENU BUTTON ------------------------------------------

  Widget menuButton(IconData icon, String text, Function() onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: w * 40,
        height: w * 40,
        // color: Colors.grey[200],
        decoration: decoration(8.0),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: h * 2),
              Icon(
                icon,
                size: w * 16,
                // color: AppController.instance.style.colors.primary,
                color: Color(0xFF007CBA).withOpacity(1.0),
              ),
              SizedBox(height: h * 1.5),
              Text(
                text,
                textAlign: TextAlign.center,
                style: TextStyle(
                  // color: AppController.instance.style.colors.primary,
                  color: Color(0xFF007CBA).withOpacity(1.0),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

BoxDecoration decoration(double borderRadius) {
  //------ Ajustar sombra ------
  //Sombra 1
  double offset1 = 4;
  //Sombra 1
  // double offset2 = 7;
  double offset2 = 4;
  //opacidade
  double opacity = 0.08;

  return BoxDecoration(
    border: Border.all(color: Colors.white.withOpacity(0.3)),
    color: Colors.grey[100],
    borderRadius: BorderRadius.all(
      Radius.circular(borderRadius),
    ),
    boxShadow: [
      BoxShadow(
        offset: Offset(offset1, offset1),
        color: Color(0xFF4D70A6).withOpacity(opacity),
        blurRadius: 6,
      ),
      BoxShadow(
        offset: Offset(-offset2, -offset2),
        color: Color.fromARGB(
          170,
          255,
          255,
          255,
        ),
        blurRadius: 6,
      ),
    ],
  );
}
