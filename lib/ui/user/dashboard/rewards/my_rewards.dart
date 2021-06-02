import 'package:loading_overlay/loading_overlay.dart';
import 'package:tasq/ui/user/dashboard/rewards/explore_rewards.dart';
import 'package:tasq/utils/globals/app_data/app_user.dart';
import 'package:tasq/utils/globals/import_hub.dart';

class UserRewardsHome extends StatefulWidget {
  @override
  _UserRewardsHomeState createState() => _UserRewardsHomeState();
}

class _UserRewardsHomeState extends State<UserRewardsHome>
    with TickerProviderStateMixin {
  TabController tCont;
  initTabController() {
    tCont = TabController(length: 2, vsync: this);
  }

  @override
  void initState() {
    initTabController();
    UserProvider p = Provider.of<UserProvider>(context, listen: false);
    p.getRewardsData();
    super.initState();
  }

  @override
  void dispose() {
    UserProvider p = Provider.of<UserProvider>(context, listen: false);
    p.onDispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(
        builder: (context, p, _) => LoadingOverlay(
              isLoading: p.isLoading,
              child: Scaffold(
                appBar: MyAppbar(
                  title: "rewards",
                  showChatIcon: false,
                  trailing: Row(
                    children: [
                      _myPoints(),
                      SizedBox(
                        width: 24,
                      ),
                      ChatIcon(
                        onTap: () {},
                      )
                    ],
                  ),
                ),
                body: Container(
                  padding: AppUtils.generalOuterPadding,
                  child: body(),
                ),
              ),
            ));
  }

  Widget body() {
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
                index == 0 ? "my rewards" : "explore",
                style: MyTextStyles.montsSemiBold16
                    .copyWith(color: Colors.black, fontSize: 20),
              ),
            );
          }),
        ),
        Expanded(
          child: TabBarView(controller: tCont, children: [
            UserRewards(),
            ExploreRewards(),
          ]),
        ),
      ],
    );
  }

  Widget _myPoints() {
    double tSize = 24;
    return Container(
      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24.0),
        color: Colors.white,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            width: tSize,
            height: tSize,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                begin: Alignment(-0.39, -0.76),
                end: Alignment(0.56, 0.76),
                colors: [const Color(0xFF8A58FF), const Color(0xFF1B02C7)],
              ),
            ),
            child: Center(
              child: Text(
                't',
                style: MyTextStyles.montsNormal16.copyWith(
                  fontSize: 14,
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
          SizedBox(
            width: tSize - 12,
          ),
          Text(
            "${AppUser.user.points ?? 0}",
            style: MyTextStyles.montsNormal16.copyWith(
              fontSize: 18,
              color: AppConfig.colors.themeBlue,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
