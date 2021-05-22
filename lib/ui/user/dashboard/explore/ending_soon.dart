import 'package:flutter/material.dart';
import 'package:tasq/models/job.dart';
import 'package:tasq/ui/widgets/shared/task_card.dart';
import 'package:tasq/utils/globals/app_data/dummy_data.dart';

class EndingSoon extends StatelessWidget {
  final int maxLength;
  EndingSoon({this.maxLength});
  //maxlength is to display partial data on any screen,
  // leave null if you dont want max limits
  @override
  Widget build(BuildContext context) {
    int listLength = maxLength == null
        ? DummyData.posts.length
        : DummyData.posts.length > maxLength
            ? maxLength
            : DummyData.posts.length;
    return Column(
      children: List.generate(listLength, (index) {
        return TaskWidget(
          post: Job(),
          showActive: true,
          showPoints: true,
          showResponses: false,
          color: Colors.black,
        );
      }),
    );
    ;
  }
}
