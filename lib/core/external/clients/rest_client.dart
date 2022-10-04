import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../../../lib.imports.dart';

class RequestCache {
  String endPoint;
  Map dataJson;
  bool enableJWt;
  RequestMethod method;
  RequestCache({
    @required this.endPoint,
    @required this.dataJson,
    @required this.enableJWt,
    @required this.method,
  });
}

enum RequestMethod {
  POST,
  GET,
}

class HttpRequestResult {
  ResultStatus status; ///// Indica se a requisicao foi bem sucedida
  var result;
  HttpRequestResult({
    @required this.status,
    @required this.result,
  });
}

enum ResultStatus {
  sucess,
  error,
  connectionFail,
}

class RestClient {
  ///[=================== VARIAVEIS ===================]
  ///
  Dio dio = new Dio();
  Dio tokenDio = new Dio();
  int connectTimeOut = 10000;
  int receiveTimeout = 15000;

  RequestCache cache;
  int qtdFail = 0;

  ///[=================== CONSTRUTOR ===================]

  RestClient() {
    initService();
  }

  ///[=============================================================================== METODOS ===============================================================================]
  ///[=======================================================================================================================================================================]
  ///

  ///[====================================================== INIT SERVICE ======================================================]

  Future initService() async {
    // dio.options.baseUrl = "https://api.vertech-it.com.br/ptem";
    dio.options.baseUrl = AppController.instance.config.baseUrl;
    dio.options.connectTimeout = connectTimeOut;
    dio.options.receiveTimeout = receiveTimeout;
    tokenDio.options = dio.options;

    dio.interceptors.add(
      InterceptorsWrapper(
          // //------------ CONFIGURAR REQUISICAO ------------
          // //
          // onRequest: (RequestOptions options) {},

          // //------------ RESPOSTA DA REQUISICAO ------------
          // //
          // onResponse: (Response response) {},

          // //----------------- TRATAR ERROS -----------------
          // //
          // onError: (DioError error) async {},
          ),
    );
  }

  ///[===================================================== REQUEST METHODS =====================================================]

  ///-------------------------------- POST --------------------------------

  Future post({String endPoint, var dataJson, bool enableJwt = false}) async {
    //Configurar chace
    cache = RequestCache(
      endPoint: endPoint,
      dataJson: dataJson,
      enableJWt: enableJwt,
      method: RequestMethod.POST,
    );

    await configInterceptors(enableJwt);

    await setHeaderJwt(enableJwt);

    try {
      Response<dynamic> response;
      response = null;

      response = await dio.post(
        endPoint, ////Endereco de requisicao
        data: dataJson, ////Dados passados na requisicao
      );

      return await requestSuccess(response);
    } catch (e) {
      return await requestError(e); //// Se resultar erro, dispara a funcao de tratamento de erro
    }
  }

  ///[===================================================== REQUEST RESULTS =====================================================]

  //---------------------------- ERRO ----------------------------

  Future requestError(DioError error) async {
    qtdFail++;
    String errorMessage = error.message;
    int errorIndex = error.type.index;
    var eMessage = error.message;

    if (errorIndex == 5 && eMessage != "token_validate") {
      return await handleConnectionError();
    }

    ///[#### ERRO TOKEN NAO VALIDADO #####]
    if (eMessage == "Http status error [401]" && qtdFail < 3) {
      //// *** INTERCEPTORS REALIZARÃO O TRTAMENTO ****
      // return HttpRequestResult(
      //   result: "token_validate",
      //   status: ResultStatus.error,
      // );
    } else {
      //// Se nao for erro 401 e ja foram feitas 3 novas tentativas, retorna erro.

      throw ("error");
    }
  }

  //--- TRATAR ERRO DE CONEXAO ---

  Future<HttpRequestResult> handleConnectionError() async {
    var point = "";
    throw ("connection");
  }

  //---------------------------- SUCESSO ----------------------------

  Future requestSuccess(Response response) async {
    return response.data;
  }

  ///[========================================================== UTILS ==========================================================]

  //------------------------- SETAR JWT -------------------------

  Future setHeaderJwt(bool enableJwt) async {
    if (enableJwt == false) return;

    String tokenJwt = "";
    if (tokenJwt == "" || tokenJwt == null) {
      throw ("ERRO: TOKEN JWT INVALIDO!");
    }
    dio.options.headers = {
      'Authorization': 'Bearer ' + tokenJwt.toString(),
    };
  }

  ///[====================================================== INTERCEPTORS ======================================================]

  ///[-------------------------------------- CONFIG INTERCEPTORS --------------------------------------]

  Future configInterceptors(bool enableJwt) async {
    //
    ///[------------- CONFIGURAR INTERCEPTORS -------------]

    // dio.interceptors.add(
    //   // InterceptorsWrapper(
    //   //   //------------ CONFIGURAR REQUISICAO ------------
    //   //   //
    //   //   onRequest: (RequestOptions options) {},

    //   //   //------------ RESPOSTA DA REQUISICAO ------------
    //   //   //
    //   //   onResponse: (Response response) {},

    //   //   //----------------- TRATAR ERROS -----------------
    //   //   //
    //   //   onError: (DioError error) async {
    //   //     // hasError = true;

    //   //     //>>>>>> TOKEN EXPIRADO
    //   //     if (error.response?.statusCode == 401 && enableJwt == true) {
    //   //       return await tokenRevalidate();
    //   //     } else {
    //   //       return error;
    //   //     }
    //   //   },
    //   // ),
    // );
  }

  ///[-------------------------------------- TOKEN REVALIDATE --------------------------------------]
  ///
  Future tokenRevalidate() async {}
}
