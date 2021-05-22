import 'package:tasq/models/reward_model.dart';
import 'package:tasq/ui/widgets/shared/ExploreRewardWidget.dart';
import 'package:tasq/utils/globals/import_hub.dart';

class ExploreAndAdd extends StatelessWidget {
  final List<RewardModel> rewards;
  final Function onAddTapped;
  ExploreAndAdd({@required this.rewards, this.onAddTapped});
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(
            top: 8.0, left: Get.width * 0.03, right: Get.width * 0.03),
        child: Column(
          children: List.generate(rewards.length, (index) {
            return ExploreRewardWidget(
              reward: rewards[index],
              onButtonTap: onAddTapped,
            );
          }),
        ),
      ),
    );
  }
}
