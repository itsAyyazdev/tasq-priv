import 'package:loading_overlay/loading_overlay.dart';
import 'package:tasq/models/job.dart';
import 'package:tasq/ui/shared/activity_post.dart';
import 'package:tasq/ui/widgets/shared/k_button.dart';
import 'package:tasq/utils/globals/import_hub.dart';

class ApplyForTask extends StatelessWidget {
  final Job post;
  ApplyForTask({this.post});
  String proposal = "";
  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(
        builder: (context, p, _) => LoadingOverlay(
              isLoading: p.isLoading,
              child: Scaffold(
                body: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Padding(
                    padding: EdgeInsets.only(top: Get.height * 0.05),
                    child: Container(
                      padding: AppUtils.generalOuterPadding
                          .copyWith(left: Get.width * 0.04),
                      child: Column(
                        children: [
                          ActivityPost(
                            postData: post,
                            showHalf: true,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "write a proposal",
                                style: MyTextStyles.montsSemiBold16
                                    .copyWith(fontSize: 18),
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
                                        borderSide: BorderSide(
                                            color: AppConfig.colors.themeBlue)),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                        borderSide: BorderSide(
                                            color:
                                                AppConfig.colors.themeBlue))),
                                onChanged: (v) {
                                  proposal = v;
                                },
                              ),
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: Get.width * 0.1),
                            child: MyButton(
                              title: "CONFIRM",
                              onTap: () => p.applyForJob(post, proposal),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ));
  }
}
