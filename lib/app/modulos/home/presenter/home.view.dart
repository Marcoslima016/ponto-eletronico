import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ptem2/app/app.controller.dart';
import 'components/bottom_bar_float/bottom_bar_float.imports.dart';
import '../../../app.imports.dart';

class HomeViewV2 extends StatefulWidget {
  Widget page1;
  Widget page2;
  Widget page3;

  GlobalKey<ScaffoldState> scaffoldKey;

  Widget drawer;

  Future onWidgetBuild(BuildContext context) {}

  @override
  _HomeViewV2State createState() => _HomeViewV2State();
}

class _HomeViewV2State extends State<HomeViewV2> {
  ///[=============== VIEW WIDGET ===============]
  @override
  Widget build(BuildContext context) {
    // AppController.instance.versionHandler.runBlockedProcess(); //// Foi passado para a homeView da implementacao

    widget.onWidgetBuild(context);
    return Scaffold(
      key: widget.scaffoldKey,
      drawer: widget.drawer,
      extendBodyBehindAppBar: true,
      body: WillPopScope(
        //----------------------------- BACK BUTTON ----------------------------

        onWillPop: () async {
          print("!!!!!!!!!");

          //Tratamento de subpaginas:
          // bool returnRoute = await lobbyController.handleBackButton();

          // if (returnRoute == true) {
          //   //Tratamento da pagina:
          //   // int stackLength = await AppController.instance.navigation.stackLength();
          //   if (stackLength > 1) {
          //     //Retorna se houver mais de 1 item na pilha de widgets/rotas
          //     return false; /////[ <<<<<<<<<<<<<< ]
          //   } else {
          //     return false;
          //   }
          // }

          return false;
          // return returnRoute;
        },

        //-------------------------- BOTTOM BAR / PAGES -------------------------
        child: BottomBarFloat(
          setBackButtonWatcher: (backButtonWatcher) async {
            // lobbyController.setBackButtonWatcher(backButtonWatcher);
          },
          onChangePage: (int index) {
            // lobbyController.bottomBarAtualIndex = index;
          },
          backgroundColor: Style().colors.secundary,
          itemColor: Colors.grey[350],
          selectedItemColor: Style().colors.primary,
          // floatButtonBg: Colors.grey[300],
          floatButtonBg: Style().colors.secundary,
          floatButtonBgSelected: Style().colors.secundary,
          // floatButtonIconColor: Style().colors.primary,
          // floatButtonIconColorSelected: Style().colors.secundary,

          ///[------------  BOTAO CENTRAL ( FLOAT ) -----------]
          ///
          btnCenter: BottomBarFloatItem(
            // btnIcon: FontAwesomeIcons.pills,
            btnImage: BottomBarFloatImgItem(
              btnImage: Image.asset("assets/assets_ptem2/images/logo_desabilitado3.png"),
              btnImageSelected: Image.asset("assets/assets_ptem2/images/logo_bottom_bar.png"),
            ),
            id: "",
            pageWidget: widget.page2,
            pageId: "map",
          ),

          ///[---------------- BOTAO DA ESQUERDA ---------------]
          ///
          btnLeft: BottomBarFloatItem(
            // btnIcon: Icons.watch_later,
            btnIcon: FontAwesomeIcons.userClock,
            btnText: "Ponto",
            id: "",
            // pageWidget: DetalhesEventoView(),
            pageWidget: widget.page1,
            pageId: "pag-esquerda",
            // pageWidget: Container(),
          ),

          ///[----------------- BOTAO DA DIREITA ----------------]
          ///
          btnRight: BottomBarFloatItem(
            btnIcon: FontAwesomeIcons.chartBar,
            btnText: "Relatórios",
            id: "",
            pageWidget: widget.page3,
            pageId: "ranking",
          ),
        ),
      ),
    );
  }
}
