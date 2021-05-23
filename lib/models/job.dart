import 'package:cloud_firestore/cloud_firestore.dart';

class Job {
  String reward;
  bool isActive;
  String assignTo;
  String orgId;
  String jobId;
  String description;
  Timestamp postedAt;
  Timestamp expiry;
  String title;
  String category;
  String rewardOfferId;
  int categoryId;
  String orgName;

  Job({
    this.reward,
    this.isActive,
    this.orgId,
    this.description,
    this.postedAt,
    this.jobId,
    this.expiry,
    this.title,
    this.orgName,
    this.category,
    this.categoryId,
    this.assignTo,
    this.rewardOfferId,
  });

  Job.fromJson(dynamic json) {
    reward = json["reward"];
    isActive = json["is_active"];
    jobId = json["job_id"];
    orgId = json["org_id"];
    description = json["description"];
    postedAt = json["posted_at"];
    expiry = json["expiry"];
    title = json["title"];
    orgName = json["org_name"];
    category = json["category"];
    categoryId = json["category_id"];
    assignTo = json["assignTo"];
    rewardOfferId = json["rewardOffer_id"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["reward"] = reward;
    map["is_active"] = isActive;
    map["job_id"] = jobId;
    map["org_id"] = orgId;
    map["description"] = description;
    map["posted_at"] = postedAt;
    map["expiry"] = expiry;
    map["title"] = title;
    map["org_name"] = orgName;
    map["category"] = category;
    map["category_id"] = categoryId;
    map["assignTo"] = assignTo;
    map["rewardOffer_id"] = rewardOfferId;

    return map;
  }
}
