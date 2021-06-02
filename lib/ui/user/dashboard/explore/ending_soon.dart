import 'package:flutter/material.dart';
import 'package:tasq/models/job.dart';
import 'package:tasq/ui/user/task/task_details.dart';
import 'package:tasq/ui/widgets/shared/empty_screen.dart';
import 'package:tasq/ui/widgets/shared/shimmers/job.dart';
import 'package:tasq/ui/widgets/shared/task_card.dart';
import 'package:tasq/utils/globals/import_hub.dart';

class EndingSoon extends StatelessWidget {
  final int maxLength;
  EndingSoon({this.maxLength});
  //maxlength is to display partial data on any screen,
  // leave null if you dont want max limits
  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(builder: (context, p, _) {
      if (p.isLoading) {
        return JobShimmer();
      } else {
        if (p.endingSoonJobs.isEmpty) {
          return EmptyScreen(
            msg: "No Jobs Found",
          );
        } else {
          int listLength = maxLength == null
              ? p.endingSoonJobs.length
              : p.endingSoonJobs.length > maxLength
                  ? maxLength
                  : p.endingSoonJobs.length;
          return Column(
            children: List.generate(listLength, (index) {
              Job job = p.endingSoonJobs[index];
              return TaskWidget(
                post: job,
                showActive: true,
                showPoints: true,
                showResponses: false,
                color: Colors.black,
                onTap: () {
                  Get.to(UserTaskDetail(post: job),
                      transition: AppUtils.pageTransition,
                      curve: AppUtils.pageCurve);
                },
              );
            }),
          );
        }
      }
    });
  }
}
