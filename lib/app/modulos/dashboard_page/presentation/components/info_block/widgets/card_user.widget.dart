import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../../../lib.imports.dart';
import '../../../../../../app.imports.dart';

class CardUser extends StatelessWidget {
  DashboardController dashboardController;

  CardUser({
    @required this.dashboardController,
  });
  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height / 100;
    double w = MediaQuery.of(context).size.width / 100;

    DateTime now = DateTime.now();

    return Positioned(
      bottom: h * 0,
      child: Container(
        width: w * 100,
        child: Container(
          margin: EdgeInsets.only(
            left: w * 3.5,
            right: w * 3.5,
          ),
          // color: Colors.white,
          // width: w * 100,
          // height: h * 21,
          decoration: BoxDecoration(
            color: Colors.white,
            // border: Border.all(color: Colors.green),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10),
            ),
          ),
          padding: EdgeInsets.only(
            left: 20,
            right: 20,
            top: h * 3.2,
            bottom: h * 3.2,
          ),
          child: Container(
            // width: w * 100,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    ///[--------------------------------------- NOME/HORARIO ----------------------------------]
                    Expanded(
                      flex: 75,
                      child: Container(
                        decoration: BoxDecoration(
                            // border: Border.all(color: Colors.blue),
                            ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            //[------------- OLA -------------]
                            Text(
                              "Olá,",
                              style: TextStyle(
                                fontSize: 22.sp,
                                color: Colors.grey[500],
                              ),
                            ),

                            //[------------- NOME -------------]

                            Obx(() {
                              String nome = VariaveisGlobais.instance.rxNome.value;
                              return Container(
                                // color: Colors.grey[300],
                                padding: EdgeInsets.only(
                                  top: h * 1.2,
                                ),
                                margin: EdgeInsets.only(
                                  right: h * 3,
                                ),
                                child: Text(
                                  nome ?? "",
                                  // overflow: TextOverflow.fade,
                                  overflow: TextOverflow.clip,
                                  softWrap: true,
                                  maxLines: 1,
                                  style: TextStyle(
                                    fontSize: 22.4.sp,
                                    color: Colors.grey[800],
                                    fontWeight: FontWeight.w900,
                                    fontFamily: "VarelaRound",
                                  ),
                                ),
                              );
                            }),

                            //[------------- HORARIO -------------]

                            Padding(
                              padding: EdgeInsets.only(top: h * 1.7),
                              child: Row(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(top: h * 0.3),
                                    child: Icon(Icons.watch_later_outlined, color: Colors.grey[600]),
                                  ),
                                  SizedBox(width: h * 1),
                                  Obx(() {
                                    String time = dashboardController.hr.value;
                                    return Text(
                                      // "11:12:25",
                                      time,
                                      // now.hour.toString() + ":" + now.minute.toString() + ":" + now.second.toString(),
                                      style: TextStyle(
                                        fontSize: 27.2.sp,
                                        fontFamily: "SourceSansPro",
                                        fontWeight: FontWeight.w600,
                                        color: Style().colors.primary,
                                      ),
                                    );
                                  }),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),

                    ///[------------------------------------ FOTO -------------------------------------]
                    ///
                    Expanded(
                      flex: 25,
                      child: Container(
                        // height: 20,
                        width: w * 21,
                        height: w * 21,
                        // color: Colors.red,
                        child: Opacity(
                          opacity: 0.4,
                          child: CircleAvatar(
                            backgroundColor: Colors.transparent,
                            backgroundImage: ExactAssetImage(
                              'assets/assets_ptem2/images/user.png',
                            ),
                            minRadius: w * 21,
                            maxRadius: w * 21,
                          ),
                        ),

                        // Image.asset(
                        //   "assets/images/avatar/user1.jpg",
                        //   width: w * 10,
                        // ),
                      ),
                    ),
                  ],
                ),

                ///[----------------------------------- MSG "NAO BATEU PONTO" ------------------------------------]

                // Padding(
                //   padding: EdgeInsets.only(top: 15),
                //   child: Text(
                //     "Você ainda não bateu ponto hoje",
                //     style: TextStyle(
                //       fontSize: 18,
                //       fontFamily: Style().fonts.op1,
                //       fontWeight: FontWeight.w600,
                //       color: Colors.grey[400],
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
