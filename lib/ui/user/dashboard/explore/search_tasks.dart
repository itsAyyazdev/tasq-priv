import 'package:flutter/material.dart';
import 'package:tasq/ui/user/task/task_details.dart';
import 'package:tasq/ui/widgets/shared/task_card.dart';
import 'package:tasq/utils/constants/config.dart';
import 'package:tasq/utils/globals/app_data/dummy_data.dart';
import 'package:tasq/utils/globals/import_hub.dart';

class SearchTasks extends StatelessWidget {
  final int maxLength;
  SearchTasks({this.maxLength});
  @override
  Widget build(BuildContext context) {
    int listLength = maxLength == null
        ? DummyData.posts.length
        : DummyData.posts.length > maxLength
            ? maxLength
            : DummyData.posts.length;
    return Scaffold(
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
                children: [Expanded(child: searchField()), _filter()],
              ),
            ),
            Expanded(
              child: ListView(
                children: List.generate(listLength, (index) {
                  return Container(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: TaskWidget(
                      post: DummyData.posts[index],
                      showActive: true,
                      showPoints: true,
                      showResponses: false,
                      color: AppConfig.colors.liteGrey,
                      onTap: () {
                        Get.to(UserTaskDetail(post: DummyData.posts[index]),
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
    );
  }

  Widget searchField() {
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
      onChanged: (v) {},
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
