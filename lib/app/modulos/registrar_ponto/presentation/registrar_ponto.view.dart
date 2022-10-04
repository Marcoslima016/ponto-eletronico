// import 'package:custom_app/lib.imports.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../lib.imports.dart';
import '../../../app.imports.dart';
import '../registrar_ponto.imports.dart';

class RegistrarPontoView extends StatefulWidget {
  //

  @override
  State<RegistrarPontoView> createState() => _RegistrarPontoViewState();
}

class _RegistrarPontoViewState extends State<RegistrarPontoView> with WidgetsBindingObserver {
  //
  PontoVirtual pontoVirtualController = PontoVirtual.instance;
  PageRegistrarPontoController controller = PageRegistrarPontoController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  bool comesFromPaused = false;
  bool detached = false;
  bool paused = false;
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      if (comesFromPaused == true) {
        Get.back();
      }
      comesFromPaused = false;
      detached = false;
      paused = false;
    } else if (state == AppLifecycleState.inactive) {
      //INACTIVE
    } else if (state == AppLifecycleState.paused) {
      comesFromPaused = true;
      paused = true;
    } else if (state == AppLifecycleState.detached) {
      detached = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height / 100;
    var w = MediaQuery.of(context).size.width / 100;
    AppController.instance.deviceInfo.screenInfo.width = w;
    AppController.instance.deviceInfo.screenInfo.height = h;
    controller.viewContext = context;

    return FutureBuilder(
      future: controller.initModule(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          //-------------------------------------------------- CONTEUDO DA PAGINA ----------------------------------------------------

          return Content(
            controller: this.controller,
          );
        } else {
          //-------------------------------------------------------- LOADING ----------------------------------------------------------

          return Container(
            height: h * 80,
            width: w * 100,
            decoration: BoxDecoration(
              color: Colors.white,
              // borderRadius: BorderRadius.all(Radius.circular(12)),
              borderRadius: BorderRadius.only(topLeft: Radius.circular(14), topRight: Radius.circular(14)),
            ),
            child: Stack(
              children: [
                //----------- Barra de minimização (apenas visual) -----------
                Positioned(
                  top: h * 1.8,
                  child: Container(
                    width: w * 100,
                    child: Row(
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
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(right: w * 7, left: w * 7),
                  width: w * 100,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: h * 18),
                      Container(
                        width: w * 14,
                        height: w * 14,
                        child: CircularProgressIndicator(
                          backgroundColor: Colors.white,
                          strokeWidth: 5.4,
                          valueColor: AlwaysStoppedAnimation<Color>(AppController.instance.style.colors.primary),
                        ),
                      ),
                      SizedBox(height: h * 6),
                      Text(
                        "Carregando dados",
                        style: TextStyle(
                          color: Colors.grey[700],
                          fontSize: h * 3.5,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: h * 3.6),
                      Text(
                        "Carregando informações necessárias \n para registrar ponto",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.grey[300],
                          fontSize: h * 2.3,
                        ),
                      ),
                      SizedBox(height: h * 7),
                      // Text(
                      //   "*Esse processo pode demorar um pouco devido a conexão de internet.",
                      //   textAlign: TextAlign.center,
                      //   style: TextStyle(
                      //     color: Colors.grey[350],
                      //     fontSize: h * 2.4,
                      //   ),
                      // ),
                      SizedBox(height: h * 7),
                      Obx(
                        () {
                          String txtEstagioCarregamento = controller.txtEstagioCarregamento.value;
                          return Text(
                            txtEstagioCarregamento,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: h * 2.4,
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }
      },
    );
  }
}
