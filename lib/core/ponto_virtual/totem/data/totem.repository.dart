import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

import '../totem.imports.dart';
import 'data.imports.dart';

class TotemRepository implements ITotemRepository {
  //
  ///[=================== VARIAVEIS ===================]
  ///
  ITotemDatasource datasourceRest = TotemRestDatasource();
  ITotemDatasource datasourceGraphql = TotemGraphQLDatasource();

  ///[=================== CONSTRUTOR ===================]
  ///

  TotemRepository({
    @required this.datasourceGraphql,
    @required this.datasourceRest,
  });

  ///[================================================== METODOS ==================================================]
  ///[=============================================================================================================]

  //----------------------------------------- LOGIN -----------------------------------------
  @override
  Future<Either<Exception, String>> login(LoginCredentials credentials) async {
    Either<Exception, Map> result = await datasourceRest.login(credentials);
    return result.fold(
      (error) async {
        //ERRO
        var p = "";
        return Left(error);
      },
      (Map resultData) async {
        //SUCESSO
        return Right(resultData["token"]);
      },
    );
  }

  //------------------------------------- GET COLAB LIST -------------------------------------

  @override
  Future<Either<Exception, List<Colab>>> getColabList() async {
    List requestResult;
    try {
      requestResult = await datasourceGraphql.getAllColab();
    } catch (e) {
      return Left(Exception(e));
    }

    List<Colab> colabList = [];

    for (Map resultMap in requestResult) {
      if (resultMap["dtdemis"] == null) {
        colabList.add(Colab.fromAPI(resultMap));
      }
    }

    return Right(colabList);
  }
  //
}
