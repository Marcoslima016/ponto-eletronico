import 'package:custom_app/lib.imports.dart';
import 'package:flutter/material.dart';

class Style implements IStyleTheme {
  // AppController appController = AppController.instance;

  @override
  String name = "theme1";

  ///[============================== COLORS ==============================]

  @override
  ColorsPallets colors = ColorsPallets(
    primary: Color(0xFF01579B).withOpacity(1.0),
    // primary: Color(0xFF007CBA).withOpacity(1.0),
    secundary: Colors.white,
    bg1: Color.fromRGBO(25, 25, 25, 1.0),
  );

  ///[=============================== FONTS ===============================]

  @override
  FontOptions fonts = FontOptions(
    op1: "OpenSans",
    op2: "VarelaRound",
    op3: "Nexa",
    op4: "NunitoBlack",
    op5: "Nunito",
    op6: "NunitoExtraBold",
  );

  ///[========================== BOX DECORATIONS ==========================]

  @override
  BoxDecorationOptions boxDecorations = BoxDecorationOptions(
    //------------ OPCAO 1 ------------
    //
    op1: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(10),
        topRight: Radius.circular(10),
        bottomLeft: Radius.circular(10),
        bottomRight: Radius.circular(10),
      ),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.24),
          spreadRadius: 2.4,
          blurRadius: 10,
          offset: Offset(0, 3), // changes position of shadow
        ),
      ],
    ),
    //
    //------------ OPCAO 2 ------------
    //
    op2: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(10),
        topRight: Radius.circular(10),
        bottomLeft: Radius.circular(10),
        bottomRight: Radius.circular(10),
      ),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.3),
          spreadRadius: 2,
          blurRadius: 8,
          offset: Offset(0, 1), // changes position of shadow
        ),
      ],
    ),

    //------------ OPCAO 3 ------------
    //
    op3: BoxDecoration(
      color: Colors.white,
      border: Border.all(color: Colors.grey[200]),
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(10),
        topRight: Radius.circular(10),
        bottomLeft: Radius.circular(10),
        bottomRight: Radius.circular(10),
      ),
      boxShadow: [
        BoxShadow(
          color: Colors.grey[200].withOpacity(0.8),
          spreadRadius: 2,
          blurRadius: 5,
          offset: Offset(1.8, 1.8), // changes position of shadow
        ),
      ],
    ),

    //------------ OPCAO 4 ------------
    //
    op4: BoxDecoration(
      color: Colors.white,
      border: Border.all(color: Colors.grey[300].withOpacity(0.3)),
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(10),
        topRight: Radius.circular(10),
        bottomLeft: Radius.circular(10),
        bottomRight: Radius.circular(10),
      ),
      boxShadow: [
        BoxShadow(
          color: Colors.grey[400].withOpacity(0.4),
          spreadRadius: 0.2,
          blurRadius: 2.8,
          offset: Offset(1, 2), // changes position of shadow
        ),
      ],
    ),
  );
}
