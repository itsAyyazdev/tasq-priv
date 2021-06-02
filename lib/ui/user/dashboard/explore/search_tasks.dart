import 'package:flutter/material.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:tasq/models/job.dart';
import 'package:tasq/ui/user/task/task_details.dart';
import 'package:tasq/ui/widgets/shared/empty_screen.dart';
import 'package:tasq/ui/widgets/shared/task_card.dart';
import 'package:tasq/utils/constants/config.dart';
import 'package:tasq/utils/globals/import_hub.dart';

class SearchTasks extends StatefulWidget {
  final int maxLength;
  SearchTasks({this.maxLength});

  @override
  _SearchTasksState createState() => _SearchTasksState();
}

class _SearchTasksState extends State<SearchTasks> {
  List<Job> jobForSearch = [];
  List<Job> recoverOnPop = [];
  @override
  void initState() {
    UserProvider p = Provider.of(context, listen: false);
    recoverOnPop = p.exploreJobs;
    jobForSearch = p.exploreJobs;
    super.initState();
  }

  @override
  void dispose() {
    UserProvider p = Provider.of(context, listen: false);
    p.exploreJobs.clear();
    p.exploreJobs.addAll(recoverOnPop);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(
      builder: (context, p, _) {
        int listLength = widget.maxLength == null
            ? p.exploreJobs.length
            : p.exploreJobs.length > widget.maxLength
                ? widget.maxLength
                : p.exploreJobs.length;

        return LoadingOverlay(
          isLoading: p.isLoading,
          child: Scaffold(
            appBar: MyAppbar(
              title: "search",
              autoImplyLeading: true,
              showChatIcon: false,
            ),
            body: Container(
              padding: EdgeInsets.symmetric(horizontal: Get.width * 0.02),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        left: Get.width * 0.02,
                        right: Get.width * 0.02,
                        top: 24,
                        bottom: 12),
                    child: Row(
                      children: [Expanded(child: searchField(p)), _filter()],
                    ),
                  ),
                  p.exploreJobs.isEmpty
                      ? EmptyScreen(
                          msg: "No jobs found",
                        )
                      : Expanded(
                          child: ListView(
                            children: List.generate(listLength, (index) {
                              Job job = p.exploreJobs[index];
                              return Container(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                child: TaskWidget(
                                  post: job,
                                  showActive: true,
                                  showPoints: true,
                                  showResponses: false,
                                  color: AppConfig.colors.liteGrey,
                                  onTap: () {
                                    Get.to(UserTaskDetail(post: job),
                                        transition: AppUtils.pageTransition,
                                        curve: AppUtils.pageCurve);
                                  },
                                ),
                              );
                            }),
                          ),
                        ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget searchField(UserProvider p) {
    return TextFormField(
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.search),
        contentPadding: EdgeInsets.symmetric(vertical: 6, horizontal: 12),
        border: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
        enabledBorder:
            OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
        focusedBorder:
            OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
      ),
      onChanged: (v) {
        setState(() {
          p.exploreJobs = jobForSearch
              .where((element) =>
                  element.title.toLowerCase().contains(v.toLowerCase()))
              .toList();
        });
      },
    );
  }

  Widget _filter() {
    return Padding(
      padding: const EdgeInsets.only(left: 16),
      child: IconButton(
          icon: Icon(
            Icons.filter_alt_outlined,
            size: 34,
          ),
          onPressed: () {}),
    );
  }
}
