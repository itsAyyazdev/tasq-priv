import 'package:tasq/ui/widgets/shared/logout_button.dart';
import 'package:tasq/utils/globals/import_hub.dart';

class UserPreferences extends StatefulWidget {
  @override
  _UserPreferencesState createState() => _UserPreferencesState();
}

class _UserPreferencesState extends State<UserPreferences> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppbar(
        title: "preferences",
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            AdminInfoCard(
              isEdit: true,
              isAdmin: false,
            ),
            SizedBox(
              height: Get.height * 0.04,
            ),
            contactUs(),
            SizedBox(height: Get.height * 0.14),
            LogoutButton(
              topPadding: Get.height * .06,
            ),
          ],
        ),
      ),
    );
  }

  Widget contactUs() {
    return Container(
      padding: EdgeInsets.symmetric(
          vertical: Get.width * 0.05, horizontal: Get.width * 0.03),
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
