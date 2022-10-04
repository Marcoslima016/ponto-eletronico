import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../lib.imports.dart';

class CustomLoad {
  // BuildContext loadContext;

  LoadContext loadContext = LoadContext.instance;

  ///[=================== EXIBIR LOAD ===================]

  Future show() async {
    showDialog(
      context: Get.context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        double h = MediaQuery.of(context).size.height / 100;
        double w = MediaQuery.of(context).size.width / 100;

        loadContext.context = context;
        return Dialog(
          elevation: 0,
          backgroundColor: Colors.transparent,
          child: new Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: w * 21,
                height: w * 21,
                margin: EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                child: Center(
                  child: new CircularProgressIndicator(
                    backgroundColor: Colors.transparent,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      AppController.instance.style.colors.primary,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
    await Future.delayed(const Duration(milliseconds: 600), () {});
  }

  ///[==================== FECHAR LOAD ====================]

  Future hide() async {
    if (loadContext.context == null) return;
    await Navigator.pop(loadContext.context);
    loadContext.context = null;
    // await Navigator.pop(Get.context);
  }
}

class LoadContext {
  //
  static final LoadContext instance = LoadContext._();
  BuildContext context;
  LoadContext._({
    this.context,
  }) {}
}
