import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../../lib.imports.dart';

class RegistrandoBatidaView extends StatelessWidget {
  RegistrandoBatidaController controller = RegistrandoBatidaController();

  double w;
  double h;

  @override
  Widget build(BuildContext context) {
    h = MediaQuery.of(context).size.height / 100;
    w = MediaQuery.of(context).size.width / 100;
    controller.viewContext = context;
    controller.pageDisplayed = true;
    return Scaffold(
      backgroundColor: AppController.instance.style.colors.primary,
      body: FutureBuilder(
        future: controller.loadView(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Container(
              width: w * 100,
              height: h * 100,
              child: Stack(
                children: [
                  Container(height: double.infinity),
                  Container(
                    padding: EdgeInsets.only(left: w * 9, right: w * 9),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // SizedBox(height: h * 18),

                        //------------------- ICONE / LOADING ------------------

                        Stack(
                          children: [
                            Container(height: h * 21),
                            Center(
                              child: Container(
                                width: h * 18.5,
                                height: h * 18.5,
                                child: CircularProgressIndicator(
                                  backgroundColor: AppController.instance.style.colors.primary,
                                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                  color: AppController.instance.style.colors.primary,
                                ),
                              ),
                            ),
                            Positioned(
                              top: h * 2.4,
                              left: 0,
                              right: 0,
                              child: Icon(
                                Icons.alarm_add,
                                size: h * 14,
                                color: Colors.white.withOpacity(0.7),
                              ),
                            ),
                          ],
                        ),

                        //------------------------------------- TITULOS -------------------------------------

                        SizedBox(height: h * 5),
                        Text(
                          "Registrando Ponto",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w800,
                            fontSize: 31.sp,
                          ),
                        ),

                        Obx(() {
                          bool timeoutHit = controller.timeoutHit.value;
                          if (timeoutHit) {
                            return Container();
                          } else {
                            return Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(top: h * 3),
                                  child: Text(
                                    "Aguarde um instante, o seu ponto esta sendo contabilizado",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.grey[400],
                                      // fontWeight: FontWeight.w700,
                                      fontSize: 18.sp,
                                    ),
                                  ),
                                ),
                                SizedBox(height: h * 9),
                              ],
                            );
                          }
                        }),

                        //--------------------------------- LINEAR LOADIN ---------------------------------

                        // Padding(
                        //   padding: EdgeInsets.only(
                        //     top: h * 12,
                        //     left: w * 15,
                        //     right: w * 15,
                        //   ),
                        //   child: LinearProgressIndicator(
                        //     // backgroundColor: Colors.blue[700],
                        //     // backgroundColor: Colors.grey[300],
                        //     backgroundColor: Colors.grey[300].withOpacity(0.6),
                        //     // minHeight: h * 1.6,
                        //     minHeight: h * 1.2,
                        //     color: AppController.instance.style.colors.primary,
                        //   ),
                        // ),

                        //------------------------------- STATUS DO PROCESSO -------------------------------

                        // Padding(
                        //   padding: EdgeInsets.only(top: h * 16),
                        //   child: Text(
                        //     "Contabilizando batida no servidor..",
                        //     textAlign: TextAlign.center,
                        //     style: TextStyle(
                        //       color: Colors.grey[350].withOpacity(0.5),
                        //       // fontWeight: FontWeight.w700,
                        //       fontSize: 20.sp,
                        //     ),
                        //   ),
                        // ),

                        //---------------------------------- CARD TIMEOUT ----------------------------------

                        TimeoutCard(
                          controller: this.controller,
                        ),
                      ],
                    ),
                  ),

                  //------------------------------ BTN RELATAR PROBLEMA ------------------------------

                  // SizedBox(height: h * 17),

                  // Positioned(
                  //   bottom: h * 2,
                  //   child: Container(
                  //     padding: EdgeInsets.only(left: w * 9, right: w * 9),
                  //     width: w * 100,
                  //     child: Row(
                  //       mainAxisAlignment: MainAxisAlignment.center,
                  //       children: [
                  //         Icon(
                  //           Icons.warning,
                  //           color: Colors.white,
                  //         ),
                  //         SizedBox(width: 5.5),
                  //         Text(
                  //           "Relatar problema",
                  //           style: TextStyle(
                  //             color: Colors.white,
                  //             fontWeight: FontWeight.bold,
                  //             fontSize: 23.sp,
                  //           ),
                  //         )
                  //       ],
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
