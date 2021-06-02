import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tasq/models/reward_model.dart';

class RewardUser {
  String userId;
  Timestamp addedAt;
  RewardModel reward;
  int points;

  RewardUser({this.userId, this.addedAt, this.reward, this.points});

  RewardUser.fromJson(dynamic json) {
    userId = json["user_id"];
    addedAt = json["added_at"];
    reward =
        json["reward"] != null ? RewardModel.fromJson(json["reward"]) : null;
    points = json["points"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["user_id"] = userId;
    map["added_at"] = addedAt;
    if (reward != null) {
      map["reward"] = reward.toJson();
    }
    map["points"] = points;
    return map;
  }
}

class Reward {
  String reward;

  Reward({this.reward});

  Reward.fromJson(dynamic json) {
    reward = json["reward"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["reward"] = reward;
    return map;
  }
}
