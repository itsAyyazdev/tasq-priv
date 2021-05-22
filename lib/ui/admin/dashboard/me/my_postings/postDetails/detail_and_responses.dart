import 'package:tasq/ui/admin/dashboard/me/my_postings/postDetails/responses.dart';
import 'package:tasq/ui/shared/activity_post.dart';
import 'package:tasq/utils/globals/import_hub.dart';

class PostDetailAndResponses extends StatefulWidget {
  @override
  _PostDetailAndResponsesState createState() => _PostDetailAndResponsesState();
}

class _PostDetailAndResponsesState extends State<PostDetailAndResponses>
    with TickerProviderStateMixin {
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
                post: DummyData.posts[0],
              ),
            ),
            Responses(),
          ]),
        ),
        Expanded(
          child: assignTo(),
        )
      ],
    );
  }

  assignTo() {
    return TextButton(
      onPressed: () {
        print('onTap or assign to someone from your team');
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text.rich(
            TextSpan(
              style: MyTextStyles.montsNormal16.copyWith(
                fontSize: 13.0,
                color: Colors.black,
                height: 1.31,
              ),
              children: [
                TextSpan(
                  text: 'or assign to someone from',
                  style: MyTextStyles.montsNormal16.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
          Text(
            ' your team',
            style: MyTextStyles.montsNormal16.copyWith(
              color: const Color(0xFF2000FF),
              fontWeight: FontWeight.w700,
            ),
          )
        ],
      ),
    );
  }
}
