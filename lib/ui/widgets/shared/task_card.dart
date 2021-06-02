import 'package:tasq/models/job.dart';
import 'package:tasq/models/job_application.dart';
import 'package:tasq/ui/widgets/shared/timeago_widget.dart';
import 'package:tasq/ui/widgets/user/points.dart';
import 'package:tasq/utils/globals/import_hub.dart';

class TaskWidget extends StatelessWidget {
  final Job post;
  final JobApplication application;
  final bool showActive,
      showPoints,
      showResponses,
      showAssignedTo,
      showProposal;
  final Color color;
  final Function onTap;
  final int responseCount;
  TaskWidget(
      {this.post,
      this.showActive,
      this.application,
      this.showPoints,
      this.responseCount,
      this.showResponses = false,
      this.showAssignedTo = false,
      this.showProposal = false,
      this.color,
      @required this.onTap});
  @override
  Widget build(BuildContext context) {
    Color cardColor = color ?? AppConfig.colors.liteGrey;
    Color textColor = cardColor == Colors.black ? Colors.white : Colors.black;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: Get.width * 0.02),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.symmetric(
              vertical: Get.height * 0.02, horizontal: Get.width * 0.02),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4.0),
            color: cardColor,
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
              SizedBox(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        post.title ?? "",
                        style: MyTextStyles.montsBold16.copyWith(
                          fontSize: 16.0,
                          color: textColor,
                        ),
                      ),
                    ),
                    TimeAgoWidget(
                      time: post.postedAt.toDate(),
                      textColor: textColor,
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: showProposal
                    ? Text.rich(
                        TextSpan(
                          style: MyTextStyles.montsNormal16.copyWith(
                            fontSize: 14.0,
                            color: Colors.black,
                            height: 1.3,
                          ),
                          children: [
                            TextSpan(
                              text:
                                  '${application?.applicantName ?? post.assignTo?.name ?? ""} : ',
                              style: MyTextStyles.montsNormal16.copyWith(
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            TextSpan(
                              text:
                                  '${post.assignTo?.proposal ?? application?.proposal?.proposal ?? ""}',
                              style: MyTextStyles.montsNormal16.copyWith(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                  color: textColor),
                            ),
                          ],
                        ),
                      )
                    : Text(
                        "${post.description}",
                        style: MyTextStyles.montsNormal16.copyWith(
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            color: textColor),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  showActive ? Expanded(child: active(textColor)) : Container(),
                  showPoints
                      ? Expanded(
                          child: Align(
                              alignment: Alignment.centerLeft,
                              child: points(textColor)),
                        )
                      : Container(),
                  showResponses
                      ? Expanded(
                          child: responses(textColor),
                        )
                      : Container(),
                ],
              ),
              !showAssignedTo
                  ? Container()
                  : Column(
                      children: [
                        SizedBox(
                          height: 8,
                        ),
                        Text.rich(
                          TextSpan(
                            style: MyTextStyles.montsNormal16.copyWith(
                              fontSize: 14.0,
                              color: Colors.black,
                              height: 1.3,
                            ),
                            children: [
                              TextSpan(
                                text: 'assigned to : ',
                                style: MyTextStyles.montsNormal16.copyWith(
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              TextSpan(
                                text: post.assignTo?.name ?? "",
                                style: MyTextStyles.montsNormal16.copyWith(
                                  color: const Color(0xFF2000FF),
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
            ],
          ),
        ),
      ),
    );
  }

  Widget responses(Color textColor) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Text(
          '${responseCount ?? 0} responses',
          style: MyTextStyles.montsNormal16.copyWith(
            fontSize: 14.0,
            color: textColor,
            fontWeight: FontWeight.w700,
            height: 1.3,
          ),
        ),
      ],
    );
  }

  Widget active(Color textColor) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Text(
          'post active',
          style: MyTextStyles.montsNormal16.copyWith(
            fontSize: 13.0,
            color: textColor,
            fontWeight: FontWeight.w700,
            height: 1.3,
          ),
        ),
        SizedBox(width: 4),
        Align(
          alignment: Alignment(0.0, -0.14),
          child: Icon(
            Icons.done,
            size: 18,
          ),
        ),
      ],
    );
  }

  Widget points(Color textColor) {
    return PointsWidget(
      size: 12,
      textColor: textColor,
      value: (post.points ?? 0).toString(),
      bgColor: Colors.transparent,
    );
  }
}
