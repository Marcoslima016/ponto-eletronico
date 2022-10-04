import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../domain.imports.dart';

abstract class ICheckCompatibility {
  Future<bool> call();
}

class CheckCompability implements ICheckCompatibility {
  IVersionHandlerRepository repository;

  CheckCompability({
    @required this.repository,
  });

  Future<bool> call() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String instaledVersion = packageInfo.version;
    String instaledVersionCode = packageInfo.buildNumber;

    String minAppVersionFull = await repository.getMinAppVersion(); //// Consulta repo

    if (minAppVersionFull == "") return true;

    int minVersionCode = int.parse(minAppVersionFull.split("-")[1]);

    if (int.parse(instaledVersionCode) < minVersionCode) {
      var p = "";
      return false;
    } else {
      return true; //// Se for compativel, retorna true;
    }
  }
}
