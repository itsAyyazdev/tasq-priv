import 'package:flutter/material.dart';
import 'package:tasq/utils/constants/text_styles.dart';
import 'package:tasq/utils/globals/import_hub.dart';

class GradientContainerBlue extends StatefulWidget {
  final double height, width;
  final String title;
  final Function onTap;
  GradientContainerBlue({this.title, this.width, this.height, this.onTap});
  @override
  _GradientContainerBlueState createState() => _GradientContainerBlueState();
}

class _GradientContainerBlueState extends State<GradientContainerBlue> {
  bool isElevated = true;
  double elevation = 10;

  @override
  Widget build(BuildContext context) {
    bool isUnderLine = widget.title == null;
    bool isElevate = isElevated && widget.onTap != null;
    elevation = widget.onTap == null ? 0 : elevation;
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
                elevation = 10;
              });
            },
      child: Card(
        color: Colors.transparent,
        elevation: elevation,
        child: Container(
          decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(6.0),
              boxShadow: !isElevate
                  ? []
                  : [
                      BoxShadow(
                          color: AppConfig.colors.dimGrey.withOpacity(0.2),
                          spreadRadius: 4,
                          offset: Offset(2, 8),
                          blurRadius: 8)
                    ],
              gradient: LinearGradient(colors: [
                AppConfig.colors.brandiesBlue,
                AppConfig.colors.brandiesBlue,
                AppConfig.colors.themeBlue,
                // AppConfig.colors.themeBlue,
                AppConfig.colors.egyptianBlue,
                AppConfig.colors.brandiesBlue,
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
      ),
    );
  }
}

// class GradientContainerBlue extends StatelessWidget {
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       child: Container(
//         decoration: BoxDecoration(
//             color: Colors.grey,
//             borderRadius: BorderRadius.circular(6.0),
//             boxShadow: [
//               BoxShadow(
//                   color: AppConfig.colors.dimGrey.withOpacity(0.2),
//                   spreadRadius: 5,
//                   offset: Offset(2, 8),
//                   blurRadius: 8)
//             ],
//             gradient: LinearGradient(colors: [
//               AppConfig.colors.brandiesBlue,
//               AppConfig.colors.brandiesBlue,
//               AppConfig.colors.themeBlue,
//               // AppConfig.colors.themeBlue,
//               AppConfig.colors.egyptianBlue,
//               AppConfig.colors.brandiesBlue,
//             ])),
//         width: width,
//         height: height,
//         child: title != null
//             ? Padding(
//                 padding: EdgeInsets.only(left: Get.width * 0.08),
//                 child: Align(
//                   alignment: Alignment.centerLeft,
//                   child: Text(
//                     title,
//                     softWrap: true,
//                     style: MyTextStyles.montsSemiBold16.copyWith(
//                         fontSize: Get.height * 0.03, color: Colors.white),
//                   ),
//                 ),
//               )
//             : SizedBox.shrink(),
//       ),
//     );
//   }
// }
