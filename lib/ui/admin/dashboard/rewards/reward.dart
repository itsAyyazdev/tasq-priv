import 'package:tasq/ui/widgets/admin/my_fab.dart';
import 'package:tasq/utils/globals/app_data/dummy_data.dart';
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
    return Scaffold(
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
                  style: MyTextStyles.montsSemiBold16
                      .copyWith(color: Colors.black, fontSize: 20),
                ),
              );
            }),
          ),
          Expanded(
            child: TabBarView(controller: tCont, children: [
              MyRewards(),
              ExploreAndAdd(
                rewards: DummyData.rewards,
                onAddTapped: () => tCont.index = 0,
              ),
            ]),
          ),
        ],
      ),
    );
  }
}
