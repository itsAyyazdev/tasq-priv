import 'package:cloud_firestore/cloud_firestore.dart';

class Job {
  String reward;
  bool isActive;
  Timestamp expiry;
  String orgId, jobId;
  String description;
  Timestamp postedAt;

  String title;
  String orgRef;
  String orgName;

  int points;

  Job(
      {this.reward,
      this.isActive,
      this.orgId,
      this.description,
      this.postedAt,
      this.jobId,
      this.expiry,
      this.title,
      this.orgRef,
      this.orgName,
      this.points});

  Job.fromJson(dynamic json) {
    reward = json["reward"];
    isActive = json["is_active"];
    jobId = json["job_id"];

    orgId = json["org_id"];
    description = json["description"];
    postedAt = json["posted_at"];
    expiry = json["expiry"];
    title = json["title"];
    orgRef = json["org_ref"];
    orgName = json["org_name"];
    points = json["points"];
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
    map["org_ref"] = orgRef;
    map["org_name"] = orgName;
    map["points"] = points;
    return map;
  }
}
