abstract class IClockLoop {
  //

  ///Metodo que inicia a rotina de loop
  Future fireLoop();

  ///Metodo disparado a cada ciclo do loop. Este metodo tem como responsabilidade
  ///atualizar o tempo do clock
  Future updateTime();
}
