import 'package:tasq/models/job_application.dart';
import 'package:tasq/ui/widgets/shared/empty_screen.dart';
import 'package:tasq/ui/widgets/shared/shimmers/job.dart';
import 'package:tasq/ui/widgets/shared/timeago_widget.dart';
import 'package:tasq/utils/globals/import_hub.dart';

class AdminActiveTasks extends StatefulWidget {
  final int maxLength;
  AdminActiveTasks({this.maxLength});
  @override
  _AdminActiveTasksState createState() =>
      _AdminActiveTasksState(maxLength: maxLength);
}

class _AdminActiveTasksState extends State<AdminActiveTasks> {
  final int maxLength;
  _AdminActiveTasksState({this.maxLength});

  @override
  void initState() {
    AdminProvider p = Provider.of<AdminProvider>(context, listen: false);
    // p.onInit();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AdminProvider>(builder: (context, p, _) {
      if (p.isLoading) {
        return JobShimmer();
      } else {
        int length =
            p.activeTasks.length > maxLength ? maxLength : p.activeTasks.length;
        if (p.activeTasks.isEmpty) {
          return EmptyScreen(
            msg: "No Active Tasks to manage",
          );
        } else {
          return SingleChildScrollView(
            child: Column(
              children: List.generate(length, (index) {
                JobApplication active = p.activeTasks[index];
                return Padding(
                  padding: EdgeInsets.symmetric(vertical: Get.width * 0.02),
                  child: Container(
                    padding: EdgeInsets.symmetric(
                        vertical: Get.height * 0.02,
                        horizontal: Get.width * 0.02),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4.0),
                      color: const Color(0xFFFBF8F8),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.16),
                          offset: Offset(0, 6.0),
                          blurRadius: 15.0,
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Expanded(
                              child: Text(
                                'YfS Cyclothon arrangements',
                                style: MyTextStyles.montsBold16.copyWith(
                                  fontSize: 14.0,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            TimeAgoWidget(
                                size: 9,
                                time: DateTime.now()
                                    .subtract(Duration(minutes: 3)))
                          ],
                        ),
                        Text.rich(
                          TextSpan(
                            style: MyTextStyles.montsNormal16.copyWith(
                              fontSize: 8.0,
                              color: Colors.black,
                              height: 2.13,
                            ),
                            children: [
                              TextSpan(
                                text: 'Bishant',
                                style: MyTextStyles.montsNormal16.copyWith(
                                    fontWeight: FontWeight.w700, fontSize: 12),
                              ),
                              TextSpan(
                                text:
                                    ': Hello team, I\'m interested for this role offered, I have ….',
                                style: MyTextStyles.montsNormal16.copyWith(
                                    fontWeight: FontWeight.w500, fontSize: 12),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                'post active',
                                style: MyTextStyles.montsNormal16.copyWith(
                                  fontSize: 14.0,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w700,
                                  height: 1.3,
                                ),
                              ),
                              SizedBox(width: 12),
                              Align(
                                alignment: Alignment(0.0, -0.14),
                                child: Icon(
                                  Icons.done,
                                  size: 18,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ),
          );
        }
      }
    });
  }
}

class ActiveTaskProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: List.generate(DummyData.posts.length, (index) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: TaskWidget(
            onTap: () {},
            showPoints: true,
            showResponses: true,
            showActive: true,
            showAssignedTo: true,
            post: DummyData.posts[index],
          ),
        );
      }),
    );
  }
}
