import 'package:tasq/ui/user/dashboard/rewards/explore_card.dart';
import 'package:tasq/utils/globals/app_data/dummy_data.dart';
import 'package:tasq/utils/globals/import_hub.dart';

class ExploreRewards extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
          itemCount: DummyData.rewards.length,
          itemBuilder: (context, index) {
            return RewardExploreCard(
              reward: DummyData.rewards[index],
              color: index % 2 == 0
                  ? AppConfig.colors.green
                  : AppConfig.colors.red,
            );
          }),
    );
  }
}
