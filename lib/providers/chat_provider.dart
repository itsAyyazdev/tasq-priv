import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tasq/models/chat_room.dart';
import 'package:tasq/models/message.dart';
import 'package:tasq/models/user.dart';
import 'package:tasq/services/firestore_services.dart';
import 'package:tasq/services/shared/chat_services.dart';
import 'package:tasq/ui/admin/dashboard/me/OrgTeams.dart';
import 'package:tasq/utils/globals/app_data/app_user.dart';
import 'package:tasq/utils/globals/import_hub.dart';

class ChatProvider with ChangeNotifier {
  ChatServices _services = CSs();
  AuthFSServices fs = CFS();
  final ScrollController listScrollController = ScrollController();
  bool isLoading = false;
  StreamSubscription _chatSub;
  List<ChatRoom> chatRooms = [];
  // List<ChatRoom> readRooms = [];

  Stream<QuerySnapshot<Object>> buildListStream(roomId) {
    return _services.buildConversationList(roomId: roomId);
  }

  Stream<QuerySnapshot> getUnreadMsgs({String roomId}) {
    return _services.chatUnreadMessages(roomId);
  }

  //add people to team
  void addPeopleFromTeam() async {
    startLoader();
    UserData peerUser = await Get.to(OrgTeams());
    stopLoader();
    if (peerUser != null) {
      bool isCreated = isAlreadyCreated(peerUser.email);
      if (!isCreated) {
        ChatRoom room = ChatRoom(
            unreadCount: 1,
            jobId: "",
            createdBy: AppUser.user.email,
            users: [AppUser.user.email, peerUser.email]);
        startLoader();
        ChatRoom cRoom = await _services.createChatRoom(room: room);
        stopLoader();
        fetchMyChatRooms();
      }
    } else {
      AppUtils.showSnackbar(msg: "No people selected to add", isError: true);
    }
  }

  bool isAlreadyCreated(String email) {
    // check if chatRoom of these members already exits to avoid redundancy
    bool isPresent = false;
    List<ChatRoom> rooms = [];
    rooms.addAll(chatRooms);
    if (rooms.isEmpty) {
      return isPresent;
    }
    for (int i = 0; i <= rooms?.length ?? 0; i++) {
      ChatRoom element = rooms[i];
      if (element.users.contains(AppUser.user.email) &&
          element.users.contains(email)) {
        isPresent = true;
        break;
      }
    }
    return isPresent;
  }

  Future<UserData> getUser(String email) async {
    //fetch user detail to show the name

    UserData user = await fs.getUserById(email);
    return user;
  }

  fetchMyChatRooms() async {
    //Loads all tasks that are assigned and are currently in progress
    try {
      startLoader();
      var value = await _services.getAllChatRooms();
      stopLoader();
      _chatSub = value.listen((event) {
        chatRooms = event;
        chatRooms = chatRooms
            .where((element) => element.users.contains(AppUser.user.email))
            .toList();
        print("total rooms = ${chatRooms.length}");
        // chatRooms.where((element) => element.unreadCount > 0).toList();
        // readRooms =
        //     chatRooms.where((element) => element.unreadCount < 1).toList();
      });
      print("read List ${chatRooms.length}");
      stopLoader();
    } catch (e) {
      stopLoader();
      AppUtils.showSnackbar(msg: e.toString(), isError: true);
    }
  }

  Future<String> uploadFile(File file) async {
    startLoader();
    String url = await _services.uploadFile(file: file);
    stopLoader();
    return url;
  }

  void sendMessage({Message msg}) async {
    await _services.sendMessage(msg: msg);
  }

  startLoader() {
    isLoading = true;
    notifyListeners();
  }

  stopLoader() {
    isLoading = false;
    notifyListeners();
  }

  void onDispose() {
    _chatSub.cancel();
  }
}
