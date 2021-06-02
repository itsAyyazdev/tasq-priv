import 'package:cloud_firestore/cloud_firestore.dart';

class RewardModel {
  String name;
  String description;
  Timestamp createdAt;
  String voucher;
  String companyName;
  String companyLogo;
  String rewardId;
  String orgId;
  bool isActive;
  int points;
  Timestamp validTill;

  RewardModel(
      {this.name,
      this.description,
      this.voucher,
      this.createdAt,
      this.companyName,
      this.companyLogo,
      this.rewardId,
      this.orgId,
      this.points,
      this.isActive,
      this.validTill});

  RewardModel.fromJson(dynamic json) {
    name = json["name"];
    description = json["description"];
    voucher = json["voucher"];
    companyName = json["companyName"];
    companyLogo = json["companyLogo"];
    rewardId = json["rewardId"];
    isActive = json["is_active"];
    createdAt = json["created_at"];
    orgId = json["org_id"];
    points = json["points"];
    validTill = json["validTill"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["name"] = name;
    map["description"] = description;
    map["voucher"] = voucher;
    map["companyName"] = companyName;
    map["companyLogo"] = companyLogo;
    map["rewardId"] = rewardId;
    map["org_id"] = orgId;
    map["is_active"] = isActive;
    map["created_at"] = createdAt;
    map["validTill"] = validTill;
    map["points"] = points;
    return map;
  }
}
