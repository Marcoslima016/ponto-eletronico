import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ptem2/core/core.imports.dart';
import 'package:flutter_recognize/src/src.imports.dart';
import '../facial_recognition.imports.dart';

class FacialRecognitionTotemController {
  //

  IRegistrarColab usecaseRegistrarColab;

  bool activate = false;

  static final FacialRecognitionTotemController instance = FacialRecognitionTotemController._(); //// Armazena a instancia utilizada no singleton
  FacialRecognitionTotemController._() {
    FacialRecognitionTotemBind().dependencies();
    usecaseRegistrarColab = Get.find<IRegistrarColab>();
  }

  //======================================== INICIALIZAR =========================================

  Future initFacialRecognitionTotem() async {
    //

    //INICIALIZAR PACKAGE FLUTTER RECOGNIZE
    await FlutterRecognize.instance.init();

    //--- RECUPERAR STATUS DE ATIVACAO PARA A EMPRESA ---
    DatabaseReference db = FirebaseDatabase.instance.reference().child("/APP_CONFIG/facial_recognition_clients");
    DataSnapshot response = await db.once();
    Map results = response.value;
    results.forEach((key, value) {
      var grempId = value["gremp_id"];
      if (grempId.toString() == TotemController.instance.usecaseTotemCore.grempId.value.toString()) {
        if (value["active"] == true) {
          activate = true;
        }
      }
    });
  }

  //====================================== REGISTRAR COLAB =======================================

  ///Metodo que dispara o processo para registrar a face de um colaborador
  Future registrarColab() async {
    await usecaseRegistrarColab();
  }
}
