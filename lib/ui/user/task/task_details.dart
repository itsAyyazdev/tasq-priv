import 'package:flutter/material.dart';
import 'package:tasq/models/job.dart';
import 'package:tasq/ui/shared/activity_post.dart';
import 'package:tasq/ui/user/task/apply_for_task.dart';
import 'package:tasq/ui/widgets/shared/k_button.dart';
import 'package:tasq/utils/globals/import_hub.dart';

class UserTaskDetail extends StatelessWidget {
  final Job post;
  UserTaskDetail({this.post});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: Get.height * 0.05),
        child: Container(
          padding:
              AppUtils.generalOuterPadding.copyWith(left: Get.width * 0.04),
          child: Column(
            children: [
              ActivityPost(
                postData: post,
              ),
              Padding(
                padding: EdgeInsets.only(top: Get.width * 0.14),
                child: MyButton(
                  title: "APPLY",
                  onTap: () {
                    Get.to(
                        ApplyForTask(
                          post: post,
                        ),
                        transition: AppUtils.pageTransition,
                        curve: AppUtils.pageCurve);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
