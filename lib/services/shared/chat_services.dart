import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tasq/models/chat_room.dart';
import 'package:tasq/models/message.dart';
import 'package:tasq/models/user.dart';
import 'package:tasq/services/firestorage_service.dart';
import 'package:tasq/utils/constants/firebase_collections.dart';
import 'package:tasq/utils/globals/app_data/app_user.dart';
import 'package:tasq/utils/globals/utils.dart';

abstract class ChatServices {
  Future<void> sendMessage({Message msg});
  Future<String> uploadFile({File file});
  Stream<QuerySnapshot<Object>> buildConversationList({String roomId});
  Future<Stream<List<ChatRoom>>> getAllChatRooms();
  Stream<QuerySnapshot> chatUnreadMessages(String roomId);
  Future<ChatRoom> createChatRoom({ChatRoom room});
  Future<ChatRoom> getChatRoomById({String roomId});
}

class CSs implements ChatServices {
  FirebaseFirestore db = FirebaseFirestore.instance;
  @override
  Future<void> sendMessage({Message msg}) async {
    String timeStamp = DateTime.now().microsecondsSinceEpoch.toString();

    DocumentReference managerDocRef = FBCollections.chats.doc(timeStamp);
    msg.sentAt = Timestamp.now();
    var m = msg.toJson();
    db.runTransaction((transaction) async {
      transaction.set(
        managerDocRef,
        m,
      );
    });
  }

  @override
  Future<String> uploadFile({File file}) async {
    String url = await FStorageServices().uploadSingleFile(
        bucketName: "chat media", file: file, userEmail: AppUser.user.email);
    return url;
  }

  Future<String> getUserFCM({String userId}) async {
    DocumentSnapshot doc = await FBCollections.users.doc(userId).get();
    UserData user = UserData.fromJson(doc.data());
    return user.fcm;
  }

  @override
  Stream<QuerySnapshot<Object>> buildConversationList({String roomId}) {
    var messages = FBCollections.chats
        .where("room_id", isEqualTo: roomId)
        .orderBy('sent_at', descending: true)
        .snapshots();
    return messages;
  }

  @override
  Future<Stream<List<ChatRoom>>> getAllChatRooms() async {
    Query query = FBCollections.chatRooms;

    query = query.orderBy("created_at", descending: true);
    var ref = query.snapshots().asBroadcastStream();
    var x = ref.map(
        (event) => event.docs.map((e) => ChatRoom.fromJson(e.data())).toList());
    return x;
  }

  Stream<QuerySnapshot> chatUnreadMessages(String roomId) {
    CollectionReference colRef = FBCollections.chats;
    Query query = colRef.where("room_id", isEqualTo: roomId);
    query = query
        .where("seen", isEqualTo: false)
        .where("receiver_id", isNotEqualTo: AppUser.user.email);
    return query.snapshots();
  }

  @override
  Future<ChatRoom> createChatRoom({ChatRoom room}) async {
    String docId = AppUtils.getFreshTimeStamp();
    DocumentReference docRef = FBCollections.chatRooms.doc(docId);
    room.createdAt = Timestamp.now();
    room.roomId = docId;
    await db.runTransaction((trx) async => trx.set(docRef, room.toJson()));
    return getChatRoomById(roomId: docId);
  }

  @override
  Future<ChatRoom> getChatRoomById({String roomId}) async {
    DocumentSnapshot doc = await FBCollections.chatRooms.doc(roomId).get();
    print(doc.data());
    return ChatRoom.fromJson(doc.data());
  }
}
