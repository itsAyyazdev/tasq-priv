class RewardModel {
  String name;
  String description;
  String voucher;
  String companyName;
  String companyLogo;
  String rewardId;
  String orgId;
  bool isActive;
  DateTime validTill;

  RewardModel(
      {this.name,
      this.description,
      this.voucher,
      this.companyName,
      this.companyLogo,
      this.rewardId,
      this.orgId,
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
    orgId = json["org_id"];
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
    map["validTill"] = validTill;
    return map;
  }
}
