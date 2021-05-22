import 'package:cloud_firestore/cloud_firestore.dart';

class Todo {
  String date;
  String name;
  int priority;
  DocumentReference user;

  Todo({this.date, this.name, this.priority, this.user});

  Todo.fromJson(dynamic json) {
    date = json["date"];
    name = json["name"];
    priority = json["priority"];
    user = json["user"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["date"] = date;
    map["name"] = name;
    map["priority"] = priority;
    map["user"] = user;
    return map;
  }
}
