import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../../../lib.imports.dart';
import '../../../app.controller.dart';
import '../../template.imports.dart';

class AppBars {
//

  //==================================== APPBAR LOBBY ====================================

  PreferredSizeWidget appBarLobby({@required GlobalKey<ScaffoldState> scaffoldKey}) {
    if (scaffoldKey == null) throw ("ERRO: scaffoldKey não pode ser NULL ");

    return PreferredSize(
      preferredSize: Size.fromHeight(kToolbarHeight),
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black,
              offset: Offset(0, 2.0),
              blurRadius: 4.0,
            )
          ],
        ),
        child: AppBar(
          centerTitle: true,
          // elevation: 2,
          leading: Builder(builder: (BuildContext context) {
            return IconButton(
              icon: new Icon(FontAwesomeIcons.bars),
              color: Colors.white.withOpacity(0.3),
              onPressed: () => scaffoldKey.currentState.openDrawer(),
            );
          }),
          backgroundColor: Style().colors.secundary,
          title: Container(width: AppController.instance.deviceInfo.screenInfo.width * 42, child: Image.asset("assets/images/system/logo1.png")),
          actions: [
            // audioControl(),
          ],
        ),
      ),
    );
  }
}
