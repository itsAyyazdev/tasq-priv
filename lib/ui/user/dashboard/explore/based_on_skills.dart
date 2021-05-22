import 'package:flutter/material.dart';
import 'package:tasq/ui/user/task/task_details.dart';
import 'package:tasq/ui/widgets/shared/task_card.dart';
import 'package:tasq/utils/constants/config.dart';
import 'package:tasq/utils/globals/app_data/dummy_data.dart';
import 'package:tasq/utils/globals/import_hub.dart';

class BasedOnSkill extends StatelessWidget {
  final int maxLength;
  BasedOnSkill({this.maxLength});
  @override
  Widget build(BuildContext context) {
    int listLength = maxLength == null
        ? DummyData.posts.length
        : DummyData.posts.length > maxLength
            ? maxLength
            : DummyData.posts.length;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: Get.width * 0.01),
      child: Column(
        children: List.generate(listLength, (index) {
          return TaskWidget(
            post: DummyData.posts[index],
            showActive: true,
            showPoints: true,
            showResponses: false,
            color: AppConfig.colors.liteGrey,
            onTap: () {
              Get.to(UserTaskDetail(post: DummyData.posts[index]),
                  transition: AppUtils.pageTransition,
                  curve: AppUtils.pageCurve);
            },
          );
        }),
      ),
    );
  }
}
