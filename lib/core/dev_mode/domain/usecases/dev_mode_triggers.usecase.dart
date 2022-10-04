import 'dart:async';

abstract class IDevModeTriggers {
  //

  StreamController<bool> triggerFired;

  Future triggerSignupLongpress();

  Future triggerLoginLongpress();
}

class DevModeTriggers implements IDevModeTriggers {
  Timer timer;

  bool signupButtonFired = false;

  int i = 0;

  bool running = false;

  @override
  StreamController<bool> triggerFired = new StreamController.broadcast();

  @override
  Future triggerLoginLongpress() async {
    if (running) return;
    running = true;
    timer = Timer.periodic(Duration(milliseconds: 400), (timer) {
      if (signupButtonFired == true) {
        print("ABRIR POPUP !!!!!!!!!!!!");
        triggerFired.add(true);
        signupButtonFired = false;
        timer.cancel();
        running = false;
      }
      if (i == 4) {
        timer.cancel();
        running = false;
      }
      i++;
    });
  }

  @override
  Future triggerSignupLongpress() async {
    signupButtonFired = true;
    Timer(Duration(seconds: 2), () {
      signupButtonFired = false;
    });
  }
}
