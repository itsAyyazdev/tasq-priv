import 'package:cloud_firestore/cloud_firestore.dart';

class Job {
  String rewardOfferName;
  bool isActive;
  String assignToId;
  int assignType;
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
  String postedBy;

  AssignTo assignTo;
  int points, status;

  Job(
      {this.rewardOfferName,
      this.isActive,
      this.orgId,
      this.assignTo,
      this.description,
      this.postedAt,
      this.jobId,
      this.expiry,
      this.title,
      this.orgName,
      this.postedBy,
      this.status,
      this.category,
      this.categoryId,
      this.assignToId,
      this.rewardOfferId,
      this.points,
      this.assignType});

  Job.fromJson(dynamic json) {
    rewardOfferName = json["reward"];
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
    assignType = json["assign_type"];
    assignToId = json["assign_to_id"];
    rewardOfferId = json["rewardOffer_id"];
    postedBy = json["posted_by"];
    points = json["points"];
    status = json["status"];
    assignTo =
        json["assign_to"] != null ? AssignTo.fromJson(json["assign_to"]) : null;
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["reward"] = rewardOfferName;
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
    map["assign_to_id"] = assignToId;
    map["assign_type"] = assignType;
    map["rewardOffer_id"] = rewardOfferId;
    map["points"] = points;
    map["posted_by"] = postedBy;
    map["assign_to"] = assignTo;
    map["status"] = status;
    if (assignTo != null) {
      map["assign_to"] = assignTo.toJson();
    }
    return map;
  }
}

class AssignTo {
  String name;
  String proposal;
  String applicationId;

  AssignTo({
    this.name,
    this.proposal,
    this.applicationId,
  });

  AssignTo.fromJson(dynamic json) {
    name = json["name"];
    proposal = json["proposal"];
    applicationId = json["application_id"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["name"] = name;
    map["proposal"] = proposal;
    map["application_id"] = applicationId;

    return map;
  }
}
