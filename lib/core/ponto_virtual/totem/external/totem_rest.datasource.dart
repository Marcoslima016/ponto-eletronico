import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:ptem2/core/external/clients/rest_client.dart';

import '../totem.imports.dart';

class TotemRestDatasource extends ITotemDatasource {
  RestClient client = RestClient();

  @override
  Future<Either<Exception, Map>> login(LoginCredentials credentials) async {
    Map response;
    try {
      response = await client.post(
        endPoint: "/logintotem",
        dataJson: credentials.toMap(),
        enableJwt: false,
      );
      return Right(response);
    } catch (e) {
      var p = e;
      return Left(Exception(e));
    }
  }
  //
}
