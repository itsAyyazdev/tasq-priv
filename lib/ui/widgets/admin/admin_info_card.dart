import 'package:tasq/utils/globals/app_data/app_user.dart';
import 'package:tasq/utils/globals/import_hub.dart';

class AdminInfoCard extends StatelessWidget {
  final bool isEdit;
  final bool isAdmin;
  AdminInfoCard({this.isEdit, this.isAdmin = true});
  @override
  Widget build(BuildContext context) {
    String firstName = AppUser.user?.name?.split(" ")?.first ?? "";
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: Get.width * 0.05, vertical: Get.height * 0.03),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.black,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Hello " + "$firstName" + " :)",
            style: MyTextStyles.montsSemiBold16
                .copyWith(color: Colors.white, fontSize: 22),
          ),
          !isAdmin
              ? Container()
              : Container(
                  width: MediaQuery.of(context).size.width * 0.2,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    gradient: LinearGradient(colors: [
                      AppConfig.colors.saffronYellow,
                      AppConfig.colors.carrotYellow,
                    ]),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.bolt, color: Colors.white),
                      Text(
                        "admin",
                        style: MyTextStyles.montsSemiBold16
                            .copyWith(color: Colors.white),
                      ),
                    ],
                  ),
                ),
        ],
      ),
    );
  }
}
