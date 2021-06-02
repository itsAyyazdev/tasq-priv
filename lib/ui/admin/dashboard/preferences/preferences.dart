import 'package:tasq/ui/admin/dashboard/preferences/pending_requests.dart';
import 'package:tasq/ui/widgets/shared/logout_button.dart';
import 'package:tasq/utils/globals/import_hub.dart';

class AdminPreferences extends StatefulWidget {
  @override
  _AdminPreferencesState createState() => _AdminPreferencesState();
}

class _AdminPreferencesState extends State<AdminPreferences> {
  @override
  void initState() {
    AdminProvider p = Provider.of(context, listen: false);
    print("initState");
    p.getPendingRequests();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AdminProvider>(
        builder: (context, p, _) => Scaffold(
              body: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  children: [
                    AdminInfoCard(
                      isEdit: true,
                    ),
                    pendingRequests(p),
                    contactUs(),
                    LogoutButton(
                      topPadding: Get.height * .06,
                    ),
                  ],
                ),
              ),
            ));
  }

  Widget pendingRequests(AdminProvider p) {
    return Padding(
      padding: EdgeInsets.only(top: Get.height * .02, bottom: Get.height * .03),
      child: InkWell(
        onTap: () async {
          await Get.to(PendingRequests(),
              curve: AppUtils.pageCurve, transition: AppUtils.pageTransition);
          p.stopLoader();
        },
        child: Container(
          width: Get.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6.0),
            color: const Color(0xFFF3F2F2),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.16),
                offset: Offset(0, 6.0),
                blurRadius: 15.0,
              ),
            ],
          ),
          child: Container(
            padding: EdgeInsets.symmetric(
                vertical: Get.height * 0.02, horizontal: Get.width * 0.03),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Align(
                  alignment: Alignment(0.0, 0.23),
                  child: Text(
                    'pending requests',
                    style: MyTextStyles.montsNormal16.copyWith(
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Text(
                  '${p.pendingRequests.length}',
                  style: MyTextStyles.montsNormal16.copyWith(
                    fontSize: 24.0,
                    color: const Color(0xFFF99D22),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget contactUs() {
    return Container(
      padding: EdgeInsets.symmetric(
          vertical: Get.width * 0.03, horizontal: Get.width * 0.03),
      width: Get.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(7.0),
        color: const Color(0xFFFCFCFC),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.16),
            offset: Offset(0, 6.0),
            blurRadius: 15.0,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          info(
              title: "contact us",
              content: "come across any problem? we're happy to help."),
          info(
              title: "my accounts",
              content: "view and manage all your accounts"),
          info(
              title: "manage members",
              content: "add/remove members and permissions")
        ],
      ),
    );
  }

  Widget info({String title, String content}) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: Get.width * 0.01),
            child: Text(
              '$title',
              style: MyTextStyles.montsBold16.copyWith(
                fontSize: 16.0,
                color: Colors.black,
                fontWeight: FontWeight.w700,
                height: 1.38,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Text(
              '$content',
              style: MyTextStyles.montsNormal16.copyWith(
                fontSize: 14.0,
                color: Colors.black,
                height: 1.38,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 12),
            child: Divider(
              height: 1.5,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
