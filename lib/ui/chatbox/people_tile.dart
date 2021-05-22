import 'package:tasq/utils/globals/import_hub.dart';

class PeopleTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return // Group: Group 1235

        SizedBox(
      width: 63.0,
      height: 19.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Align(
            alignment: Alignment(0.0, 0.11),
            child: Container(
              width: 10.0,
              height: 10.0,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
                border: Border.all(
                  width: 2.0,
                  color: const Color(0xFF707070),
                ),
              ),
            ),
          ),
          Text(
            'Shriya',
            style: MyTextStyles.montsNormal16.copyWith(
              fontSize: 15.0,
              color: Colors.black,
              fontWeight: FontWeight.w500,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}
