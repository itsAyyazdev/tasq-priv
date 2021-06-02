import 'package:cloud_firestore/cloud_firestore.dart';

import 'import_hub.dart';

class AppUtils {
  static PageController adminPageController = PageController();
  static PageController userPageController = PageController();
  static double topMargin = Get.width * 0.04;
  static Duration pageTrxDuration = Duration(milliseconds: 500);
  static EdgeInsets cardsPadding =
      EdgeInsets.symmetric(vertical: 12, horizontal: Get.width * 0.03);
  static EdgeInsets generalOuterPadding = EdgeInsets.fromLTRB(
      Get.width * 0.03, Get.width * 0.03, Get.width * 0.03, 10);
  static DateTime minAgoTime = DateTime.now().subtract(Duration(minutes: 3));
  static Transition pageTransition = Transition.cupertino;
  static Curve pageCurve = Curves.bounceInOut;

  static showSnackbar({String msg, bool isError}) {
    String title = isError ? "Uh oh!" : "Success";
    Color color = isError ? Colors.redAccent : Colors.green;
    return ScaffoldMessenger.of(Get.context).showSnackBar(SnackBar(
        backgroundColor: color,
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              title,
              style: MyTextStyles.montsSemiBold16.copyWith(color: Colors.white),
            ),
            Padding(
              padding: const EdgeInsets.all(6.0),
              child: Text(
                msg,
                style:
                    MyTextStyles.montsSemiBold16.copyWith(color: Colors.white),
              ),
            ),
          ],
        )));
  }

  static String getFreshTimeStamp() {
    return Timestamp.now().millisecondsSinceEpoch.toString();
  }
}
