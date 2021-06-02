import 'package:tasq/ui/chatbox/people_screen.dart';
import 'package:tasq/utils/constants/config.dart';
import 'package:tasq/utils/globals/import_hub.dart';

class MyAppbar extends StatelessWidget implements PreferredSizeWidget {
  final double height;
  final bool autoImplyLeading, showChatIcon;
  final String title;
  final Widget trailing;
  final Function onChatTapped;

  MyAppbar(
      {this.height,
      this.autoImplyLeading = false,
      this.showChatIcon = true,
      @required this.title,
      this.onChatTapped,
      this.trailing});
  @override
  Widget build(BuildContext context) {
    var actions = showChatIcon
        ? [
            ChatIcon(
              onTap: onChatTapped ?? () => Get.to(ChatPeople()),
            )
          ]
        : trailing == null
            ? [Container()]
            : [trailing];
    return AppBar(
      automaticallyImplyLeading: false,
      centerTitle: false,
      backgroundColor: AppConfig.colors.themeBlue,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(8), bottomRight: Radius.circular(8))),
      title: Row(
        children: [
          autoImplyLeading
              ? IconButton(
                  onPressed: () {
                    AppRoutes.pop(context);
                  },
                  icon: Icon(
                    Icons.arrow_back_rounded,
                    size: 28,
                    color: Colors.white,
                  ))
              : Container(),
          Text(
            "$title",
            style: MyTextStyles.montsSemiBold16.copyWith(fontSize: 18),
          ),
        ],
      ),
      actions: actions,
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => height ?? Size.fromHeight(56);
}

class ChatIcon extends StatelessWidget {
  final Function onTap;
  ChatIcon({this.onTap});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: IconButton(
          icon: Icon(
            Icons.messenger_outline,
            size: 32,
            color: Colors.white,
          ),
          onPressed: onTap),
    );
  }
}
