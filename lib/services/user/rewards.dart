import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tasq/models/reward_model.dart';
import 'package:tasq/models/reward_user.dart';
import 'package:tasq/services/firestore_services.dart';
import 'package:tasq/utils/constants/firebase_collections.dart';
import 'package:tasq/utils/globals/app_data/app_user.dart';
import 'package:tasq/utils/globals/import_hub.dart';

abstract class UserRewardsServices {
  Future<List<RewardUser>> getMyRewards();
  Future<List<RewardModel>> fetchAllRewards();
  Future<void> redeemReward({RewardUser rewardUser});
}

class RewardsServices implements UserRewardsServices {
  FirebaseFirestore db = FirebaseFirestore.instance;
  AuthFSServices fs = CFS();
  @override
  Future<List<RewardModel>> fetchAllRewards() async {
    QuerySnapshot qs = await FBCollections.rewards.get();
    List<RewardModel> rewards = [];
    qs.docs.forEach((r) {
      rewards.add(RewardModel.fromJson(r.data()));
    });
    return Future.value(rewards);
  }

  @override
  Future<List<RewardUser>> getMyRewards() async {
    Query query = FBCollections.rewardUsers;
    query = query.where("user_id", isEqualTo: AppUser.user.email);
    QuerySnapshot qs = await query.get();
    List<RewardUser> rUsers = [];
    qs.docs.forEach((ru) {
      rUsers.add(RewardUser.fromJson(ru.data()));
    });
    return Future.value(rUsers);
  }

  @override
  Future<void> redeemReward({RewardUser rewardUser}) async {
    String docId = AppUtils.getFreshTimeStamp();
    DocumentReference docRef = FBCollections.rewardUsers.doc(docId);
    rewardUser.addedAt = Timestamp.now();
    db.runTransaction((trx) async => trx.set(docRef, rewardUser.toJson()));
    await subtractPoints(rewardUser.reward.points ?? 0);
  }

  Future<void> subtractPoints(int points) async {
    int currentPoints = AppUser.user.points ?? 0;
    int addition = currentPoints - points;
    Map<String, int> payload = {"points": addition};
    await fs.updateUserData(userEmail: AppUser.user.email, payload: payload);
  }
}
