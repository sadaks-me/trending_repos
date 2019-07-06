import 'package:flutter/material.dart';

class NoConnectionView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Center(
        child: Container(
      color: Colors.green,
      width: size.width,
      height: size.height,
    ));
  }
}
