import 'package:loading_overlay/loading_overlay.dart';
import 'package:tasq/ui/admin/dashboard/me/my_postings/postDetails/my_post.dart';
import 'package:tasq/utils/globals/app_data/app_data.dart';
import 'package:tasq/utils/globals/app_data/app_user.dart';
import 'package:tasq/utils/globals/import_hub.dart';

class AdminProfile extends StatefulWidget {
  @override
  _AdminProfileState createState() => _AdminProfileState();
}

class _AdminProfileState extends State<AdminProfile>
    with TickerProviderStateMixin {
  TabController tCont;
  initTabController() {
    tCont = TabController(length: 2, vsync: this);
  }

  @override
  void initState() {
    initTabController();
    AdminProvider p = Provider.of<AdminProvider>(context, listen: false);
    p.loadMyPostings();
    p.loadAllAssignedTasks();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AdminProvider>(
        builder: (context, p, _) => LoadingOverlay(
              isLoading: p.isLoading,
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Expanded(flex: 0, child: userInfo(p)),
                    Expanded(child: tabs(p)),
                  ],
                ),
              ),
            ));
  }

  Widget userInfo(AdminProvider p) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundImage: NetworkImage(AppUser.user.imageUrl.isEmpty
                ? AppData.userImage
                : AppUser.user.imageUrl),
            backgroundColor: Colors.transparent,
            radius: 42,
          ),
        ),
        Expanded(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${AppUser.user.name ?? "-"}',
              style: MyTextStyles.montsBold16.copyWith(
                fontSize: 14.0,
                color: Colors.black,
                fontWeight: FontWeight.w700,
                height: 1.14,
              ),
            ),
            // Group: Group 1347
            SizedBox(
              height: 12,
            ),
            SizedBox(
              child: Row(
                children: <Widget>[
                  Align(
                    alignment: Alignment(0.0, 0.11),
                    child: SvgPicture.string(
                      AppConfig.svgIcons.taskDone,
                      width: 16,
                      height: 16,
                    ),
                  ),
                  Spacer(flex: 10),
                  Text(
                    '${p.postedTasks.length}',
                    style: MyTextStyles.montsNormal16.copyWith(
                      fontSize: 16.0,
                      color: Colors.black,
                      fontWeight: FontWeight.w800,
                      height: 1.37,
                    ),
                  ),
                  Spacer(flex: 19),
                  Align(
                    alignment: Alignment(0.0, 0.33),
                    child: Text(
                      'tasQs created',
                      style: MyTextStyles.montsNormal16.copyWith(
                        fontSize: 14.0,
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        height: 1.36,
                      ),
                    ),
                  ),
                  Spacer(flex: 90),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      'see all',
                      style: MyTextStyles.montsNormal16.copyWith(
                        fontSize: 12.0,
                        color: const Color(0xFF3A1FF6),
                        fontWeight: FontWeight.w700,
                        height: 1.33,
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ))
      ],
    );
  }

  Widget tabs(AdminProvider p) {
    return Column(
      children: [
        TabBar(
          controller: tCont,
          indicatorColor: Colors.black,
          indicatorSize: TabBarIndicatorSize.tab,
          tabs: List.generate(2, (index) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                index == 0 ? "my postings" : "active tasks",
                style: MyTextStyles.montsSemiBold16
                    .copyWith(color: Colors.black, fontSize: 20),
              ),
            );
          }),
        ),
        Expanded(
          child: TabBarView(controller: tCont, children: [
            MyPostings(),
            ActiveTaskProfile(),
          ]),
        ),
      ],
    );
  }
}
