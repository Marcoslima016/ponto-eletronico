import 'package:flutter/material.dart';

import '../../../localizacao_batida.imports.dart';

abstract class ICheckPermission {
  Future<bool> call();
}

class CheckPermission implements ICheckPermission {
  IGeolocationDriver driver;
  CheckPermission({
    @required this.driver,
  });

  @override
  Future<bool> call() async {
    return await driver.checkPermission();
  }
  //
}
