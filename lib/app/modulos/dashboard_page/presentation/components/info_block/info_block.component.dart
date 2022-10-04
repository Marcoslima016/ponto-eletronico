import 'package:flutter/material.dart';

import '../../dashboard.controller.dart';
import 'info_block.imports.dart';

// class InfoBlockComponent extends StatefulWidget {
//   @override
//   _InfoBlockComponentState createState() => _InfoBlockComponentState();
// }

class InfoBlockComponent extends StatelessWidget {
  DashboardController dashboardController;

  InfoBlockComponent({
    @required this.dashboardController,
  });

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height / 100;
    double w = MediaQuery.of(context).size.width / 100;
    return Container(
      height: h * 23.8,
      width: w * 100,
      child: Stack(
        children: [
          ///[============================ CARD SOMBRA ============================]
          Positioned(
            // top: h * 3,
            bottom: h * 0,
            child: Container(
              width: w * 100,
              child: Container(
                margin: EdgeInsets.only(left: w * 3.5, right: w * 3.5),
                // color: Colors.white,
                // width: w * 100,
                height: h * 21,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.grey[200]),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey[200].withOpacity(0.8),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(1.8, 1.8), // changes position of shadow
                    ),
                  ],
                ),
                padding: EdgeInsets.all(0),
                child: Container(
                    // width: w * 100,

                    ),
              ),
            ),
          ),

          ///[============================ BG BLUE ============================]
          Container(
            width: w * 100,
            height: h * 17.5,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                stops: [0.2, 1.5],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xFF01579B), Color(0xFF012C4E)],
              ),
            ),
            // child: Container(
            //   padding: EdgeInsets.only(right: 5),
            //   alignment: Alignment.topRight,
            //   child: Image.asset(
            //     'assets/images/icon-drawer.png',
            //     color: Colors.white.withOpacity(0.09),
            //   ),
            // ),
          ),

          ///[=========================== CARD USER ===========================]
          ///
          CardUser(
            dashboardController: this.dashboardController,
          ),
        ],
      ),
    );
  }
}
