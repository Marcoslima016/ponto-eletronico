import 'package:flutter/material.dart';

///Component que serve como uma moldura para o componentes de mapa (mapa do local e falha na localizacao).
///sua função é definir as dimensões dos componentes.
class AreaMapa extends StatelessWidget {
  Widget child;
  Color bgColor;
  AreaMapa({
    @required this.child,
    this.bgColor,
  }) {
    if (bgColor == null) bgColor = Colors.grey[100];
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height / 100;
    double w = MediaQuery.of(context).size.width / 100;
    return Padding(
      padding: EdgeInsets.only(left: w * 6, right: w * 6),
      child: Container(
        width: w * 100,
        // height: h * 44,
        height: h * 41,
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.all(Radius.circular(9)),
        ),
        child: child,
      ),
    );
  }
}
