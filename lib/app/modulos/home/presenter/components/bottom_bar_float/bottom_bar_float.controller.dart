import 'package:custom_app/lib.imports.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BottomBarBackButtonWatcher implements BackButtonWatcher {
  BottomBarFloatController bottomBarFloatController;
  @override
  int index = 1;

  BottomBarBackButtonWatcher({
    this.bottomBarFloatController,
  });

  @override
  Future onBackButtonTap({@required bool returnRouteStatus}) async {
    if (returnRouteStatus == true) {
      if (bottomBarFloatController.navigateIndexHistoric.length > 1) {
        int historicLenght = bottomBarFloatController.navigateIndexHistoric.length;
        int tabTargetIndex = bottomBarFloatController.navigateIndexHistoric[historicLenght - 2];
        await bottomBarFloatController.backTo(tabTargetIndex);
        bottomBarFloatController.navigateIndexHistoric.removeLast();
        var teste = bottomBarFloatController.navigateIndexHistoric;

        return false;
      } else {
        return true;
      }
    }
    return true;
  }
}

///[========================================================== MODELS ===========================================================]
///[=============================================================================================================================]
class BottomBarFloatItem {
  var id;
  String btnText;
  IconData btnIcon;
  BottomBarFloatImgItem btnImage;
  Widget pageWidget;
  String pageId;
  BottomBarFloatItem({
    @required this.id,
    this.pageId,
    this.btnIcon,
    this.btnImage,
    this.btnText,
    @required this.pageWidget,
  }) {
    if (btnImage != null && btnIcon != null) throw ("Não pode ser passado um btnIcon junto com btnImage");
  }
}

class BottomBarFloatImgItem {
  Image btnImage;
  Image btnImageSelected;
  BottomBarFloatImgItem({
    @required this.btnImage,
    @required this.btnImageSelected,
  });
}

///[======================================================= MASTER CLASS ========================================================]
///[=============================================================================================================================]

class BottomBarFloatController extends GetxController {
  //
  ///[====================== VARIAVEIS ======================]
  int selectedIndex = 1;

  List<Widget> childrenList = List();

  Color selectedItemColor;

  BottomBarFloatItem btnCenter;
  BottomBarFloatItem btnLeft;
  BottomBarFloatItem btnRight;

  Function onChangePage;

  List navigateIndexHistoric = [
    1,
  ];

  BottomBarBackButtonWatcher bottomBarBackButtonWatcher;

  Future Function(BackButtonWatcher backButtonWatcher) setBackButtonWatcher;

  // LobbyController lobbyController;

  ///[====================== CONSTRUTOR ======================]

  BottomBarFloatController({
    @required this.selectedItemColor,
    this.btnCenter,
    this.btnRight,
    this.btnLeft,
    this.onChangePage,
    this.setBackButtonWatcher,
  }) {
    bottomBarBackButtonWatcher = BottomBarBackButtonWatcher(
      bottomBarFloatController: this,
    );
    if (setBackButtonWatcher != null) {
      setBackButtonWatcher(bottomBarBackButtonWatcher);
    }
  }

  ///[================================================== METODOS ==================================================]
  ///[=============================================================================================================]

  ///[----------------------------- ON TAP ITEM ----------------------------]
  ///
  Future onItemTapped(int index) async {
    navigateIndexHistoric.add(index);
    selectedIndex = index;
    update();
    onChangePage(index);
  }

  ///[----------------------------- BACK TO ----------------------------]
  //Retorna para uma aba especifica ( nao adiciona o index ao historico )

  Future backTo(int index) async {
    selectedIndex = index;
    update();
    onChangePage(index);
  }

  ///[-------------------------------- MOUNT -------------------------------]
  ///
  Future mount() async {
    childrenList.add(btnLeft.pageWidget);
    childrenList.add(btnCenter.pageWidget);
    childrenList.add(btnRight.pageWidget);
    onChangePage(1);
    return "ok";
  }
}
