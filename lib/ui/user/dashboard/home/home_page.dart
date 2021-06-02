import 'package:flutter/material.dart';
import 'package:tasq/ui/user/dashboard/explore/based_on_skills.dart';
import 'package:tasq/ui/user/dashboard/home/user_active_tasks.dart';
import 'package:tasq/ui/widgets/admin/admin_info_card.dart';
import 'package:tasq/ui/widgets/shared/heading_tile.dart';
import 'package:tasq/utils/globals/import_hub.dart';

class UserHome extends StatefulWidget {
  @override
  _UserHomeState createState() => _UserHomeState();
}

class _UserHomeState extends State<UserHome> {
  @override
  void initState() {
    UserProvider p = Provider.of<UserProvider>(context, listen: false);
    p.getHomeData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(
        builder: (context, p, _) => Scaffold(
              appBar: MyAppbar(
                title: "home",
              ),
              body: SingleChildScrollView(
                child: Container(
                  padding: AppUtils.generalOuterPadding,
                  child: Column(
                    children: [
                      AdminInfoCard(
                        isEdit: false,
                        isAdmin: false,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "active tasks",
                            style:
                                MyTextStyles.montsBold16.copyWith(fontSize: 22),
                          ),
                          TextButton(
                              onPressed: () {},
                              child: Text(
                                "see all",
                                style: MyTextStyles.montsSemiBold16
                                    .copyWith(fontSize: 18),
                              )),
                        ],
                      ),
                      UserActiveTasks(
                        maxLength: 2,
                      ),
                      HeadingTile(
                        title: "explore opportunities",
                        buttonName: "see all",
                        onTap: () {},
                      ),
                      BasedOnSkill(maxLength: 2),
                    ],
                  ),
                ),
              ),
            ));
  }
}
