import 'package:custom_components/components.imports.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ptem2/app/app.controller.dart';

import 'validation_code_popup.controller.dart';

class ValidationCodePopupBody extends StatefulWidget {
  @override
  State<ValidationCodePopupBody> createState() => _ValidationCodePopupBodyState();
}

class _ValidationCodePopupBodyState extends State<ValidationCodePopupBody> {
  double w;
  double h;

  ValidationCodePopupController controller = ValidationCodePopupController();

  @override
  Widget build(BuildContext context) {
    h = MediaQuery.of(context).size.height / 100;
    w = MediaQuery.of(context).size.width / 100;

    return Container(
      width: w * 100,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: w * 85,
            // height: h * 30,
            padding: EdgeInsets.only(
              left: w * 4.4,
              right: w * 4.4,
              // top: 6,
              top: w * 4,
              bottom: w * 4,
            ),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: Form(
              key: controller.formKey,
              autovalidateMode: controller.autoValidate.last,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 35),

                  Text(
                    "Cadastro Reconhecimento facial",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 21.sp,
                      color: Colors.grey[800],
                      fontFamily: "Nunito",
                    ),
                  ),
                  // Text(
                  //   "Cadastre a sua face para começar a bater ponto via reconhecimento facial.",
                  //   // textAlign: TextAlign.center,
                  //   style: TextStyle(
                  //     fontSize: 17.sp,
                  //     color: Colors.grey,
                  //     fontFamily: "Nunito",
                  //   ),
                  // ),
                  //
                  SizedBox(height: 20),
                  //

                  Text(
                    "Para realizar o cadastro, você deve informar o código de confirmação, fornecido pela empresa onde você trabalha.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18.sp,
                      color: Colors.grey[600],
                      fontFamily: "Nunito",
                    ),
                  ),

                  //
                  SizedBox(height: 55),

                  //------------------------------------- FIELD CODE ------------------------------------

                  codeField(),

                  //------------------------------------- BTN AVANÇAR ------------------------------------

                  SizedBox(height: 75),

                  Container(
                    // height: h * 8,
                    height: 53,
                    margin: EdgeInsets.only(bottom: 0),
                    width: w * 100,
                    child: RaisedButton(
                      elevation: 0,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6.0)),
                      child: Text(
                        "Avançar",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          height: 1,
                          fontSize: 16.sp,
                          // fontFamily: "OpenSans",
                          fontFamily: "Nunito",
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      color: AppController.instance.style.colors.primary,
                      onPressed: () async {
                        controller.onTapAvancar();
                      },
                    ),
                  ),

                  //------------------------------------- BTN CANCELAR ------------------------------------

                  SizedBox(height: w * 7),

                  GestureDetector(
                    onTap: () {
                      Navigator.pop(Get.context, false);
                    },
                    child: Text(
                      "Cancelar",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: AppController.instance.style.colors.primary,
                        height: 1,
                        fontSize: 16.sp,
                        // fontFamily: "OpenSans",
                        fontFamily: "Nunito",
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),

                  SizedBox(height: w * 2),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget codeField() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextFieldOutline(
          preferences: TextFieldPreferences(
            txtValidate: "Informe o código",
            validation: NotEmptyValidation(
              validationFailTxt: "Informe o código",
              onValidationFail: (String value) {
                var p = "";
              },
            ),
            width: w * 55,
            isObscure: false,
            textStyle: TextStyleModel(
              textColor: Colors.grey[800],
              textSize: 14.sp,
            ),
            // textStyle: ,
            textFieldController: controller.codeInput,
            hintText: HintTextModel(
              hintTextColor: Colors.grey[400],
              hintText: "Código de confirmação",
              hintTextSize: 15.5.sp,
              hintTextStroke: 3.0,
            ),
            borderStyle: CustomBorderStyle(
              borderStroke: 1.2,
              enableBorderColor: Colors.grey[300],
              errorBorderColor: Colors.red,
              focusedBorderColor: AppController.instance.style.colors.primary,
            ),
            borderRadius: 6,
            // icon: icon,
          ),
        ),
      ],
    );
  }
}
