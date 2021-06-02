import 'package:tasq/services/auth_service.dart';
import 'package:tasq/utils/globals/import_hub.dart';

class LogoutButton extends StatelessWidget {
  final double topPadding;
  BaseAuth auth = Auth();
  LogoutButton({this.topPadding = 0.0});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: topPadding),
      child: InkWell(
        onTap: () => onTap(context),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: Get.height * 0.01),
          width: 176.0,
          // height: 40.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30.0),
            color: Colors.white,
            border: Border.all(
              width: 1.0,
              color: const Color(0xFFFF005F),
            ),
          ),
          child: SizedBox(
            width: 176.0,
            // height: 16.0,
            child: Row(
              children: <Widget>[
                Spacer(flex: 21),
                RotatedBox(
                    quarterTurns: 2,
                    child: Icon(
                      Icons.logout,
                    )),
                Spacer(flex: 28),
                Text(
                  'logout',
                  style: MyTextStyles.montsNormal16.copyWith(
                    fontSize: 16.0,
                    color: Colors.black,
                    letterSpacing: 0.78,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Spacer(flex: 62),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // logout action
  void onTap(BuildContext context) async {
    await auth.signOut();
    AppRoutes.makeFirst(context, AuthPage());
  }
}
