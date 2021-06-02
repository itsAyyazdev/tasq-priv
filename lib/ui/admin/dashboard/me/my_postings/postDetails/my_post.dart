import 'package:tasq/models/job.dart';
import 'package:tasq/models/job_application.dart';
import 'package:tasq/ui/admin/dashboard/me/my_postings/postDetails/detail_and_responses.dart';
import 'package:tasq/ui/widgets/shared/empty_screen.dart';
import 'package:tasq/ui/widgets/shared/shimmers/job.dart';
import 'package:tasq/ui/widgets/shared/task_card.dart';
import 'package:tasq/utils/globals/import_hub.dart';

class MyPostings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<AdminProvider>(builder: (context, p, _) {
      if (p.isLoading) {
        return JobShimmer();
      } else {
        if (p.postedTasks.isEmpty) {
          return EmptyScreen(
            msg: "No Tasks posted yet",
          );
        } else {
          return ListView(
            children: List.generate(p.postedTasks.length, (index) {
              Job job = p.postedTasks[index];
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: FutureBuilder(
                  future: p.getApplicationsByJobId(jobId: job.jobId),
                  builder:
                      (context, AsyncSnapshot<List<JobApplication>> snapshot) {
                    if (!snapshot.hasData) {
                      return JobShimmerCard();
                    } else {
                      return TaskWidget(
                        onTap: () => Get.to(
                            PostDetailAndResponses(
                              job: p.postedTasks[index],
                              responses: snapshot.data,
                            ),
                            transition: AppUtils.pageTransition,
                            curve: AppUtils.pageCurve),
                        showPoints: true,
                        showResponses: true,
                        showActive: true,
                        post: job,
                        responseCount: snapshot.data.length,
                      );
                    }
                  },
                ),
              );
            }),
          );
        }
      }
    });
  }
}
