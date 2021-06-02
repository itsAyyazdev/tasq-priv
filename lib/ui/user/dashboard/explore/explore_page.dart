import 'package:flutter/material.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:tasq/ui/user/dashboard/explore/based_on_skills.dart';
import 'package:tasq/ui/user/dashboard/explore/ending_soon.dart';
import 'package:tasq/ui/user/dashboard/explore/search_tasks.dart';
import 'package:tasq/ui/widgets/shared/heading_tile.dart';
import 'package:tasq/utils/globals/import_hub.dart';

class UserExploreSkills extends StatefulWidget {
  @override
  _UserExploreSkillsState createState() => _UserExploreSkillsState();
}

class _UserExploreSkillsState extends State<UserExploreSkills> {
  @override
  void initState() {
    UserProvider p = Provider.of<UserProvider>(context, listen: false);
    p.getExploreData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(
      builder: (context, p, _) => LoadingOverlay(
        isLoading: p.isLoading,
        child: Scaffold(
          appBar: MyAppbar(
            title: "explore",
            showChatIcon: false,
            trailing: trailing(),
          ),
          body: Container(
            padding: AppUtils.generalOuterPadding,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Column(
                    children: [
                      HeadingTile(
                          title: 'based on your skills',
                          buttonName: 'see more',
                          onTap: () {} //TODO,
                          ),
                      BasedOnSkill(maxLength: 2),
                    ],
                  ),
                  Column(
                    children: [
                      HeadingTile(
                          title: 'ending soon',
                          buttonName: 'see more',
                          onTap: () {} //TODO,
                          ),
                      EndingSoon(),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget trailing() {
    return Row(
      children: [
        IconButton(
            icon: Icon(
              Icons.search_rounded,
              size: 34,
              color: Colors.white,
            ),
            onPressed: () => Get.to(SearchTasks(),
                transition: AppUtils.pageTransition,
                curve: AppUtils.pageCurve)),
        SizedBox(
          width: 12,
        ),
        ChatIcon(
          onTap: () {},
        )
      ],
    );
  }
}
