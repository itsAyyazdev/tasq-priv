import 'package:provider/provider.dart';
import 'package:tasq/utils/globals/import_hub.dart';

class OrgInstructions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<AppProvider>(
        builder: (context, p, _) => Scaffold(
              body: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(AppUtils.topMargin,
                        Get.width * 0.14, Get.width * 0.034, Get.width * 0.02),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        underlineText(),
                        iconHeading(
                            icon: Icons.lock,
                            heading: "create spaces",
                            body: "Be in control of your conversations."),
                        iconHeading(
                            icon: Icons.library_add_check_outlined,
                            heading: "assign tasqs",
                            body:
                                "reward your patrons based on the milestones they complete."),
                        iconHeading(
                            icon: Icons.security_rounded,
                            heading: "privacy focused",
                            body:
                                "all the chats and tasqs are 100% end-to-end encrypted, with privacy built into our DNA."),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: Get.height * 0.06,
                  ),
                  Expanded(
                    child: SizedBox(),
                  ),
                  NextNavigationBottom(
                    onTap: () {
                      AppRoutes.push(context, OrgDashboard());
                    },
                  )
                ],
              ),
            ));
  }

  Widget underlineText() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Let's get started",
          style: MyTextStyles.montsBold16.copyWith(fontSize: 24),
        ),
        GradientContainerBlue(
          width: Get.width * 0.28,
          height: 5,
        )
      ],
    );
  }

  Widget iconHeading({IconData icon, String heading, String body}) {
    return Padding(
      padding: EdgeInsets.only(top: Get.height * 0.08),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 4, right: 4),
                child: Icon(
                  icon,
                  color: Colors.black,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "$heading",
                    style: MyTextStyles.montsBold16.copyWith(fontSize: 22),
                  ),
                  GradientContainerBlue(
                    width: Get.width * 0.3,
                    height: 2.5,
                  ),
                ],
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(top: 8.0),
            child: Text(
              "$body",
              style: MyTextStyles.montsSemiBold16.copyWith(fontSize: 17),
            ),
          ),
        ],
      ),
    );
  }
}
