import 'package:cloud_firestore/cloud_firestore.dart';

class TeamModel {
  String orgId;
  DocumentReference member;
  String teamId;
  int status;

  TeamModel({this.orgId, this.member, this.teamId, this.status});

  TeamModel.fromJson(dynamic json) {
    orgId = json["org_id"];
    member = json["member"];
    teamId = json["team_id"];
    status = json["status"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["org_id"] = orgId;
    map["member"] = member;
    map["team_id"] = teamId;
    map["status"] = status;
    return map;
  }
}
