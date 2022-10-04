import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../core.imports.dart';
import '../../../ponto_pessoal.imports.dart';

abstract class IBatidasRepository {
  bool carregandoBatidas; 
  RxList<Batida> listaDeBatidas = List<Batida>().obs;
  Future<Either<Exception, ExecutionSuccess>> carregarBatidas({@required String data});
  Future<Either<Exception, List<Batida>>> consultarBatidas({@required String data});
  Future<bool> contabilizarNovaBatida(RegistroBatida dadosNovaBatida, Duration timeout);
  Future contabilizarBatidaOffline(RegistroBatida dadosNovaBatida);
}
