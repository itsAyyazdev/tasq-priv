import 'package:tasq/ui/user/dashboard/rewards/my_rewards.dart';
import 'package:tasq/utils/globals/app_data/app_user.dart';
import 'package:tasq/utils/globals/import_hub.dart';

class UserDashboard extends StatefulWidget {
  @override
  _UserDashboardState createState() => _UserDashboardState();
}

class _UserDashboardState extends State<UserDashboard> {
  List<String> bottomNames = [
    "home",
    "rewards",
    "explore",
    "preferences",
    "me"
  ];
  List<IconData> bottomIcons = [
    Icons.home,
    Icons.card_giftcard_rounded,
    Icons.explore,
    Icons.settings,
  ];
  PageController _controller = PageController();
  @override
  Widget build(BuildContext context) {
    return Consumer<AppProvider>(
        builder: (context, p, _) => Scaffold(
              body: PageView(
                controller: _controller,
                children: [
                  UserHome(),
                  UserRewardsHome(),
                  UserExploreSkills(),
                  UserPreferences(),
                  UserProfile()
                ],
              ),
              bottomNavigationBar: BottomAppBar(
                child: Container(
                  height: Get.height * 0.09,
                  child: Row(
                    children: List.generate(
                        bottomNames.length, (index) => bottomBarItem(index, p)),
                  ),
                ),
              ),
            ));
  }

  Widget bottomBarItem(int index, AppProvider p) {
    String namesFirstChar = AppUser.user?.name?.substring(0, 1) ?? "N";
    return Expanded(
      child: Container(
        child: InkWell(
          onTap: () => onTap(index, p),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              index > 3
                  ? CircleAvatar(
                      radius: 14,
                      backgroundColor: AppConfig.colors.smokeWhite,
                      child: Text("$namesFirstChar"),
                    )
                  : Icon(
                      bottomIcons[index],
                      color: Colors.black.withOpacity(0.66),
                      size: 30,
                    ),
              Padding(
                padding: const EdgeInsets.only(top: 3.0),
                child: Text(
                  bottomNames[index],
                  style: MyTextStyles.montsNormal16.copyWith(
                    fontSize: Get.width * 0.032,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  //handle bottom bar tap
  void onTap(int i, AppProvider p) {
    var duration = AppUtils.pageTrxDuration;
    print(i);
    _controller.animateToPage(i, duration: duration, curve: Curves.decelerate);
    p.setPageTitle(bottomNames[i], duration);
  }
}
