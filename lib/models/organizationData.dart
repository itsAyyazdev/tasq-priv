import 'package:cloud_firestore/cloud_firestore.dart';

class Organization {
  String ownerName;
  String ownerId;
  String orgId;
  String name, logo;
  Timestamp createdAt;
  bool isActive;

  Organization({
    this.ownerName,
    this.ownerId,
    this.orgId,
    this.name,
    this.logo,
    this.isActive,
    this.createdAt,
  });

  Organization.fromJson(dynamic json) {
    ownerName = json["owner_name"];
    ownerId = json["owner_id"];
    orgId = json["org_id"];
    logo = json["logo"];
    name = json["name"];
    isActive = json["isActive"];
    createdAt = json["created_at"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["owner_name"] = ownerName;
    map["owner_id"] = ownerId;
    map["org_id"] = orgId;
    map["logo"] = logo;
    map["name"] = name;
    map["isActive"] = isActive;
    map["created_at"] = createdAt;

    return map;
  }
}

class Member {
  String email;
  String name;

  Member({this.email, this.name});

  Member.fromJson(dynamic json) {
    email = json["uid"];
    name = json["Name"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["uid"] = email;
    map["Name"] = name;
    return map;
  }
}
