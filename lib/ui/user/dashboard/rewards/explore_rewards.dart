import 'package:tasq/models/reward_model.dart';
import 'package:tasq/ui/user/dashboard/rewards/explore_card.dart';
import 'package:tasq/ui/widgets/shared/empty_screen.dart';
import 'package:tasq/ui/widgets/shared/shimmers/reward.dart';
import 'package:tasq/utils/globals/import_hub.dart';

class ExploreRewards extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(builder: (context, p, _) {
      if (p.isLoading) {
        return RewardShimmer();
      } else {
        if (p.exploreRewards.isEmpty) {
          return EmptyScreen(
            msg: "No Rewards Found",
          );
        } else {
          return Container(
            child: ListView.builder(
                itemCount: p.exploreRewards.length,
                itemBuilder: (context, index) {
                  RewardModel reward = p.exploreRewards[index];
                  return RewardExploreCard(
                    reward: reward,
                    color: index % 2 == 0
                        ? AppConfig.colors.green
                        : AppConfig.colors.red,
                  );
                }),
          );
        }
      }
    });
  }
}
