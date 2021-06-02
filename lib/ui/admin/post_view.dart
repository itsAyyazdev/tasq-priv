import 'package:loading_overlay/loading_overlay.dart';

import 'package:tasq/models/job.dart';
import 'package:tasq/models/post_model.dart';
import 'package:tasq/ui/shared/activity_post.dart';
import 'package:tasq/ui/widgets/shared/k_button.dart';
import 'package:tasq/utils/globals/import_hub.dart';

class PostPreview extends StatelessWidget {
  final PostModel post;
  final Job postData;
  final String dueIn;
  PostPreview({this.post, this.postData, this.dueIn});
  @override
  Widget build(BuildContext context) {
    return Consumer<AdminProvider>(
        builder: (context, adminProvider, _) => Scaffold(
              appBar: MyAppbar(
                title: "post preview",
                autoImplyLeading: true,
                showChatIcon: false,
              ),
              body: LoadingOverlay(
                isLoading: adminProvider.isLoading,
                child: Padding(
                  padding: AppUtils.generalOuterPadding,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ActivityPost(
                          postData: postData,
                          dueIn: dueIn,
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: Get.height * 0.06),
                          child: MyButton(
                              title: "CONFIRM AND POST",
                              onTap: () {
                                adminProvider.createTask(task: postData);
                              }),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ));
  }
}
