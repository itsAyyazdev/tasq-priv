import 'package:tasq/utils/globals/import_hub.dart';

class PeopleTile extends StatelessWidget {
  final String name;
  final int msgCount;
  final Function onTap;
  final bool isOnline;
  PeopleTile({this.name, this.msgCount = 0, this.onTap, this.isOnline = false});
  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding:
          EdgeInsets.symmetric(horizontal: Get.width * 0.02, vertical: 2),
      onTap: onTap,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 12.0,
            height: 12.0,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isOnline ? Colors.green : Colors.white,
              border: Border.all(
                width: 2.0,
                color: isOnline ? Colors.green : Color(0xFF707070),
              ),
            ),
          ),
          SizedBox(width: Get.width * 0.03),
          Text(
            "$name",
            style: MyTextStyles.montsBold16.copyWith(fontSize: 16),
          ),
        ],
      ),
      trailing: msgCount == 0
          ? Container(
              width: 0,
              height: 0,
            )
          : Container(
              alignment: Alignment(0.0, 0.2),
              width: 32.0,
              height: 18.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(9.0),
                color: const Color(0xFFEB2D8C),
              ),
              child: Text(
                '$msgCount',
                style: MyTextStyles.montsSemiBold16.copyWith(
                  fontSize: 10.0,
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  height: 1.4,
                ),
              ),
            ),
    );
  }
}
