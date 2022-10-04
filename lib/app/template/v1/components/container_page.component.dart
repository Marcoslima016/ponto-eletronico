import 'package:flutter/material.dart';

class ContainerPage extends StatelessWidget {
  Widget child;
  ContainerPage({
    @required this.child,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Style().colors.bg1,
      child: child,
    );
  }
}
