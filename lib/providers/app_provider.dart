import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:tasq/services/image_services.dart';
import 'package:tasq/ui/chatbox/people_screen.dart';
import 'package:tasq/utils/globals/app_data/app_user.dart';
import 'package:tasq/utils/globals/import_hub.dart';

class AppProvider extends ChangeNotifier {
  bool isLoading = false;
  String appbarTitle = AppUser.organization?.name ?? "home";
  File croppedImage;
  ImageServices _imgUtil = ImageServices();

  // will pick and crop image then set in ui
  void pickAndCropImage() async {
    startLoader();
    File picked = await _imgUtil.pickImage();
    stopLoader();
    if (picked != null) {
      startLoader();
      File cropped = await _imgUtil.cropImage(picked);
      stopLoader();
      if (cropped != null) {
        croppedImage = cropped;
      } else {
        Fluttertoast.showToast(msg: "No Image selected");
      }
      notifyListeners();
    }
  }

  //setTitle in dashboard
  setPageTitle(String title, Duration d) {
    Future.delayed(d, () {
      appbarTitle = title;
      notifyListeners();
    });
  }

  void onChatTapped() {
    Get.to(ChatPeople(),
        transition: AppUtils.pageTransition, curve: AppUtils.pageCurve);
  }

  startLoader() {
    isLoading = true;
    notifyListeners();
  }

  stopLoader() {
    isLoading = false;
    notifyListeners();
  }
}
