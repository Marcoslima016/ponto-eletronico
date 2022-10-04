import 'package:custom_app/lib.imports.dart';
import 'package:custom_components/custom_components.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../lib.imports.dart';
import 'components.dart';

class TextFields extends TextFieldComponents {
  //

  double componentsWidth = 82;

  ///[======================================== PRIMARY ========================================]

  ICustomTextField primary({
    @required TextEditingController textController,
    @required String hintText,
    String textValidate,
    bool isObscure,
    List<TextInputFormatter> formatters,
    TextCapitalization textCapitalization,
    double width,
    bool isRequired,
    ITextFieldValidation validation,
  }) {
    return TextFieldNoborder(
      preferences: TextFieldPreferences(
        textCapitalization: textCapitalization,
        formatters: formatters,
        width: AppController.instance.deviceInfo.screenInfo.width * componentsWidth,
        isObscure: isObscure,
        textStyle: TextStyleModel(
          textColor: Colors.grey[300],
          textSize: AppController.instance.deviceInfo.screenInfo.width * 6,
        ),
        // textStyle: ,

        textFieldController: textController,
        hintText: HintTextModel(
          hintTextColor: Colors.grey[600],
          hintText: hintText,
          hintTextSize: AppController.instance.deviceInfo.screenInfo.width * 5.2,
          hintTextStroke: 3.0,
        ),
        borderStyle: CustomBorderStyle(
          borderStroke: 1.2,
          enableBorderColor: Colors.grey[350],
          errorBorderColor: Colors.red,
          focusedBorderColor: Style().colors.secundary,
        ),
        borderRadius: 12,
      ),
    );
  }
}
