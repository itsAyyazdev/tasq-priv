import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tasq/models/chat_room.dart';
import 'package:tasq/models/job.dart';
import 'package:tasq/models/job_application.dart';
import 'package:tasq/models/user.dart';
import 'package:tasq/ui/chatbox/conversation.dart';
import 'package:tasq/ui/widgets/shared/empty_screen.dart';
import 'package:tasq/ui/widgets/shared/shimmers/job.dart';
import 'package:tasq/utils/constants/firebase_collections.dart';
import 'package:tasq/utils/globals/app_data/app_data.dart';
import 'package:tasq/utils/globals/import_hub.dart';

class Responses extends StatelessWidget {
  final Job job;
  final List<JobApplication> responses;
  Responses({@required this.responses, @required this.job});
  @override
  Widget build(BuildContext context) {
    if (responses.isEmpty) {
      return EmptyScreen(
        msg: "No responses on this post yet",
      );
    } else {
      return Column(
        children: [
          Expanded(
            child: ListView(
              children: List.generate(responses.length, (index) {
                JobApplication application = responses[index];
                return FutureBuilder(
                    future:
                        FBCollections.chatRooms.doc(application.roomId).get(),
                    builder:
                        (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                      if (!snapshot.hasData) {
                        return JobShimmerCard();
                      } else {
                        ChatRoom room =
                            ChatRoom.fromJson(snapshot.data?.data() ?? {});
                        if (room == null || room?.unreadCount == null) {
                          return Container();
                        } else {
                          return GestureDetector(
                              onTap: () => Get.to(Conversation(
                                    room: room,
                                    name: application.applicantName,
                                  )),
                              child: responseCard(application));
                        }
                      }
                    });
              }),
            ),
          ),
          assignTo(),
        ],
      );
    }
  }

  Widget responseCard(JobApplication application) {
    return Consumer<AdminProvider>(
        builder: (context, p, _) => Padding(
              padding: EdgeInsets.symmetric(
                  vertical: 10, horizontal: Get.width * 0.05),
              child: FutureBuilder(
                future: application.applicant.get(),
                builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                  if (!snapshot.hasData) {
                    return JobShimmerCard();
                  } else {
                    UserData user = UserData.fromJson(snapshot.data.data());
                    return Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                      alignment: Alignment(0.18, 0.08),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4.0),
                        color: const Color(0xFFF2F2F2),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.16),
                            offset: Offset(0, 6.0),
                            blurRadius: 15.0,
                          ),
                        ],
                      ),
                      child: Column(
                        children: <Widget>[
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Expanded(
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: CircleAvatar(
                                        radius: 30,
                                        backgroundImage: NetworkImage(
                                            user.imageUrl.isEmpty
                                                ? AppData.userImage
                                                : user.imageUrl),
                                      ),
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(
                                            '${user.name ?? ""}',
                                            style: MyTextStyles.montsNormal16
                                                .copyWith(
                                              fontSize: 16.0,
                                              color: Colors.black,
                                              fontWeight: FontWeight.w700,
                                              height: 1.15,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 4,
                                          ),
                                          Row(
                                            children: <Widget>[
                                              Align(
                                                alignment: Alignment.topCenter,
                                                child: SvgPicture.string(
                                                  AppConfig.svgIcons.star,
                                                  width: 14.0,
                                                  height: 14.0,
                                                ),
                                              ),
                                              Text.rich(
                                                TextSpan(
                                                  style: MyTextStyles
                                                      .montsNormal16
                                                      .copyWith(
                                                    fontSize: 12.0,
                                                    color: Colors.black,
                                                    height: 1.71,
                                                  ),
                                                  children: [
                                                    TextSpan(
                                                      text:
                                                          '${user.points ?? 0} ',
                                                      style: MyTextStyles
                                                          .montsNormal16
                                                          .copyWith(
                                                        fontWeight:
                                                            FontWeight.w700,
                                                      ),
                                                    ),
                                                    TextSpan(
                                                      text: 'tasQ points',
                                                      style: MyTextStyles
                                                          .montsNormal16
                                                          .copyWith(
                                                        fontSize: 10.0,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Align(
                                alignment: Alignment.topRight,
                                child: PopupMenuButton(
                                  child: Icon(Icons.more_vert),
                                  itemBuilder: (context) {
                                    return <PopupMenuItem<String>>[
                                      new PopupMenuItem<String>(
                                          child: const Text('assign'),
                                          value: 'assign'),
                                    ];
                                  },
                                  onSelected: (val) {
                                    p.assignToApplicant(job, application, user);
                                  },
                                ),
                              ),
                            ],
                          ),
                          Text.rich(
                            TextSpan(
                              style: MyTextStyles.montsNormal16.copyWith(
                                fontSize: 8.0,
                                color: Colors.black,
                                height: 1.6,
                              ),
                              children: [
                                TextSpan(
                                  text: '${user.name ?? ""}',
                                  style: MyTextStyles.montsNormal16.copyWith(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 12),
                                ),
                                TextSpan(
                                  text:
                                      ': ${application.proposal?.proposal ?? ""}',
                                  style: MyTextStyles.montsNormal16.copyWith(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                },
              ),
            ));
  }

  assignTo() {
    return Consumer<AdminProvider>(
      builder: (context, p, _) => TextButton(
        onPressed: () => p.assignFromTeam(job),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text.rich(
              TextSpan(
                style: MyTextStyles.montsNormal16.copyWith(
                  fontSize: 13.0,
                  color: Colors.black,
                  height: 1.31,
                ),
                children: [
                  TextSpan(
                    text: 'or assign to someone from',
                    style: MyTextStyles.montsNormal16.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
            Text(
              ' your team',
              style: MyTextStyles.montsNormal16.copyWith(
                color: const Color(0xFF2000FF),
                fontWeight: FontWeight.w700,
              ),
            )
          ],
        ),
      ),
    );
  }
}
