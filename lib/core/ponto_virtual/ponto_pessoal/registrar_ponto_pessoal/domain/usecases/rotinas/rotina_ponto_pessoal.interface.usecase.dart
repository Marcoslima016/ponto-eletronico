//
import 'package:flutter/material.dart';

abstract class IRotinaPontoPessoal {
  String idRotina;
  Future<bool> dispararRotina({@required Function onTrabalhadorValidado});
}
