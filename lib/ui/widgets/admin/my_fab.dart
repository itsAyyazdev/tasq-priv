import 'package:tasq/utils/globals/import_hub.dart';

class MyFAB extends StatelessWidget {
  final String text;
  final Function onTap;
  MyFAB({this.text, this.onTap});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 60,
        width: 60,
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.16),
                  blurRadius: 8,
                  spreadRadius: 4,
                  offset: Offset(5, 8))
            ],
            gradient: LinearGradient(colors: [
              AppConfig.colors.robinBlue,
              AppConfig.colors.electricViolet,
            ])),
        child: Center(
          child: Text(
            text ?? "",
            style: MyTextStyles.montsBold16
                .copyWith(color: Colors.white, fontSize: 24),
          ),
        ),
      ),
    );
  }
}
