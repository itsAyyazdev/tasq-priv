import 'package:flutter/material.dart';
import 'package:tasq/models/reward_model.dart';
import 'package:tasq/models/reward_user.dart';
import 'package:tasq/ui/widgets/shared/ExploreRewardWidget.dart';
import 'package:tasq/ui/widgets/shared/empty_screen.dart';
import 'package:tasq/utils/globals/import_hub.dart';

class UserRewards extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(builder: (context, p, _) {
      if (p.myRewards.isEmpty) {
        return EmptyScreen(
          msg: "No Rewards won yet",
        );
      } else {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: Get.width * 0.015),
          child: ListView.builder(
              itemCount: p.myRewards.length,
              itemBuilder: (context, index) {
                RewardUser rewardUser = p.myRewards[index];
                return ExploreRewardWidget(
                  reward: rewardUser.reward,
                  buttonTitle: rewardUser.reward.voucher ?? "",
                  onButtonTap: (RewardModel reward) {
                    print(reward.name);
                  },
                );
              }),
        );
      }
    });
  }
}
