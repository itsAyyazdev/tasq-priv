import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  String msg;
  Timestamp sentAt;
  String fileUrl;
  String receiverId;
  int type;
  String senderId;
  String roomId;
  bool seen;

  Message(
      {this.msg,
      this.sentAt,
      this.fileUrl,
      this.receiverId,
      this.type,
      this.senderId,
      this.roomId,
      this.seen});

  Message.fromJson(dynamic json) {
    msg = json["msg"];
    sentAt = json["sent_at"];
    fileUrl = json["file_url"];
    receiverId = json["receiver_id"];
    roomId = json["room_id"];
    type = json["type"];
    senderId = json["sender_id"];
    seen = json["seen"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["msg"] = msg;
    map["sent_at"] = sentAt;
    map["file_url"] = fileUrl;
    map["receiver_id"] = receiverId;
    map["type"] = type;
    map["sender_id"] = senderId;
    map["room_id"] = roomId;
    map["seen"] = seen;
    return map;
  }
}
