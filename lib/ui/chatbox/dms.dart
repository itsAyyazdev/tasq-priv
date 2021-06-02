import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tasq/models/chat_room.dart';
import 'package:tasq/models/user.dart';
import 'package:tasq/providers/chat_provider.dart';
import 'package:tasq/ui/chatbox/conversation.dart';
import 'package:tasq/ui/chatbox/people_tile.dart';
import 'package:tasq/ui/widgets/shared/empty_screen.dart';
import 'package:tasq/ui/widgets/shared/shimmers/msg.dart';
import 'package:tasq/utils/globals/app_data/app_user.dart';
import 'package:tasq/utils/globals/import_hub.dart';

class DMs extends StatefulWidget {
  @override
  _DMsState createState() => _DMsState();
}

class _DMsState extends State<DMs> {
  stopLoader(p) {
    //stops loader if working still in bg
    Future.delayed(Duration(seconds: 1), () {
      p.stopLoader();
    });
  }

  @override
  void initState() {
    ChatProvider p = Provider.of<ChatProvider>(context, listen: false);
    p.fetchMyChatRooms();
    stopLoader(p);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ChatProvider>(builder: (context, p, _) {
      if (p.isLoading) {
        return MsgShimmer();
      } else {
        return SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Container(
            margin: EdgeInsets.symmetric(
                vertical: Get.height * 0.03, horizontal: Get.width * 0.06),
            child: p.chatRooms.isEmpty
                ? Center(
                    child: EmptyScreen(
                      msg: "No DMs yet",
                    ),
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      roomTile(p),
                      // readMessages(p),
                    ],
                  ),
          ),
        );
      }
    });
  }

  Widget roomTile(ChatProvider p) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "people",
          style: MyTextStyles.montsBold16.copyWith(
              fontSize: 14, color: Colors.black, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: Get.height * 0.02),
        Column(
            children: List.generate(p.chatRooms.length, (index) {
          ChatRoom room = p.chatRooms[index];
          String userToSearch = room.users
              .where((element) => element == AppUser.user.email) //TODO msg
              .first;
          return FutureBuilder(
              future: p.getUser(userToSearch),
              builder: (context, AsyncSnapshot<UserData> snapshot) {
                if (!snapshot.hasData) {
                  return MsgShimmerWidget();
                } else {
                  return StreamBuilder(
                      stream: p.getUnreadMsgs(roomId: room.roomId),
                      builder:
                          (context, AsyncSnapshot<QuerySnapshot> snapShot) {
                        if (!snapshot.hasData) {
                          return MsgShimmerWidget();
                        } else {
                          return PeopleTile(
                            name: snapshot.data.name,
                            onTap: () {
                              Get.to(Conversation(
                                name: snapshot.data.name,
                                room: room,
                              ));
                            },
                            msgCount: snapShot.data?.docs?.length ?? 0,
                          );
                        }
                      });
                }
              });
        })),
        SizedBox(height: Get.height * 0.04),
      ],
    );
  }

  // Widget readMessages(ChatProvider p) {
  //   if (p.chatRooms.isEmpty) {
  //     return Container();
  //   } else {
  //     return Column(
  //       children: [
  //         Row(
  //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //           crossAxisAlignment: CrossAxisAlignment.center,
  //           children: [
  //             Text(
  //               "Peoples",
  //               style: MyTextStyles.montsBold16.copyWith(
  //                   fontSize: 14,
  //                   color: Colors.black,
  //                   fontWeight: FontWeight.bold),
  //             ),
  //             IconButton(icon: Icon(Icons.add), onPressed: () {}),
  //           ],
  //         ),
  //         SizedBox(height: Get.height * 0.02),
  //         Column(
  //             children: List.generate(p.chatRooms.length, (index) {
  //           ChatRoom room = p.chatRooms[index];
  //           String userToSearch = room.users
  //               .where((element) => element != AppUser.user.email)
  //               .first;
  //           return FutureBuilder(
  //               future: p.getUser(userToSearch),
  //               builder: (context, AsyncSnapshot<UserData> snapshot) {
  //                 if (!snapshot.hasData) {
  //                   return MsgShimmerWidget();
  //                 } else {
  //                   return PeopleTile(
  //                     name: snapshot.data.name,
  //                     onTap: () {
  //                       Get.to(Conversation(
  //                         name: snapshot.data.name,
  //                         room: room,
  //                       ));
  //                     },
  //                     msgCount: 3,
  //                   );
  //                 }
  //               });
  //         })),
  //         SizedBox(height: Get.height * 0.04),
  //       ],
  //     );
  //   }
  // }
}
