import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../presentation.imports.dart';

class TimeoutCard extends StatelessWidget {
  RegistrandoBatidaController controller;

  TimeoutCard({
    @required this.controller,
  });

  double w;
  double h;

  @override
  Widget build(BuildContext context) {
    h = MediaQuery.of(context).size.height / 100;
    w = MediaQuery.of(context).size.width / 100;
    return Obx(() {
      bool timeoutHit = controller.timeoutHit.value;
      if (timeoutHit) {
        return Column(
          children: [
            SizedBox(height: h * 5),
            Container(
              width: w * 100,
              // height: h * 28,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
                color: Color(0xFF014b84),
              ),
              padding: EdgeInsets.all(w * 4),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.sentiment_dissatisfied_outlined,
                    color: Colors.white,
                    size: h * 6,
                  ),
                  SizedBox(height: h * 1.5),
                  Text(
                    "Esta levando muito tempo para contabilizar o ponto. ",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  SizedBox(height: h * 2),
                  Text(
                    "Isso pode acontecer devido a instabilidade da conexão ou eventuais falhas na comunicação com o servidor.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.7),
                      fontSize: 15.sp,
                    ),
                  ),
                  SizedBox(height: h * 1),
                  Text(
                    "Aguarde mais um pouco e se a batida não for contabilizada, pressione o botão 'Relatar problema', assim nossa equipe irá trabalhar nessa questão.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.7),
                      fontSize: 15.sp,
                    ),
                  ),
                  SizedBox(height: h * 1.2),
                ],
              ),
            ),
            // SizedBox(height: h * 4),
          ],
        );
      } else {
        return Container();
      }
    });
  }
}
