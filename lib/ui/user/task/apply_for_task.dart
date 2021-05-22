import 'package:tasq/models/post_model.dart';
import 'package:tasq/ui/shared/activity_post.dart';
import 'package:tasq/ui/widgets/shared/k_button.dart';
import 'package:tasq/utils/globals/import_hub.dart';

class ApplyForTask extends StatelessWidget {
  final PostModel post;
  ApplyForTask({this.post});
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
                post: post,
                showHalf: true,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "write a proposal",
                    style: MyTextStyles.montsSemiBold16.copyWith(fontSize: 18),
                  ),
                  SizedBox(
                    height: Get.height * 0.02,
                  ),
                  TextFormField(
                    maxLines: 10,
                    minLines: 8,
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide:
                                BorderSide(color: AppConfig.colors.themeBlue)),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide:
                                BorderSide(color: AppConfig.colors.themeBlue))),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(top: Get.width * 0.1),
                child: MyButton(
                  title: "CONFIRM",
                  onTap: () {},
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
