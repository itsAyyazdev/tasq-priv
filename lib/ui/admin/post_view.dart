import 'package:tasq/models/post_model.dart';
import 'package:tasq/ui/shared/activity_post.dart';
import 'package:tasq/ui/widgets/shared/k_button.dart';
import 'package:tasq/utils/globals/import_hub.dart';

class PostPreview extends StatelessWidget {
  final PostModel post;
  PostPreview({@required this.post});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppbar(
        title: "post preview",
        autoImplyLeading: true,
        showChatIcon: false,
      ),
      body: Padding(
        padding: AppUtils.generalOuterPadding,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ActivityPost(post: post),
              Padding(
                padding: EdgeInsets.only(top: Get.height * 0.06),
                child: MyButton(
                  title: "CONFIRM AND POST",
                  onTap: () => AppRoutes.makeFirst(context, OrgDashboard()),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
