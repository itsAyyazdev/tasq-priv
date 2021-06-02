import 'package:cloud_firestore/cloud_firestore.dart';

class JobApplication {
  Proposal proposal;
  Timestamp appliedAt;
  String applicantName, roomId;
  DocumentReference jobRef;
  String jobId, orgId;
  int status;
  DocumentReference applicant;

  JobApplication(
      {this.proposal,
      this.appliedAt,
      this.status,
      this.jobRef,
      this.orgId,
      this.roomId,
      this.applicantName,
      this.jobId,
      this.applicant});

  JobApplication.fromJson(dynamic json) {
    proposal =
        json["proposal"] != null ? Proposal.fromJson(json["proposal"]) : null;
    appliedAt = json["applied_at"];
    status = json["status"];
    applicant = json["applicant"];
    jobId = json["job_id"];
    roomId = json["room_id"];
    jobRef = json["job_ref"];
    orgId = json["org_id"];
    applicantName = json["applicantName"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    if (proposal != null) {
      map["proposal"] = proposal.toJson();
    }
    map["applied_at"] = appliedAt;
    map["status"] = status;
    map["applicant"] = applicant;
    map["job_ref"] = jobRef;
    map["job_id"] = jobId;
    map["org_id"] = orgId;
    map["room_id"] = roomId;
    map["applicantName"] = applicantName;
    return map;
  }
}

class Proposal {
  String proposal;

  Proposal({this.proposal});

  Proposal.fromJson(dynamic json) {
    proposal = json["proposal"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["proposal"] = proposal;
    return map;
  }
}
