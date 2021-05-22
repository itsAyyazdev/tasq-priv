import 'package:cloud_firestore/cloud_firestore.dart';

class OrgMember {
  String orgId;
  DocumentReference user;
  String acceptedAt;
  String requestedAt;
  int status;

  OrgMember(
      {this.orgId, this.user, this.acceptedAt, this.requestedAt, this.status});

  OrgMember.fromJson(dynamic json) {
    orgId = json["org_id"];
    user = json["user"];
    acceptedAt = json["accepted_at"];
    requestedAt = json["requested_at"];
    status = json["status"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["org_id"] = orgId;
    map["user"] = user;
    map["accepted_at"] = acceptedAt;
    map["requested_at"] = requestedAt;
    map["status"] = status;
    return map;
  }
}
