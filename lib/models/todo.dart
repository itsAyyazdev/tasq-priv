import 'package:cloud_firestore/cloud_firestore.dart';

class Todo {
  Timestamp date;
  String name;
  bool isChecked;
  String userId;
  String id;

  Todo({this.date, this.name, this.isChecked, this.userId, this.id});

  Todo.fromJson(dynamic json) {
    date = json["date"];
    name = json["name"];
    isChecked = json["is_checked"];
    id = json["id"];
    userId = json["user_id"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["date"] = date;
    map["name"] = name;
    map["is_checked"] = isChecked;
    map["user_id"] = userId;
    map["id"] = id;
    return map;
  }
}
