import 'package:custom_app/lib.imports.dart';
import 'package:custom_components/custom_components.dart';
import 'package:flutter/material.dart';

import 'components.imports.dart';

class Components implements IAppComponents {
  //
  @override
  TextFieldComponents textFields = TextFields();

  @override
  ButtonsComponents buttons = Buttons();

  AppBars appBars = AppBars();
}
