import 'package:flutter/material.dart';
import 'package:tasq/models/job.dart';
import 'package:tasq/ui/user/task/task_details.dart';
import 'package:tasq/ui/widgets/shared/empty_screen.dart';
import 'package:tasq/ui/widgets/shared/shimmers/job.dart';
import 'package:tasq/ui/widgets/shared/task_card.dart';
import 'package:tasq/utils/constants/config.dart';
import 'package:tasq/utils/globals/import_hub.dart';

class BasedOnSkill extends StatelessWidget {
  final int maxLength;
  BasedOnSkill({this.maxLength});
  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(builder: (context, p, _) {
      if (p.isLoading) {
        return JobShimmer();
      } else {
        int listLength = maxLength == null
            ? p.exploreJobs.length
            : p.exploreJobs.length > maxLength
                ? maxLength
                : p.exploreJobs.length;
        if (p.exploreJobs.isEmpty) {
          return EmptyScreen(
            msg: "No Jobs Found",
          );
        } else {
          return Container(
            padding: EdgeInsets.symmetric(horizontal: Get.width * 0.01),
            child: Column(
              children: List.generate(listLength, (index) {
                Job job = p.exploreJobs[index];
                return TaskWidget(
                  post: job,
                  showActive: true,
                  showPoints: true,
                  showResponses: false,
                  color: AppConfig.colors.liteGrey,
                  onTap: () {
                    Get.to(UserTaskDetail(post: job),
                        transition: AppUtils.pageTransition,
                        curve: AppUtils.pageCurve);
                  },
                );
              }),
            ),
          );
        }
      }
    });
  }
}
