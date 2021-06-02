import 'package:loading_overlay/loading_overlay.dart';
import 'package:tasq/ui/widgets/admin/my_fab.dart';
import 'package:tasq/utils/globals/import_hub.dart';

class AdminRewards extends StatefulWidget {
  @override
  _AdminRewardsState createState() => _AdminRewardsState();
}

class _AdminRewardsState extends State<AdminRewards>
    with TickerProviderStateMixin {
  TabController tCont;
  initTabController() {
    tCont = TabController(length: 2, vsync: this);
  }

  @override
  void initState() {
    initTabController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AdminProvider>(
      builder: (context, p, _) => LoadingOverlay(
        isLoading: p.isLoading,
        child: Scaffold(
          floatingActionButton: MyFAB(
            text: "+",
            onTap: () {
              AppRoutes.push(context, AddNewReward());
            },
          ),
          body: Column(
            children: [
              SizedBox(
                height: Get.height * 0.02,
              ),
              TabBar(
                controller: tCont,
                indicatorColor: Colors.black,
                indicatorSize: TabBarIndicatorSize.tab,
                tabs: List.generate(2, (index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(
                      index == 0 ? "rewards" : "add and explore",
                      style: MyTextStyles.montsSemiBold16.copyWith(
                          color: Colors.black, fontSize: index == 0 ? 20 : 16),
                    ),
                  );
                }),
              ),
              Expanded(
                child: TabBarView(controller: tCont, children: [
                  MyRewards(),
                  ExploreAndAdd(
                    onAddTapped: () => tCont.index = 0,
                  ),
                ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
