import 'package:custom_app/lib.imports.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ptem2/core/ponto_virtual/ponto_virtual.imports.dart';
import 'package:ptem2/hybrid/hybrid.imports.dart';

import '../../../app.imports.dart';
import 'presentation.imports.dart';
import 'package:custom_app/clean-arch/components/clean_app_bar_page/clean_app_bar_page.imports.dart';
import 'package:custom_components/app_bars/app_bars.imports.dart';

import 'widgets/widgets.imports.dart';

class BatidasPontoViewV2 extends StatefulWidget {
  Future Function() onClickQrButton;

  BatidasPontoViewV2({
    @required this.onClickQrButton,
  });

  //------------------------------------------ BUILD ------------------------------------------

  @override
  _BatidasPontoViewV2State createState() => _BatidasPontoViewV2State();
}

class _BatidasPontoViewV2State extends State<BatidasPontoViewV2> with WidgetsBindingObserver {
  BatidasPontoController moduleController = BatidasPontoController();
  double h;
  double w;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  bool comesFromPaused = false;

  bool detached = false;
  bool paused = false;
  BuildContext _context;
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // print("ATUAL STATE: " + state.toString());
    // print("DETACHED: " + detached.toString());
    // print("PAUSED: " + paused.toString());
    if (state == AppLifecycleState.resumed) {
      if (comesFromPaused == true) {
        print("####################### APLICATIVO FOI ABERTO #######################");
        moduleController.appFoiRetomado();
      }
      comesFromPaused = false;
      detached = false;
      paused = false;
    } else if (state == AppLifecycleState.inactive) {
      var point = "";
      //INACTIVE
    } else if (state == AppLifecycleState.paused) {
      print("####################### APLICATIVO MINIMIZADO #######################");
      var point = "";
      moduleController.appFoiMinimizado();
      comesFromPaused = true;
      paused = true;
      //PAUSED
    } else if (state == AppLifecycleState.detached) {
      detached = true;
      //DETACHED
    }
  }

  @override
  Widget build(BuildContext context) {
    h = MediaQuery.of(context).size.height / 100;
    w = MediaQuery.of(context).size.width / 100;

    bool showFloatButton = true;

    if (VariaveisGlobais.instance.batePonto == false) {
      showFloatButton = false;
    }

    return CleanAppBarPage(
      onClickFloatButton: () async {
        moduleController.startRegistrarPonto();
      },
      onClickRightButton: widget.onClickQrButton,
      showFloatButton: showFloatButton,
      cleanAppBarData: CleanAppBarData(
        title: "Hoje",
        layout: CleanAppBarLayout(
          activeBackButton: false,
          activeRightButtonCollapsed: true,
        ),
      ),
      body: body(context),
    );
  }

  Widget body(BuildContext context) {
    return Obx(
      () {
        ListState listState = PontoVirtual.instance.pontoPessoal.listState.value;

        //---------------- LOADING ----------------

        if (listState == ListState.loading) {
          return loading();
        }

        //----------------- LISTA -----------------

        if (listState == ListState.loaded) {
          return ListaBatidas();
        }

        //Qualquer outro estado, retorna loading
        return loading();
      },
    );
  }

  Widget loading() {
    return CleanBody(
      child: Center(
        child: Container(
          width: w * 100,
          height: (h * 100 - (h * 16.5)) - 50,
          color: Colors.transparent,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircularProgressIndicator(
                backgroundColor: Colors.white,
                valueColor: AlwaysStoppedAnimation<Color>(AppController.instance.style.colors.primary),
              ),
              SizedBox(height: h * 10),
            ],
          ),
        ),
      ),
    );
  }
}
