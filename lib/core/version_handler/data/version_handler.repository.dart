import 'package:flutter/material.dart';

import '../version_handler.imports.dart';

class VersionHandlerRepository implements IVersionHandlerRepository {
  IVersionHandlerDatasource datasource;

  VersionHandlerRepository({
    @required this.datasource,
  });

  @override
  Future<String> getMinAppVersion() async {
    return await datasource.getMinAppVersion();
  }
  //
}
