import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../app.imports.dart';

//Defini o estilo do popup
class PopupStyle {
  double borderRadius;
  Widget buttonOk;
  Widget buttonCancel;
  TextStyle styleText;
  TextStyle styleTitle;
  PopupStyle({
    this.borderRadius,
    this.buttonOk,
    this.buttonCancel,
    this.styleText,
    this.styleTitle,
  });
}

//Model usado quando não foi passado um PopupStyle customizado
class PopupDefaultStyle {
  //
}

enum PopupType {
  NoButton, //// Popup sem botão
  OkButton, //// Popup com botão de OK
  ReplyButtons, ///// Popup com botões de resposta ( OK e Cancelar )
}

class NoButton {}

class OkButton {}

class ReplyButtons {}

class CustomButtom {
  String textButton1;
  String textButton2;
  CustomButtom({
    this.textButton1,
    this.textButton2,
  });
}

//========================================================================================= MASTER CLASS =========================================================================================
//=================================================================================================================================================================================================

class Popup {
  //commit
  ///[OBS1: Transformar essa classe em single instance]
  ///[=================== VARIAVEIS ===================]
  AppController appController = AppController.instance;

  PopupStyle popupStyle = PopupStyle(
    borderRadius: 10.0,
  );

  PopupType type;

  BuildContext _dialogContext;

  bool closeDialogOnPressButton = true; //// Indica se deve fechar o popup ao clicar em um dos botões
  Widget customWidget;

  bool blocked = false; //// Quando for true, o popup não é fechado ao clicar fora dele e não é exibido o botao de fechar

  //---- TEXTOS -----

  String txtTitle;
  String txtText;

  //---- FUNCTIONS ON CLICK ----
  String txtBtnOk;
  String txtBtnCancel;
  Function onClickOk;
  Function onClickCancel;

  var h;
  var w;

  //----- ICONE -----

  bool hasIcon = true;
  IconData icon;

  BuildContext context;

  ///[=================== CONSTRUTOR ===================]
  Popup({
    @required this.type,
    this.onClickOk,
    this.onClickCancel,
    this.closeDialogOnPressButton,
    this.txtText,
    this.txtTitle,
    this.hasIcon,
    this.icon,
    this.txtBtnOk,
    this.txtBtnCancel = "Cancelar",
    this.customWidget,
    this.context,
    this.blocked,
  }) {
    if (closeDialogOnPressButton == null) closeDialogOnPressButton = true;
    if (hasIcon == null) hasIcon = true;
    if (icon == null) icon = FontAwesomeIcons.exclamationCircle;
    if (context == null) context = Get.context;
    if (blocked == null) blocked = false;
  }

  ///[================================================== METODOS ==================================================]
  ///[=============================================================================================================]
  Future closePopup() async {}

