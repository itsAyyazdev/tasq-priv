import 'package:cloud_firestore/cloud_firestore.dart';

class ChatRoom {
  int unreadCount;
  String jobId;
  Timestamp createdAt;
  String createdBy;
  String roomId;
  List<String> users;

  ChatRoom(
      {this.unreadCount,
      this.jobId,
      this.createdAt,
      this.createdBy,
      this.roomId,
      this.users});

  ChatRoom.fromJson(dynamic json) {
    unreadCount = json["unread_count"];
    jobId = json["job_id"];
    roomId = json["room_id"];
    createdAt = json["created_at"];
    createdBy = json["created_by"];
    users = json["users"] != null ? json["users"].cast<String>() : [];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["unread_count"] = unreadCount;
    map["job_id"] = jobId;
    map["created_at"] = createdAt;
    map["room_id"] = roomId;
    map["created_by"] = createdBy;
    map["users"] = users;
    return map;
  }
}
