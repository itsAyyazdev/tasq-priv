import 'package:tasq/utils/globals/import_hub.dart';
import 'package:timeago/timeago.dart' as timeago;

class TimeAgoWidget extends StatelessWidget {
  final DateTime time;
  final bool withWatch;
  final double size;
  final Color textColor;
  TimeAgoWidget(
      {this.time,
      this.withWatch = true,
      this.size,
      this.textColor = Colors.black});
  @override
  Widget build(BuildContext context) {
    double kSize = size ?? 10;
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(right: kSize - 5),
          child: Icon(
            Icons.schedule,
            size: (kSize / 2) + kSize,
          ),
        ),
        Text(
          timeago.format(time),
          style: MyTextStyles.montsNormal16.copyWith(
            fontSize: kSize,
            color: textColor,
            fontWeight: FontWeight.w500,
            height: 1.33,
          ),
        ),
      ],
    );
  }
}
