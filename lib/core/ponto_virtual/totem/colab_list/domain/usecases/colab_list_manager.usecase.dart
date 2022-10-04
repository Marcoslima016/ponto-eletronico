import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../totem.imports.dart';
import '../domain.imports.dart';

abstract class IColabListManager {
  IColabListRepository repository;
  RxList<Colab> get colabList;
  Future loadList();
  Future setColabPrediction({@required int id, List prediction});
  Future setColabLastDetectionTS({@required int id, int timestamp});
}

class ColabListManager implements IColabListManager {
  //
  IColabListRepository repository;

  RxList<Colab> get colabList => repository.colabList;

  ColabListManager({
    @required this.repository,
  });

  //---------------------------------- LOAD LIST ----------------------------------

  Future loadList() async {
    Either<Exception, List<Colab>> requestResult = await repository.loadColabList();
  }

  //----------------------------- SET COLAB PREDICTION -----------------------------

  Future setColabPrediction({@required int id, List prediction}) async {
    for (Colab colab in repository.colabList) {
      if (colab.id == id) {
        colab.prediction = prediction;
      }
    }
    await repository.updateColabList();
  }

  //-------------------- SET COLAB LAST DETECTION (RECOGNIZE) --------------------

  Future setColabLastDetectionTS({@required int id, int timestamp}) async {
    for (Colab colab in repository.colabList) {
      if (colab.id == id) {
        colab.timestampLastDetection = timestamp;
      }
    }
    await repository.updateColabList();
  }
}
