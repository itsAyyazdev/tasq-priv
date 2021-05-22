import 'package:flutter/material.dart';

class MyLoader extends StatelessWidget {
  final Color bgColor;
  final bool isFullScreen;
  MyLoader({this.isFullScreen = false, this.bgColor});
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
        height: isFullScreen ? size.height : null,
        width: isFullScreen ? size.width : null,
        color: bgColor,
        child: Center(
          child: CircularProgressIndicator(),
        ));
  }
}
