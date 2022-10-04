import 'package:custom_app/no-arch/custom_app/mobile/back_button_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import '../../../core.imports.dart';

import 'bottom_bar_float.controller.dart';

class BottomBarFloat extends StatelessWidget {
  //
  ///[=================== VARIAVEIS ===================]
  ///

  BottomBarFloatController bottomBarController;

  Future futureFunction;

  BottomBarFloatItem btnCenter;
  BottomBarFloatItem btnLeft;
  BottomBarFloatItem btnRight;

  Color itemColor;
  Color selectedItemColor;
  Color backgroundColor;
  Color floatButtonBg;
  Color floatButtonBgSelected;
  Color floatButtonIconColor;
  Color floatButtonIconColorSelected;

  Function onChangePage;

  ///[=================== CONSTRUTOR ===================]

  BottomBarFloat({
    @required this.selectedItemColor,
    this.itemColor,
    this.backgroundColor,
    this.floatButtonBg,
    this.btnCenter,
    this.btnRight,
    this.btnLeft,
    this.floatButtonBgSelected,
    this.floatButtonIconColor,
    this.floatButtonIconColorSelected,
    this.onChangePage,
    Future Function(BackButtonWatcher backButtonWatcher) setBackButtonWatcher,
  }) {
    bottomBarController = BottomBarFloatController(
      btnCenter: btnCenter,
      btnRight: btnRight,
      btnLeft: btnLeft,
      selectedItemColor: selectedItemColor,
      onChangePage: onChangePage,
      setBackButtonWatcher: setBackButtonWatcher,
    );
    futureFunction = bottomBarController.mount();

    if (backgroundColor == null) backgroundColor = Colors.grey[100];
    if (itemColor == null) itemColor = Colors.grey[100];
    if (floatButtonBg == null) floatButtonBg = Colors.grey[100];
    if (floatButtonBgSelected == null) floatButtonBgSelected = Colors.grey[100];
    if (floatButtonIconColor == null) floatButtonIconColor = Colors.grey[100];
    if (floatButtonIconColorSelected == null) floatButtonIconColorSelected = Colors.grey[100];
  }

  ///[================================================== METODOS ==================================================]
  ///[=============================================================================================================]

  var h;
  var w;

