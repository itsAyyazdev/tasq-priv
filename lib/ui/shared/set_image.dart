import 'dart:io';

import 'package:flutter/material.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:provider/provider.dart';
import 'package:tasq/utils/globals/import_hub.dart';

class SetImage extends StatelessWidget {
  //pass parameters and take back file on Press next,
  // the same class is being used for both admin and user.
  final String heading;
  final String description;
  final Function(File) onNext;
  SetImage({@required this.heading, @required this.description, this.onNext});
  @override
  Widget build(BuildContext context) {
    return Consumer2<AuthProvider, AppProvider>(
        builder: (context, authP, p, _) => LoadingOverlay(
              isLoading: authP.isLoading || p.isLoading,
              child: Scaffold(
                body: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(
                          AppUtils.topMargin,
                          Get.width * 0.14,
                          Get.width * 0.034,
                          Get.width * 0.02),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "$heading",
                            style:
                                MyTextStyles.montsBold16.copyWith(fontSize: 24),
                          ),
                          SizedBox(
                            height: Get.height * 0.05,
                          ),
                          Text(
                            "$description",
                            style: MyTextStyles.montsSemiBold16
                                .copyWith(fontSize: 20),
                          ),
                          SizedBox(
                            height: Get.height * 0.04,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: Get.height * 0.06,
                    ),
                    Center(
                      child: GestureDetector(
                        onTap: p.pickAndCropImage,
                        child: Container(
                          alignment: Alignment.center,
                          height: Get.width * 0.52,
                          width: Get.width * 0.52,
                          decoration: BoxDecoration(
                            image: p.croppedImage != null
                                ? DecorationImage(
                                    fit: BoxFit.fitWidth,
                                    image: FileImage(p.croppedImage))
                                : null,
                            border: Border.all(
                                color: AppConfig.colors.silver, width: 5),
                            shape: BoxShape.circle,
                          ),
                          child: p.croppedImage != null
                              ? Container()
                              : Icon(
                                  Icons.image_rounded,
                                  size: 64,
                                  color: AppConfig.colors.silver,
                                ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: SizedBox(),
                    ),
                    NextNavigationBottom(
                      onTap: () {
                        Future.delayed(Duration(milliseconds: 50), () {
                          onNext(p.croppedImage);
                        });
                      },
                    )
                  ],
                ),
              ),
            ));
  }
}
