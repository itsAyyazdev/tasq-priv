import 'dart:io';

import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:tasq/models/chat_room.dart';
import 'package:tasq/models/message.dart';
import 'package:tasq/models/user.dart';
import 'package:tasq/providers/chat_provider.dart';
import 'package:tasq/services/firestore_services.dart';
import 'package:tasq/ui/widgets/shared/my_app_bar.dart';
import 'package:tasq/ui/widgets/shared/timeago_widget.dart';
import 'package:tasq/utils/constants/firebase_collections.dart';
import 'package:tasq/utils/enums.dart';
import 'package:tasq/utils/globals/app_data/app_data.dart';
import 'package:tasq/utils/globals/app_data/app_user.dart';
import 'package:tasq/utils/globals/import_hub.dart';

class Conversation extends StatefulWidget {
  final String name;
  final ChatRoom room;
  Conversation({this.name, this.room});

  @override
  _ConversationState createState() =>
      _ConversationState(room: room, name: name);
}

class _ConversationState extends State<Conversation> {
  String name;
  ChatRoom room;
  _ConversationState({this.name, this.room});
  TextEditingController msgCont = TextEditingController();
  AuthFSServices fs = CFS();
  File image;
  String receiverId = "";
  UserData userData;

  @override
  Widget build(BuildContext context) {
    return Consumer<ChatProvider>(
        builder: (context, p, _) => Scaffold(
              backgroundColor: AppConfig.colors.smokeWhite,
              appBar: MyAppbar(
                title: "${widget.name}",
                showChatIcon: false,
                trailing: trailing,
                autoImplyLeading: true,
              ),
              body: p.isLoading
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : Container(
                      width: Get.width,
                      margin:
                          EdgeInsets.symmetric(horizontal: Get.width * 0.02),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(height: Get.height * 0.03),
                          Align(
                            alignment: Alignment.center,
                            child: Container(
                                margin: EdgeInsets.symmetric(
                                    vertical: Get.height * 0.005),
                                width: Get.width * 0.6,
                                height: 37.0,
                                padding: EdgeInsets.all(5),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20.0),
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.16),
                                      offset: Offset(0, 6.0),
                                      blurRadius: 2,
                                    ),
                                  ],
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(width: Get.width * 0.04),
                                    Container(
                                      width: 12,
                                      height: 12,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
                                        color: AppConfig.colors.saffronYellow,
                                      ),
                                    ),
                                    SizedBox(width: Get.width * 0.08),
                                    TimeAgoWidget(
                                      withWatch: false,
                                      time: userData.onlineAt?.toDate() ??
                                          DateTime.now(),
                                    )
                                  ],
                                )),
                          ),
                          SizedBox(height: Get.height * 0.03),
                          Expanded(child: buildListMessage(p)),
                          bottonTextFormField(p),
                        ],
                      ),
                    ),
            ));
  }

  Widget bottonTextFormField(ChatProvider p) {
    return Container(
      // height: 55,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.vertical(top: Radius.circular(10.0)),
        color: AppConfig.colors.smokeWhite,
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            offset: Offset(0.0, 1.0), //(x,y)
            blurRadius: 5.0,
          ),
        ],
      ),
      width: Get.width,
      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
      child: Row(
        children: <Widget>[
          Expanded(
            child: TextField(
              textAlign: TextAlign.start,
              controller: msgCont,
              maxLines: null,
              onChanged: (val) {
                setState(() {});
              },
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                hintText: "type your message",
                hintStyle: TextStyle(fontSize: 12, color: Colors.black),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: BorderSide(
                    width: 0,
                    style: BorderStyle.none,
                  ),
                ),
                filled: true,
                contentPadding: EdgeInsets.all(0),
                fillColor: AppConfig.colors.smokeWhite,
                isDense: true,
              ),
            ),
          ),
          AnimatedSwitcher(
            duration: Duration(milliseconds: 400),
            child: p.isLoading
                ? CircularProgressIndicator()
                : msgCont.text.isEmpty
                    ? mediaOptions(p)
                    : sendButton(p),
            switchInCurve: Curves.bounceOut,
            switchOutCurve: Curves.bounceOut,
          )
        ],
      ),
    );
  }

  Widget mediaOptions(ChatProvider p) {
    return Align(
      alignment: Alignment.centerRight,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                _imgFromCamera(p);
              });
            },
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Icon(
                Icons.add_comment,
                color: Colors.black,
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                _imgFromGallery(p);
              });
            },
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Icon(
                Icons.photo_rounded,
                color: Colors.black,
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                _imgFromGallery(p);
              });
            },
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Icon(
                Icons.attach_file_sharp,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget sendButton(ChatProvider p) {
    Message msg = Message(
        msg: msgCont.text,
        fileUrl: "",
        receiverId: receiverId,
        type: Enums.msgType.text,
        senderId: AppUser.user.email,
        roomId: room.roomId,
        seen: false);

    return IconButton(
        icon: Icon(Icons.send_rounded),
        onPressed: () {
          p.sendMessage(msg: msg);
          msgCont.clear();
        });
  }

  Widget buildListMessage(ChatProvider p) {
    return Container(
      child: room.roomId == ''
          ? CircularProgressIndicator()
          : StreamBuilder(
              stream: p.buildListStream(room.roomId),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.data.docs.isEmpty) {
                  // controller.onSendMessage(
                  //     "Hi 👋", MessageTypeEnums.text, roomId);
                  return Center(
                    child: Text("Send your first message"),
                  );
                } else {
                  // controller.listMessage = snapshot.data.docs;
                  List<Message> msgs = [];
                  snapshot.data.docs.forEach((element) {
                    msgs.add(Message.fromJson(element.data()));
                  });
                  return ListView.builder(
                    padding: EdgeInsets.all(10.0),
                    itemBuilder: (context, index) =>
                        buildMessageItem(index, msgs[index]),
                    itemCount: snapshot.data.docs.length,
                    reverse: true,
                    controller: p.listScrollController,
                  );
                }
              },
            ),
    );
  }

  Widget buildMessageItem(int index, Message message) {
    int messageType = message.type;
    if (message.senderId == AppUser.user.email) {
      // Right (my message)
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              messageType == Enums.msgType.text
                  ? textMessage(message, true)
                  : messageType == Enums.msgType.image
                      ? imageMessage(message, true)
                      : messageType == Enums.msgType.text
                          ? videoThumbnail(
                              message,
                            )
                          : Container(
                              child: Text(message.msg),
                            )
            ],
            mainAxisAlignment: MainAxisAlignment.end,
          ),
          // Align(
          //     alignment: Alignment.centerRight,
          //     child: messageTime(message, true)),
        ],
      );
    } else {
      // Left (peer message)
      return Container(
        child: Column(
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 12),
                  child: userAvatar(imageUrl: userData.imageUrl ?? ""),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          name.split(" ").first ?? "",
                          style: MyTextStyles.montsSemiBold16,
                        ),
                        messageTime(message, false),
                      ],
                    ),
                    messageType == Enums.msgType.text
                        ? textMessage(message, false)
                        : messageType == Enums.msgType.image
                            ? imageMessage(message, false)
                            : messageType == Enums.msgType.video
                                ? videoThumbnail(message)
                                : Container(
                                    child: Text(message.msg),
                                  )
                  ],
                ),
              ],
            ),
          ],
          crossAxisAlignment: CrossAxisAlignment.start,
        ),
        margin: EdgeInsets.only(bottom: 10.0),
      );
    }
  }

  Widget videoThumbnail(Message msg) {
    return Text("media");
  }

  Widget textMessage(Message msg, bool isMyMessage) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment:
          isMyMessage ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 6.0),
          child: Material(
            elevation: 5.0,
            borderRadius: BorderRadius.circular(8),
            color: Colors.white,
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: Get.width * 0.6),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      msg.msg ?? "",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'Poppins',
                      ),
                    ),
                    // (isMyMessage)
                    //     ? Icon(
                    //         Icons.check,
                    //         size: 35.w,
                    //         color: Colors.white,
                    //       )
                    //     : Container()
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget imageMessage(Message msg, bool isMyMessage) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment:
          isMyMessage ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 6.0),
          child: Material(
            elevation: 5.0,
            borderRadius: BorderRadius.circular(8),
            color: Colors.white,
            child: ConstrainedBox(
              constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width * .7,
                  minWidth: 1),
              child: Container(
                margin: EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(msg.fileUrl)),
                    // Padding(
                    //   padding: EdgeInsets.fromLTRB(0, 6, 0, 0),
                    //   child: Text(
                    //     msg.msg ?? "",
                    //     textAlign: TextAlign.left,
                    //   ),
                    // ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget userAvatar({String imageUrl}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CircularProfileAvatar(
          "",
          child: Image.network(
            imageUrl == null || imageUrl.isEmpty ? AppData.userImage : imageUrl,
            fit: BoxFit.cover,
          ),
          borderWidth: 1,
          radius: Get.width * 0.05,
        ),
        SizedBox(width: Get.width * 0.04),
      ],
    );
  }

  Widget messageTime(Message msg, bool isMyMessage) {
    return Padding(
      padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
      child: Row(
        children: [
          Text(
            DateFormat('hh:mm a').format(msg.sentAt.toDate()),
            style: TextStyle(color: Colors.grey, fontSize: 12),
          ),
          // isMyMessage
          //     ? seenTick(document)
          //     : SizedBox(
          //   height: 0,
          // )
        ],
      ),
    );
  }

  _imgFromGallery(ChatProvider p) async {
    final pickedFile =
        await ImagePicker().getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      image = File(pickedFile.path);
      sendImage(image, p);
    }
  }

  _imgFromCamera(ChatProvider p) async {
    final pickedFile = await ImagePicker().getImage(source: ImageSource.camera);
    if (pickedFile != null) {
      image = File(pickedFile.path);
      sendImage(image, p);
    }
  }

  //send Media Message
  void sendImage(File image, ChatProvider p) async {
    String url = await p.uploadFile(image);
    if (url != null) {
      Message msg = Message(
          msg: "",
          fileUrl: url,
          receiverId: receiverId,
          type: Enums.msgType.image,
          senderId: AppUser.user.email,
          roomId: room.roomId,
          seen: false);
      p.sendMessage(msg: msg);
    }
  }

  Widget trailing = IconButton(
    icon: Icon(
      Icons.more_vert,
      color: Colors.white,
      size: 18,
    ),
    onPressed: () {},
  );

  // some functions to set seen true and fetch user details

  getUserData(String id) async {
    ChatProvider p = Provider.of<ChatProvider>(context, listen: false);
    p.stopLoader();
    userData = await fs.getUserById(id);
    p.stopLoader();
  }

  StreamSubscription<QuerySnapshot> streamSubscription;

  void readAllMessage() {
    streamSubscription = FBCollections.chats
        .where("room_id", isEqualTo: room.roomId)
        .where("sender_id", isNotEqualTo: userData.email)
        .where("seen", isEqualTo: false)
        .snapshots()
        .listen((value) {
      value.docs.forEach((element) {
        print(element.id);
        FBCollections.chats
            .doc(element.id)
            .update({'seen': true}).then((value) {
          print('\nSeen : : : : updated\n');
        });
      });
    });
  }

  setSeenTrue() {
    Future.delayed(Duration(seconds: 2), () {
      readAllMessage();
    });
  }

  @override
  void initState() {
    receiverId =
        room.users.where((element) => element != AppUser.user.email).first;
    getUserData(receiverId);
    setSeenTrue();
    super.initState();
  }

  @override
  void dispose() {
    streamSubscription?.cancel();
    super.dispose();
  }
}
