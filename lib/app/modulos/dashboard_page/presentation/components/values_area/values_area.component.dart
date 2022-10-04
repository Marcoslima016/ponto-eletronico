import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../app.imports.dart';

class ValuesArea extends StatelessWidget {
  DashboardController dashboardController;

  ValuesArea({
    @required this.dashboardController,
  });

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height / 100;
    double w = MediaQuery.of(context).size.width / 100;

    return Padding(
      padding: EdgeInsets.only(left: w * 3.6, right: w * 3.6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ValueCard(
            text: "Horas \ndo dia ",
          ),
          ValueCard(
            text: "Horas \nda semana ",
          ),
          ValueCard(
            text: "Banco \nde horas ",
          ),
        ],
      ),
    );
  }
}

class ValueCard extends StatelessWidget {
  String text;
  ValueCard({
    @required this.text,
  });

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height / 100;
    double w = MediaQuery.of(context).size.width / 100;

    return Container(
      width: w * 29,
      height: w * 28,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(8)),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey[200].withOpacity(0.8),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(1.8, 1.8), // changes position of shadow
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: h * 3.6),
          Text(
            "00:00",
            style: TextStyle(fontSize: 27.5.sp, color: Style().colors.primary),
          ),
          Padding(
            padding: EdgeInsets.only(top: h * 0.85),
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14.sp,
                color: Colors.grey[350],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
