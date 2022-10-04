import 'package:flutter/material.dart';

import '../../domain.imports.dart';

abstract class ICarregarBatidas {
  Future call();
}

class CarregarBatidas implements ICarregarBatidas {
  IBatidasTotemRepository batidasRepository;

  CarregarBatidas({
    @required this.batidasRepository,
  });

  @override
  Future call() async {
    await batidasRepository.carregarBatidas();
  }
}