  ///[------------------------------------ SHOW POUP ------------------------------------]
  Future show({Function(BuildContext context) retrievePopupContext}) async {
    return await showDialog(
      barrierDismissible: true,
      context: context,
      builder: (BuildContext context) {
        h = MediaQuery.of(context).size.height / 100;
        w = MediaQuery.of(context).size.width / 100;

        if (retrievePopupContext != null) retrievePopupContext(context);

        _dialogContext = context;
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
                    if (blocked == false) Navigator.pop(_dialogContext);
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
                          borderRadius: BorderRadius.circular(popupStyle.borderRadius),
                          color: Colors.white,
                          // color: Colors.green,
                        ),
                        //-----------------------------------------
                        child: Padding(
                          padding: EdgeInsets.only(top: h * 0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              //[------------------------------------------ CONTEUDO POPUP ------------------------------------------]

                              ///--- BOTAO FECHAR POPUP ---

                              blocked
                                  ? Container(
                                      height: 40,
                                    )
                                  : Container(
                                      width: w * 100,
                                      height: 40,
                                      child: Row(
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(left: w * 4, top: w * 4),
                                            child: GestureDetector(
                                              onTap: () {
                                                Navigator.pop(_dialogContext);
                                              },
                                              child: Icon(
                                                Icons.close,
                                                color: Colors.grey[300],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),

                              ///--------- ICON ---------
                              ///
                              hasIcon
                                  ? Container(
                                      margin: EdgeInsets.only(bottom: h * 3.2, top: h * 1),
                                      child: Icon(
                                        icon,
                                        size: w * 25,
                                        color: Colors.grey[200],
                                      ),
                                    )
                                  : Container(),

                              ///--------- TITULO ---------
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: w * 6.5),
                                child: Text(
                                  txtTitle,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w900,
                                    fontSize: 22,
                                    color: Colors.grey[800],
                                    fontFamily: "Nunito",
                                    // fontFamily: "NunitoBlack",

                                    // fontFamily: Style().fonts.op1,
                                    // color: Colors.black,
                                  ),
                                ),
                              ),

                              //ESPAÇAMENTO
                              SizedBox(height: h * 2.8),

                              ///--------- TEXTO ---------
                              ///
                              txtText != null
                                  ? Padding(
                                      padding: EdgeInsets.symmetric(horizontal: w * 5.5),
                                      child: Text(
                                        // "Ja existe um contato de emergencia utilizando esse número celular",
                                        txtText,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.grey[500],
                                          fontSize: 16.9.sp,
                                          fontFamily: Style().fonts.op1,
                                        ),
                                      ),
                                    )
                                  : Container(),

                              ///----- CUSTOM WIDGET -----
                              ///
                              customWidget != null ? customWidget : Container(),

                              ///-------- BUTTONS --------
                              Padding(
                                padding: EdgeInsets.only(top: h * 6.6),
                                child: makeButtonsArea(),
                              ),

                              //
                              //[----------------------------------------------------------------------------------------------------]
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
      return val;
    });
  }

  ///[------------------------------------ MAKE BUTTONS AREA ------------------------------------]
  Widget makeButtonsArea() {
    bool showCancel = false;
    bool showOk = false;

    // MainAxisAlignment mainAlign = MainAxisAlignment.center;
    if (type == PopupType.OkButton) {
      showOk = true;
      // mainAlign = MainAxisAlignment.center;
    } else if (type == PopupType.ReplyButtons) {
      // mainAlign = MainAxisAlignment.spaceBetween;
      showOk = true;
      showCancel = true;
    }

    if (txtBtnOk == null) txtBtnOk = "OK";

    return Container(
      width: w * 100,
      // color: Colors.red,
      margin: EdgeInsets.only(
        left: w * 4.2,
        right: w * 4.2,
        bottom: 7,
      ),
      child: Column(
        // mainAxisAlignment: mainAlign,
        children: [
          /// BOTAO OK
          showOk ? popupButton(text: txtBtnOk, bgColor: Style().colors.primary, textColor: Colors.white, onClick: onClickOk) : Container(),

          showCancel ? popupButton(text: txtBtnCancel, bgColor: Colors.grey[200], textColor: Colors.grey[600], onClick: onClickCancel) : Container(),
        ],
      ),
    );
  }

  ///[------------------------------------ WIDGET ------------------------------------]
  ///
  Widget popupButton({String text, Color bgColor, Color textColor, Function onClick}) {
    double btnWidth = 0;
    double marginBottom = 0;

    if (type == PopupType.OkButton) {
      btnWidth = w * 42.4;
      // marginBottom = w * 8;
      marginBottom = 10;
    } else if (type == PopupType.ReplyButtons) {
      btnWidth = w * 39.4;
      // marginBottom = w * 8;
      marginBottom = 10;
    }

    return Container(
      // height: h * 8,
      height: 53,
      margin: EdgeInsets.only(bottom: marginBottom),
      width: w * 100,
      child: RaisedButton(
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6.0)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: textColor,
                height: 1,
                fontSize: 17.2,
                // fontFamily: "OpenSans",
                fontFamily: "Nunito",
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        color: bgColor,
        onPressed: () async {
          if (closeDialogOnPressButton == true) Navigator.pop(_dialogContext);
          if (onClick != null) return await onClick();
        },
      ),
    );
  }
}
