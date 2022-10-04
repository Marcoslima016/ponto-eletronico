import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../app.imports.dart';
import '../presentation.imports.dart';

class LayoutC extends StatelessWidget {
  ClockTimerController controller;

  var h;
  var w;

  LayoutC({
    @required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    h = MediaQuery.of(context).size.height / 100;
    w = MediaQuery.of(context).size.width / 100;

    String finalTime = "";

    return Obx(() {
      String finalTime = "";

      String _timeApart = controller.timeWithFuso.split(" ")[0];
      var _timeSplit = _timeApart.split(":");

      String hr = "";
      String min = "";

      if (_timeSplit.length >= 2) {
        finalTime = _timeSplit[0] + " : " + _timeSplit[1];

        hr = _timeSplit[0];
        min = _timeSplit[1];
      }

      return Padding(
        padding: EdgeInsets.only(left: w * 6, right: w * 6),
        child: Container(
          width: w * 100,
          padding: EdgeInsets.only(top: h * 2.6, bottom: h * 2.6),
          // decoration: BoxDecoration(
          //   color: AppController.instance.style.colors.primary.withOpacity(0.03),
          //   borderRadius: BorderRadius.all(Radius.circular(5)),
          // ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //
                  // Icon(
                  //   Icons.timer,
                  //   size: h * 7,
                  //   color: Colors.grey[300],
                  // ),

                  //HORAS
                  timeFrame(value: hr),

                  // DIVISAO ( : )
                  Container(
                    width: w * 8,
                    margin: EdgeInsets.only(bottom: h * 1),
                    child: Center(
                      child: Text(
                        ": ",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: "OpenSans",
                          fontSize: h * 6.5,
                          // color: Colors.grey[900],
                          color: AppController.instance.style.colors.primary,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                  ),

                  //MINUTOS
                  timeFrame(value: min),
                  // Text(
                  //   finalTime,
                  //   style: TextStyle(
                  //     // fontFamily: "NunitoBlack",
                  //     fontFamily: "OpenSans",
                  //     fontSize: h * 7,
                  //     color: Colors.grey[900],
                  //     // fontWeight: FontWeight.bold,
                  //     fontWeight: FontWeight.w900,
                  //   ),
                  //   textAlign: TextAlign.center,
                  // ),
                ],
              ),
              SizedBox(height: h * 1.5),
              Text(
                "27/04/2022",
                style: TextStyle(
                  fontFamily: "OpenSans",
                  fontSize: h * 3.8,
                  color: AppController.instance.style.colors.primary,
                  // color: Colors.grey[400],
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  Widget timeFrame({@required String value}) {
    return Container(
      // width: w * 25,
      // height: w * 25,
      // decoration: BoxDecoration(
      //   color: AppController.instance.style.colors.primary.withOpacity(0.03),
      //   borderRadius: BorderRadius.all(Radius.circular(8)),
      // ),
      padding: EdgeInsets.only(left: w * 0, right: w * 0, top: h * 0.2, bottom: h * 0.2),
      child: Column(
        // crossAxisAlignment: CrossAxis,
        children: [
          //----------- VALOR -----------
          Text(
            value,
            textAlign: TextAlign.center,
            style: TextStyle(
              // fontFamily: "NunitoBlack",
              fontFamily: "OpenSans",
              fontSize: h * 6,
              // color: Colors.grey[900],
              color: AppController.instance.style.colors.primary,
              // fontWeight: FontWeight.bold,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }
}

///
///
///
///
///
///
///


// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// import '../../../../../../app.imports.dart';
// import '../presentation.imports.dart';

// class LayoutC extends StatelessWidget {
//   ClockTimerController controller;

//   var h;
//   var w;

//   LayoutC({
//     @required this.controller,
//   });

//   @override
//   Widget build(BuildContext context) {
//     h = MediaQuery.of(context).size.height / 100;
//     w = MediaQuery.of(context).size.width / 100;

//     String finalTime = "";

//     return Obx(() {
//       String finalTime = "";

//       String _timeApart = controller.timeWithFuso.split(" ")[0];
//       var _timeSplit = _timeApart.split(":");

//       String hr = "";
//       String min = "";

//       if (_timeSplit.length >= 2) {
//         finalTime = _timeSplit[0] + " : " + _timeSplit[1];

//         hr = _timeSplit[0];
//         min = _timeSplit[1];
//       }

//       return Padding(
//         padding: EdgeInsets.only(left: w * 6, right: w * 6),
//         child: Container(
//           width: w * 100,
//           padding: EdgeInsets.only(top: h * 2.6, bottom: h * 2.6),
//           // decoration: BoxDecoration(
//           //   color: AppController.instance.style.colors.primary.withOpacity(0.03),
//           //   borderRadius: BorderRadius.all(Radius.circular(5)),
//           // ),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               //HORAS
//               timeFrame(value: hr),

//               // DIVISAO ( : )
//               Container(
//                 width: w * 9,
//                 child: Center(
//                   child: Text(
//                     ": ",
//                     textAlign: TextAlign.center,
//                     style: TextStyle(
//                       fontFamily: "OpenSans",
//                       fontSize: h * 7,
//                       color: Colors.grey[900],
//                       fontWeight: FontWeight.w900,
//                     ),
//                   ),
//                 ),
//               ),

//               //MINUTOS
//               timeFrame(value: min),
//               // Text(
//               //   finalTime,
//               //   style: TextStyle(
//               //     // fontFamily: "NunitoBlack",
//               //     fontFamily: "OpenSans",
//               //     fontSize: h * 7,
//               //     color: Colors.grey[900],
//               //     // fontWeight: FontWeight.bold,
//               //     fontWeight: FontWeight.w900,
//               //   ),
//               //   textAlign: TextAlign.center,
//               // ),
//             ],
//           ),
//         ),
//       );
//     });
//   }

//   Widget timeFrame({@required String value}) {
//     return Container(
//       // width: w * 25,
//       // height: w * 25,
//       decoration: BoxDecoration(
//         color: AppController.instance.style.colors.primary.withOpacity(0.03),
//         borderRadius: BorderRadius.all(Radius.circular(8)),
//       ),
//       padding: EdgeInsets.only(left: w * 12, right: w * 12, top: h * 0.2, bottom: h * 0.2),
//       child: Column(
//         // crossAxisAlignment: CrossAxis,
//         children: [
//           // Positioned(
//           //   top: 2,
//           //   child: Icon(Icons.keyboard_arrow_up),
//           // ),

//           //----- INCREMENT BUTTON -----
//           Icon(
//             Icons.keyboard_arrow_up,
//             size: h * 5,
//             color: Colors.grey[300],
//           ),

//           //----------- VALOR -----------
//           Text(
//             value,
//             textAlign: TextAlign.center,
//             style: TextStyle(
//               // fontFamily: "NunitoBlack",
//               fontFamily: "OpenSans",
//               fontSize: h * 7,
//               color: Colors.grey[900],
//               // fontWeight: FontWeight.bold,
//               fontWeight: FontWeight.w900,
//             ),
//           ),

//           SizedBox(height: h * 0.4),

//           Icon(
//             Icons.keyboard_arrow_down,
//             size: h * 5,
//             color: Colors.grey[300],
//           ),
//         ],
//       ),
//     );
//   }
// }
