import 'package:tasq/ui/widgets/shared/ExploreRewardWidget.dart';
import 'package:tasq/ui/widgets/shared/empty_screen.dart';
import 'package:tasq/utils/globals/import_hub.dart';

class ExploreAndAdd extends StatelessWidget {
  final Function onAddTapped;
  ExploreAndAdd({this.onAddTapped});
  @override
  Widget build(BuildContext context) {
    return Consumer<AdminProvider>(
      builder: (context, p, _) {
        if (p.exploreRewards.isEmpty) {
          return EmptyScreen(
            msg: "No rewards to explore",
          );
        } else {
          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(
                  top: 8.0, left: Get.width * 0.03, right: Get.width * 0.03),
              child: Column(
                children: List.generate(p.exploreRewards.length, (index) {
                  return ExploreRewardWidget(
                    reward: p.exploreRewards[index],
                    onButtonTap: (reward) async {
                      await p.addToMyRewards(reward);
                      onAddTapped();
                    },
                    buttonTitle: "add to my rewards",
                  );
                }),
              ),
            ),
          );
        }
      },
    );
  }
}
