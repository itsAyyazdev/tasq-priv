import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tasq/models/job.dart';
import 'package:tasq/ui/widgets/shared/timeago_widget.dart';
import 'package:tasq/utils/globals/import_hub.dart';

class ActivityPost extends StatelessWidget {
  final Job postData;
  final bool showHalf;
  final Widget addOnWidget;
  final String dueIn;
  ActivityPost({
    this.addOnWidget,
    this.showHalf = false,
    this.postData,
    this.dueIn,
  });
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            '${postData?.category ?? ""}',
            style: MyTextStyles.montsNormal16.copyWith(
              fontSize: 32.0,
              color: Colors.black,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(
            height: Get.height * 0.02,
          ),
          timeAndAbout(),
          SizedBox(
            height: Get.height * 0.02,
          ),
          description(),
          SizedBox(
            height: Get.height * 0.02,
          ),
          addOnWidget ?? Container(),
          showHalf
              ? Container()
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Icon(Icons.card_giftcard),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'rewards offered',
                          style: MyTextStyles.montsNormal16.copyWith(
                            fontSize: 16.0,
                            color: Colors.black,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(
                          0, Get.height * 0.02, Get.width * 0.26, 10),
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(40.0),
                          border: Border.all(
                            width: 1.0,
                            color: const Color(0xFFDC143D),
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Text(
                              postData.rewardOfferName,
                              style: MyTextStyles.montsSemiBold16.copyWith(
                                fontSize: 14.0,
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: Get.height * 0.014,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Icon(Icons.timer),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'due in',
                          style: MyTextStyles.montsNormal16.copyWith(
                            fontSize: 18.0,
                            color: Colors.black,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: Get.height * 0.02,
                    ),
                    Text(
                      getExpiry(postData.expiry),
                      style: MyTextStyles.montsNormal16.copyWith(
                        fontSize: 22.0,
                        color: const Color(0xFFFFA200),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                )
        ],
      ),
    );
  }

  Widget description() {
    return Text(
      '${postData.description}',
      style: MyTextStyles.montsNormal16.copyWith(
        fontSize: 18.0,
        color: Colors.black,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  Widget timeAndAbout() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        TimeAgoWidget(
          time: postData.postedAt.toDate(),
          size: 16,
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          children: <Widget>[
            Icon(Icons.apartment_outlined),
            SizedBox(
              width: 14,
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Text(
                '${postData.orgName}',
                style: MyTextStyles.montsNormal16.copyWith(
                  fontSize: 16.0,
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  String getExpiry(Timestamp expiry) {
    DateTime postDate = expiry.toDate();
    DateTime today = DateTime.now();
    int diff = postDate.difference(today).inDays;
    print("fst $diff");
    if (diff < 1) {
      int diff = postDate.difference(today).inHours;
      print("h $diff");
      return "$diff hours";
    } else {
      return "$diff days";
    }
  }
}
