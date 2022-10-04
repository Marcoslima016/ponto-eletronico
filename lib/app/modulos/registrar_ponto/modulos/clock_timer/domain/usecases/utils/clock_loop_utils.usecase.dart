import 'dart:async';

import '../usecases.imports.dart';

///[Essa classe disponibiliza metodos comuns que serão utilizados por todos os use case do tipo IClockLoop]
///[São metodos que executam tarefas rotineiras em uma lógica baseada em loop (disparar loop, armazenar variavel do timer,
/// encerrar loop, etc)]
abstract class ClockLoopUtils implements IClockLoop {
  Timer loopTimer;

  @override
  Future fireLoop() {
    loopTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      updateTime();
    });
  }

  @override
  Future updateTime();
}
