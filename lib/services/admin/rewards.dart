import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tasq/models/reward_model.dart';
import 'package:tasq/utils/constants/firebase_collections.dart';
import 'package:tasq/utils/globals/import_hub.dart';

abstract class RewardsServices {
  Future<List<RewardModel>> fetchAllRewards();
  Future<void> postReward({RewardModel reward});
}

class RS implements RewardsServices {
  FirebaseFirestore db = FirebaseFirestore.instance;
  @override
  Future<List<RewardModel>> fetchAllRewards() async {
    CollectionReference ref = FBCollections.rewards;
    Query query =
        ref /*.where("org_id", isEqualTo: AppUser.organization.orgId)*/;
    QuerySnapshot qs = await query.get();
    List<RewardModel> rewards = [];
    if (qs.docs.isNotEmpty) {
      qs.docs.forEach((reward) {
        rewards.add(RewardModel.fromJson(reward));
      });
    }
    return Future.value(rewards);
  }

  @override
  Future<void> postReward({RewardModel reward}) async {
    String docId = AppUtils.getFreshTimeStamp();
    DocumentReference docRef = FBCollections.rewards.doc(docId);
    reward.rewardId = docId;
    await db.runTransaction((trx) async => trx.set(docRef, reward.toJson()));
  }
}
