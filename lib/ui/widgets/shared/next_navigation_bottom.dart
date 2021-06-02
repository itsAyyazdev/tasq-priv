import 'package:flutter/material.dart';
import 'package:tasq/utils/constants/text_styles.dart';
import 'package:tasq/utils/globals/import_hub.dart';

class NextNavigationBottom extends StatelessWidget {
  final Function onTap;
  NextNavigationBottom({this.onTap});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height * 0.07,
      width: Get.width,
      color: AppConfig.colors.frenchBlue,
      padding: EdgeInsets.symmetric(horizontal: Get.width * 0.02),
      child: Align(
        alignment: Alignment.centerRight,
        child: TextButton(
          child: Text(
            "NEXT",
            style: MyTextStyles.montsSemiBold16
                .copyWith(color: Colors.white, fontSize: Get.height * 0.024),
          ),
          onPressed: onTap,
        ),
      ),
    );
  }
}
