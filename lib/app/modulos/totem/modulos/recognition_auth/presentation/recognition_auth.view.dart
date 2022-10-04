import 'package:flutter/material.dart';
import 'package:ptem2/app/app.controller.dart';

import '../recognition_auth.imports.dart';

class RecognitionAuthView extends StatelessWidget {
  RecognitionAuthController controller = RecognitionAuthController();

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width / 100;
    final h = MediaQuery.of(context).size.height / 100;
    return Scaffold(
      backgroundColor: AppController.instance.style.colors.primary,
      body: FutureBuilder(
        future: controller.init(),
        builder: (context, snapshot) {
          return Container(
            width: w * 100,
            height: h * 100,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: w * 20,
                  height: w * 20,
                  child: CircularProgressIndicator(
                    backgroundColor: AppController.instance.style.colors.primary,
                    strokeWidth: 7.0,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                ),
              ],
            ),
          );
          // if (snapshot.hasData) {
          //   return Container(
          //     width: w * 100,
          //     height: h * 100,
          //     child: Column(
          //       mainAxisAlignment: MainAxisAlignment.center,
          //       crossAxisAlignment: CrossAxisAlignment.center,
          //       children: [
          //         Container(
          //           width: w * 20,
          //           height: w * 20,
          //           child: CircularProgressIndicator(
          //             backgroundColor: Colors.white,
          //             valueColor: AlwaysStoppedAnimation<Color>(
          //               AppController.instance.style.colors.primary,
          //             ),
          //           ),
          //         ),
          //       ],
          //     ),
          //   );
          // } else {
          //   return Container();
          // }
        },
      ),
    );
  }
}
