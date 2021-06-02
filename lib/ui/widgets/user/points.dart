import 'package:tasq/utils/globals/import_hub.dart';

class PointsWidget extends StatelessWidget {
  //this widget is being used thoroughly to display the points to the user,
  // manipulate these properties to achieve scenario fit.
  final double size;
  final String value;
  final Function onTap;
  final Color bgColor;
  final Color textColor;

  PointsWidget(
      {this.size = 14,
      this.value,
      this.onTap,
      this.bgColor = Colors.white,
      this.textColor = Colors.black});
  @override
  Widget build(BuildContext context) {
    double tSize = size + (size / 2) - 2;
    return Container(
      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24.0),
        color: bgColor,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            width: tSize,
            height: tSize,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                begin: Alignment(-0.39, -0.76),
                end: Alignment(0.56, 0.76),
                colors: [const Color(0xFF8A58FF), const Color(0xFF1B02C7)],
              ),
            ),
            child: Center(
              child: Text(
                't',
                style: MyTextStyles.montsNormal16.copyWith(
                  fontSize: size,
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
          SizedBox(
            width: tSize - 8,
          ),
          Text(
            "$value" + ' pts',
            style: MyTextStyles.montsNormal16.copyWith(
              fontSize: size,
              color: textColor,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
