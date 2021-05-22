import 'package:flutter/material.dart';
import 'package:tasq/utils/constants/text_styles.dart';
import 'package:tasq/utils/globals/import_hub.dart';

class GradientContainerGreen extends StatefulWidget {
  final double height, width;
  final String title;
  final Function onTap;
  GradientContainerGreen({this.title, this.width, this.height, this.onTap});
  @override
  _GradientContainerGreenState createState() => _GradientContainerGreenState();
}

class _GradientContainerGreenState extends State<GradientContainerGreen> {
  bool isElevated = true;
  double elevation = 8;

  @override
  Widget build(BuildContext context) {
    bool isUnderLine = widget.title == null;
    return GestureDetector(
      onTap: widget.onTap,
      onTapDown: isUnderLine
          ? (dd) {}
          : (dd) {
              setState(() {
                isElevated = false;
                elevation = 0;
              });
            },
      onTapUp: isUnderLine
          ? (dd) {}
          : (dd) {
              setState(() {
                isElevated = true;
                elevation = 8;
              });
            },
      child: Container(
        decoration: BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.circular(6.0),
            boxShadow: !isElevated || isUnderLine
                ? []
                : [
                    BoxShadow(
                        color: Colors.black.withOpacity(0.16),
                        spreadRadius: 4,
                        offset: Offset(2, 8),
                        blurRadius: 10)
                  ],
            gradient: LinearGradient(colors: [
              AppConfig.colors.springGreen,
              AppConfig.colors.jadeGreen,
            ])),
        width: widget.width,
        height: widget.height,
        child: widget.title != null
            ? Padding(
                padding: EdgeInsets.only(left: Get.width * 0.08),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    widget.title,
                    softWrap: true,
                    style: MyTextStyles.montsSemiBold16.copyWith(
                        fontSize: Get.height * 0.03, color: Colors.white),
                  ),
                ),
              )
            : SizedBox.shrink(),
      ),
    );
  }
}
