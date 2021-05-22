import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasq/utils/constants/config.dart';
import 'package:tasq/utils/constants/text_styles.dart';

class MyButton extends StatelessWidget {
  final String title;
  final Function onTap;
  MyButton({@required this.title, this.onTap});
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onTap,
      color: AppConfig.colors.dodgerBlue,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      child: Padding(
        padding:
            EdgeInsets.symmetric(vertical: 14.0, horizontal: Get.width * 0.1),
        child: Text(
          title,
          style: MyTextStyles.montsSemiBold16
              .copyWith(color: Colors.white, fontSize: 18),
        ),
      ),
    );
  }
}
