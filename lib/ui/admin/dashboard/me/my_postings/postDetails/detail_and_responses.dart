import 'package:tasq/models/job.dart';
import 'package:tasq/models/job_application.dart';
import 'package:tasq/ui/admin/dashboard/me/my_postings/postDetails/responses.dart';
import 'package:tasq/ui/shared/activity_post.dart';
import 'package:tasq/utils/globals/import_hub.dart';

class PostDetailAndResponses extends StatefulWidget {
  final Job job;
  final List<JobApplication> responses;
  PostDetailAndResponses({@required this.job, @required this.responses});
  @override
  _PostDetailAndResponsesState createState() =>
      _PostDetailAndResponsesState(job: job, responses: responses);
}

class _PostDetailAndResponsesState extends State<PostDetailAndResponses>
    with TickerProviderStateMixin {
  Job job;
  List<JobApplication> responses;
  _PostDetailAndResponsesState({@required this.job, @required this.responses});
  TabController tCont;
  initTabController() {
    tCont = TabController(length: 2, vsync: this);
  }

  @override
  void initState() {
    initTabController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppbar(
        autoImplyLeading: true,
        title: "responses",
      ),
      body: tabs(),
    );
  }

  Widget tabs() {
    return Column(
      children: [
        TabBar(
          controller: tCont,
          indicatorColor: Colors.black,
          indicatorSize: TabBarIndicatorSize.tab,
          tabs: List.generate(2, (index) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                index == 0 ? "my post" : "responses",
                style: MyTextStyles.montsSemiBold16
                    .copyWith(color: Colors.black, fontSize: 20),
              ),
            );
          }),
        ),
        Expanded(
          flex: 8,
          child: TabBarView(controller: tCont, children: [
            Padding(
              padding: EdgeInsets.fromLTRB(Get.width * 0.03, Get.height * 0.02,
                  Get.width * 0.02, Get.height * 0.02),
              child: ActivityPost(
                postData: job,
              ),
            ),
            Responses(
              responses: responses,
              job: job,
            ),
          ]),
        ),
      ],
    );
  }
}
