import 'package:flutter/material.dart';
import 'package:tasq/ui/widgets/shared/ExploreRewardWidget.dart';
import 'package:tasq/utils/globals/app_data/dummy_data.dart';
import 'package:tasq/utils/globals/import_hub.dart';

class UserRewards extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: Get.width * 0.015),
      child: ListView.builder(
          itemCount: DummyData.rewards.length,
          itemBuilder: (context, index) {
            return ExploreRewardWidget(
              reward: DummyData.rewards[index],
              buttonTitle: DummyData.rewards[index].voucher ?? "",
            );
          }),
    );
  }
}
