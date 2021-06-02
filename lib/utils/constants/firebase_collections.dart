import 'package:cloud_firestore/cloud_firestore.dart';

class FBCollections {
  static FirebaseFirestore db = FirebaseFirestore.instance;
  static CollectionReference users = db.collection("usersT");
  static CollectionReference organizations = db.collection("organizationsT");
  static CollectionReference teams = db.collection("teamsT");
  static CollectionReference rewards = db.collection("rewardsT");
  static CollectionReference rewardUsers = db.collection("rewardsUsersT");
  static CollectionReference jobApplications =
      db.collection("jobApplicationsT");
  static CollectionReference orgMembers = db.collection("orgMembersT");
  static CollectionReference jobs = db.collection("jobsT");
  static CollectionReference chatRooms = db.collection("chatRoomsT");
  static CollectionReference todos = db.collection("todosT");
  static CollectionReference chats = db.collection("chatsT");
}
