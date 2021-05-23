import 'package:tasq/models/reward_model.dart';

abstract class UserRewardsServices {
  Future<List<RewardModel>> getMyRewards();
  Future<List<RewardModel>> exploreAllRewards();
  Future<void> redeemReward();
}

class RewardsServices implements UserRewardsServices {
  @override
  Future<List<RewardModel>> exploreAllRewards() {
    // TODO: implement exploreAllRewards
    throw UnimplementedError();
  }

  @override
  Future<List<RewardModel>> getMyRewards() {
    // TODO: implement getMyRewards
    throw UnimplementedError();
  }

  @override
  Future<void> redeemReward() {
    // TODO: implement redeemReward
    throw UnimplementedError();
  }
}