  @override
  Widget build(BuildContext context) {
    h = MediaQuery.of(context).size.height / 100;
    w = MediaQuery.of(context).size.width / 100;

    return GetBuilder<BottomBarFloatController>(
      init: bottomBarController,
      builder: (bottomBarController) {
        //
        Widget childBtnCenter;
        if (btnCenter.btnIcon != null) {
          childBtnCenter = Icon(
            btnCenter.btnIcon,
            color: bottomBarController.selectedIndex == 1 ? floatButtonIconColorSelected : floatButtonIconColor,
          );
        }
        if (btnCenter.btnImage != null) {
          childBtnCenter = Container(
            child: bottomBarController.selectedIndex == 1 ? btnCenter.btnImage.btnImageSelected : btnCenter.btnImage.btnImage,
          );
        }

        return Scaffold(
          ///[======================== BODY ========================]
          ///[======================================================]
          ///
          backgroundColor: Colors.transparent,
          extendBody: true,
          body: Center(
            child: IndexedStack(
              index: bottomBarController.selectedIndex,
              children: bottomBarController.childrenList,
            ),
          ),

          ///[==================== FLOAT BUTTON ====================]
          ///[======================================================]
          ///
          floatingActionButton: Container(
            width: w * 19,
            height: w * 19,
            margin: EdgeInsets.only(bottom: h * 0.01, right: w * 0.30, left: w * 0.30),
            decoration: BoxDecoration(
              color: bottomBarController.selectedIndex == 1 ? floatButtonBgSelected : floatButtonBg,
              borderRadius: BorderRadius.all(
                Radius.circular(200),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey[200].withOpacity(0.12),
                  spreadRadius: 0.8,
                  blurRadius: 6,
                  offset: Offset(0, -0),
                ),
              ],
            ),
            child: FloatingActionButton(
              backgroundColor: bottomBarController.selectedIndex == 1 ? floatButtonBgSelected : floatButtonBg,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: childBtnCenter,
              ),
              onPressed: () {
                bottomBarController.onItemTapped(1);
              },
            ),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

          // bottomNavigationBar: bottomBarController.bottomNavigationWidget,

          ///[============================================== BOTTOM BAR ==============================================]
          ///[========================================================================================================]
          ///
          bottomNavigationBar: Stack(
            children: [
              ///-------- CAMADA DE SOMBRA -------
              Container(
                height: 50,
                decoration: ShapeDecoration(
                  color: Colors.transparent,
                  shape: MyBorderShape(),
                  shadows: [
                    BoxShadow(
                      color: Colors.grey[400].withOpacity(0.2),
                      spreadRadius: 0.1,
                      blurRadius: 9,
                      offset: Offset(0, -3),
                    ),
                  ],
                ),
              ),

              ///-------- CAMADA BOTTOM BAR -------
              Container(
                color: Colors.transparent,
                child: BottomAppBar(
                  color: backgroundColor,
                  // elevation: 10,
                  // shape: CircularNotchedRectangle(),
                  shape: CircularNotchedRectangle(),
                  clipBehavior: Clip.antiAlias,
                  // shape: AutomaticNotchedShape(
                  //   RoundedRectangleBorder(),
                  //   // StadiumBorder(side: BorderSide()),
                  // ),
                  notchMargin: 7,
                  child: Container(
                    height: 50,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        ///[========================= BOTTOM BAR BTN 1 ========================]

                        bottomNavBtn(btnIndex: 0, btnIcon: btnLeft.btnIcon, btnImage: btnLeft.btnImage, btnText: btnLeft.btnText),

                        ///[========================= BOTTOM BAR BTN 2 ========================]
                        ///
                        bottomNavBtn(btnIndex: 2, btnIcon: btnRight.btnIcon, btnImage: btnRight.btnImage, btnText: btnRight.btnText),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  ///[=================================== WIDGET BOTAO ===================================]
  ///[====================================================================================]

  Widget bottomNavBtn({@required int btnIndex, @required IconData btnIcon, @required BottomBarFloatImgItem btnImage, @required String btnText}) {
    double marginRight = 0;
    double marginLeft = 0;

    if (btnIndex == 0) marginLeft = w * 7.2;
    if (btnIndex == 2) marginRight = w * 5.8;

    return GetBuilder<BottomBarFloatController>(
      builder: (bottomBarController) {
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              width: marginLeft,
            ),
            MaterialButton(
              minWidth: 40,
              onPressed: () {
                bottomBarController.onItemTapped(btnIndex);
              },
              child: Container(
                // color: Colors.red,
                height: 50,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    //
                    Container(
                      width: w * 5.5,
                      height: w * 5.5,
                      margin: EdgeInsets.only(top: 5.5),
                      child: Stack(
                        children: [
                          ///[---- BADGE ----]
                          // Container(
                          //   width: w * 3,
                          //   height: w * 3,
                          //   decoration: new BoxDecoration(
                          //     shape: BoxShape.circle,
                          //     color: Colors.red,
                          //   ),
                          // ),

                          ///[----- ICON -----]
                          Icon(
                            btnIcon,
                            color: bottomBarController.selectedIndex == btnIndex ? selectedItemColor : itemColor,
                            size: w * 5.5,
                          ),
                        ],
                      ),
                    ),

                    ///[----- TEXT -----]

                    Padding(
                      padding: EdgeInsets.only(top: 1.8, bottom: 0.5),
                      child: Text(
                        btnText,
                        style: TextStyle(
                          fontSize: 12.4,
                          color: bottomBarController.selectedIndex == btnIndex ? selectedItemColor : itemColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              width: marginRight,
            ),
          ],
        );
      },
    );
  }
}

class MyBorderShape extends ShapeBorder {
  MyBorderShape();

  @override
  EdgeInsetsGeometry get dimensions => EdgeInsets.zero;

  @override
  Path getInnerPath(Rect rect, {TextDirection textDirection}) => null;

  double holeSize = 102;

  @override
  Path getOuterPath(Rect rect, {TextDirection textDirection}) {
    print(rect.height);
    return Path.combine(
      PathOperation.difference,
      Path()
        ..addRRect(RRect.fromRectAndRadius(rect, Radius.circular(rect.height / 12)))
        ..close(),
      Path()
        ..addOval(Rect.fromCenter(center: rect.center.translate(0, -rect.height / 2), height: holeSize, width: holeSize))
        ..close(),
    );

    ///========================================================================
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection textDirection}) {}

  @override
  ShapeBorder scale(double t) => this;
}
