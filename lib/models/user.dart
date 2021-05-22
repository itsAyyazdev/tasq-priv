import 'package:cloud_firestore/cloud_firestore.dart';

class UserData {
  String uid;
  int role;
  bool isOrg;
  String orgId;
  String email;
  String imageUrl;
  String name;
  int points;
  bool isActive;
  Timestamp createdAt;

  UserData(
      {this.uid,
      this.role,
      this.isOrg,
      this.orgId,
      this.points,
      this.imageUrl,
      this.email,
      this.isActive,
      this.name,
      this.createdAt});

  UserData.fromJson(dynamic json) {
    uid = json["uid"];
    email = json["email"];
    role = json["role"];
    isOrg = json["is_org"];
    orgId = json["org_id"];
    isActive = json["isActive"];
    imageUrl = json["image_url"];
    points = json["points"];
    name = json["name"];
    createdAt = json["created_at"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["uid"] = uid;
    map["email"] = email;
    map["is_org"] = isOrg;
    map["org_id"] = orgId;
    map["role"] = role;
    map["image_url"] = imageUrl;
    map["isActive"] = isActive;
    map["name"] = name;
    map["points"] = points;
    map["created_at"] = createdAt;
    return map;
  }
}
