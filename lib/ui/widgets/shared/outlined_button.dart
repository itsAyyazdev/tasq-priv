import 'package:flutter/material.dart';
import 'package:tasq/utils/constants/text_styles.dart';
import 'package:tasq/utils/globals/import_hub.dart';

class KOutlinedButton extends StatelessWidget {
  final String title;
  final Function onTap;
  final Widget child;
  KOutlinedButton({this.title, this.onTap, this.child})
      : assert(title != null || child != null);
  @override
  Widget build(BuildContext context) {
    BorderRadius radius = BorderRadius.circular(30);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        borderRadius: radius,
        onTap: () {},
        child: Container(
          decoration: BoxDecoration(
            borderRadius: radius,
            border: Border.all(width: 1.8, color: Colors.black),
          ),
          child: Padding(
            child: child != null
                ? child
                : Text(
                    "$title",
                    style: MyTextStyles.montsBold16,
                  ),
            padding: EdgeInsets.symmetric(
                vertical: Get.width * 0.03, horizontal: Get.width * 0.08),
          ),
        ),
      ),
    );
  }
}
