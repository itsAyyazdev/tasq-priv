import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tasq/models/reward_model.dart';
import 'package:tasq/utils/constants/firebase_collections.dart';
import 'package:tasq/utils/globals/import_hub.dart';

abstract class RewardsServices {
  Future<Stream<List<RewardModel>>> fetchAllRewards();
  Future<void> postReward({RewardModel reward});
}

class RS implements RewardsServices {
  FirebaseFirestore db = FirebaseFirestore.instance;
  @override
  Future<Stream<List<RewardModel>>> fetchAllRewards() async {
    var ref = FBCollections.rewards.snapshots().asBroadcastStream();
    var x = ref.map((event) =>
        event.docs.map((e) => RewardModel.fromJson(e.data())).toList());
    return x;
  }

  @override
  Future<void> postReward({RewardModel reward}) async {
    String docId = AppUtils.getFreshTimeStamp();
    DocumentReference docRef = FBCollections.rewards.doc(docId);
    reward.rewardId = docId;
    await db.runTransaction((trx) async => trx.set(docRef, reward.toJson()));
  }
}
