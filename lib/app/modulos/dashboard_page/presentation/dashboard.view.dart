import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../app.imports.dart';
import 'dashboard.controller.dart';

abstract class DashboardV2View extends StatelessWidget {
  Future importExternalValues();

  Future onTapLeading(BuildContext context);

  DashboardController dashboardController;

  DashboardV2View() {
    dashboardController = DashboardController(
      importExternalValues: this.importExternalValues,
    );
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height / 100;
    double w = MediaQuery.of(context).size.width / 100;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Style().colors.primary,
        elevation: 0,
        leading: GestureDetector(
          onTap: () {
            onTapLeading(context);
          },
          child: Icon(
            Icons.menu,
            color: Colors.white,
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: w * 4),
            child: Icon(Icons.notifications, color: Colors.white),
          ),
        ],
        centerTitle: true,
        title: Text(
          "Compliance",
          style: TextStyle(
            color: Colors.white,
            fontFamily: "SourceSansPro",
            fontSize: 25.sp,
            fontWeight: FontWeight.normal,
          ),
        ),
      ),
      body: FutureBuilder(
        future: dashboardController.initModule(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Container(
              width: w * 100,
              height: h * 100,
              child: Column(
                children: [
                  ///[-------------------------------------------- INFO BLOCK --------------------------------------------]
                  ///
                  InfoBlockComponent(
                    dashboardController: dashboardController,
                  ),

                  //
                  ///[---------------------------------------------- VALUES ----------------------------------------------]
                  ///

                  SizedBox(height: h * 3.2),

                  ValuesArea(
                    dashboardController: this.dashboardController,
                  ),
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
