import 'package:tasq/utils/globals/import_hub.dart';

class HeadingTile extends StatelessWidget {
  final String title, buttonName;
  final Function onTap;
  HeadingTile({@required this.title, @required this.buttonName, this.onTap});
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "$title",
          style: MyTextStyles.montsBold16.copyWith(fontSize: 21),
        ),
        TextButton(
            onPressed: onTap,
            child: Text(
              "$buttonName",
              style: MyTextStyles.montsSemiBold16
                  .copyWith(fontSize: 18, color: AppConfig.colors.dodgerBlue),
            )),
      ],
    );
  }
}
