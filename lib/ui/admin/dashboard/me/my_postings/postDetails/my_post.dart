import 'package:tasq/models/job.dart';
import 'package:tasq/ui/admin/dashboard/me/my_postings/postDetails/detail_and_responses.dart';
import 'package:tasq/ui/widgets/shared/task_card.dart';
import 'package:tasq/utils/globals/app_data/dummy_data.dart';
import 'package:tasq/utils/globals/import_hub.dart';

class MyPostings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: List.generate(DummyData.posts.length, (index) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: TaskWidget(
            onTap: () => Get.to(PostDetailAndResponses(),
                transition: AppUtils.pageTransition, curve: AppUtils.pageCurve),
            showPoints: true,
            showResponses: true,
            showActive: true,
            post: Job(reward: "lsdhfk"),
          ),
        );
      }),
    );
  }
}
