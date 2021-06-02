import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tasq/models/org_member.dart';
import 'package:tasq/models/user.dart';
import 'package:tasq/ui/chatbox/people_tile.dart';
import 'package:tasq/ui/widgets/shared/shimmers/msg.dart';
import 'package:tasq/utils/globals/import_hub.dart';

class OrgTeams extends StatefulWidget {
  @override
  _OrgTeamsState createState() => _OrgTeamsState();
}

class _OrgTeamsState extends State<OrgTeams> {
  @override
  void initState() {
    AdminProvider p = Provider.of<AdminProvider>(context, listen: false);
    p.getOrgTeam();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AdminProvider>(
        builder: (context, p, _) => Scaffold(
              appBar: MyAppbar(
                autoImplyLeading: true,
                showChatIcon: false,
                trailing: Container(),
                title: "assign from your team",
              ),
              body: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 14.0),
                    child: Center(
                      child: Text(
                        'select who you want to assign this task to',
                        style: MyTextStyles.montsSemiBold16.copyWith(
                          fontSize: 14.0,
                          color: Colors.black,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                      child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: Get.width * 0.05),
                    child: ListView.builder(
                        itemCount: p.myTeamMembers.length,
                        itemBuilder: (context, index) {
                          OrgMember member = p.myTeamMembers[index];

                          return FutureBuilder(
                              future: member.user.get(),
                              builder: (context,
                                  AsyncSnapshot<DocumentSnapshot> snapshot) {
                                if (!snapshot.hasData) {
                                  return MsgShimmerWidget();
                                } else {
                                  UserData user =
                                      UserData.fromJson(snapshot.data.data());
                                  return PeopleTile(
                                    name: user.name ?? "",
                                    onTap: () => Get.back(result: user),
                                  );
                                }
                              });
                        }),
                  ))
                ],
              ),
            ));
  }
}
