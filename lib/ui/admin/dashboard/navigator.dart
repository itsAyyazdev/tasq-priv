import 'package:tasq/utils/constants/text_styles.dart';
import 'package:tasq/utils/globals/app_data/app_user.dart';
import 'package:tasq/utils/globals/import_hub.dart';

class OrgDashboard extends StatefulWidget {
  @override
  _OrgDashboardState createState() => _OrgDashboardState();
}

class _OrgDashboardState extends State<OrgDashboard> {
  List<String> bottomNames = ["home", "rewards", "preferences", "me"];
  List<IconData> bottomIcons = [
    Icons.home,
    Icons.card_giftcard_rounded,
    Icons.settings,
  ];
  PageController _controller = PageController();

  @override
  void didChangeDependencies() {
    Future.delayed(Duration(milliseconds: 200), () {
      Provider.of<AdminProvider>(context, listen: false).onInit();
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AppProvider>(
        builder: (context, p, _) => Scaffold(
              appBar: MyAppbar(
                title: p.appbarTitle ?? "-",
                onChatTapped: p.onChatTapped,
              ),
              body: PageView(
                controller: _controller,
                children: [
                  AdminHome(),
                  AdminRewards(),
                  AdminPreferences(),
                  AdminProfile(),
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
    return Expanded(
      child: Container(
        child: InkWell(
          onTap: () => onTap(index, p),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              index > 2
                  ? CircleAvatar(
                      radius: 14,
                      backgroundColor: AppConfig.colors.smokeWhite,
                      child:
                          Text("${AppUser.user?.name?.substring(0, 1) ?? "N"}"),
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
    p.setPageTitle(i == 0 ? "YFS-Pak" : bottomNames[i], duration);
  }
}
