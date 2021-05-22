import 'package:tasq/ui/chatbox/dms.dart';
import 'package:tasq/utils/globals/import_hub.dart';

import 'indiviualChat.dart';

class ChatPeople extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Widget trailing = IconButton(
      icon: Icon(
        Icons.add,
        color: Colors.white,
        size: 36,
      ),
      onPressed: () {},
    );

    return Scaffold(
      appBar: MyAppbar(
        title: "messages",
        showChatIcon: false,
        trailing: trailing,
        autoImplyLeading: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            MessageSwitch(),
            DMs(),
          ],
        ),
      ),
    );
  }
}

class MessageSwitch extends StatefulWidget {
  _MessageSwitch createState() => _MessageSwitch();
}

class _MessageSwitch extends State<MessageSwitch>
    with SingleTickerProviderStateMixin {
  Animation<double> animation;
  AnimationController controller;

  int tab = 0;
  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(vsync: this, duration: Duration(seconds: 1));
    animation = Tween<double>(begin: 0, end: 300).animate(controller);
  }

  startAnimation() {
    animation = animation
      ..addListener(() {
        setState(() {
          print(animation.value);
        });
      });
    controller.forward();
  }

  reverseAnimations() {
    animation = animation
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          controller.reverse();
        } else if (status == AnimationStatus.dismissed) {
          controller.forward();
        }
      });
    setState(() {
      print(animation.value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        height: Get.height * 0.98,
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: Get.width * 0.9,
                height: Get.height * 0.07,
                margin: EdgeInsets.symmetric(vertical: Get.height * 0.01),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  color: Colors.grey[300],
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.16),
                      offset: Offset(0, 6.0),
                      blurRadius: 7.0,
                    ),
                  ],
                ),
                child: GestureDetector(
                  onTap: () {
                    startAnimation();
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: Get.height * 0.005),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                            flex: 3,
                            child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    tab = 0;
                                  });
                                },
                                child: button(0))),
                        SizedBox(width: Get.width * 0.02),
                        Expanded(
                            flex: 3,
                            child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    tab = 1;
                                  });
                                },
                                child: button(1))),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(
                  vertical: Get.height * 0.03, horizontal: Get.width * 0.06),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Unreads",
                    style: MyTextStyles.montsBold16.copyWith(
                        fontSize: 14,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: Get.height * 0.02),
                  unRead("Bishant", 2),
                  SizedBox(height: Get.height * 0.04),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Peoples",
                        style: MyTextStyles.montsBold16.copyWith(
                            fontSize: 14,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                      IconButton(icon: Icon(Icons.add), onPressed: () {}),
                    ],
                  ),
                  read("Me (Ayyaz Khan)"),
                  read("Bishant"),
                  read("Jigyanshu"),
                  read("SanJeevani"),
                  read("Shriya"),
                  read("Lipsa"),
                  read("Samrudhee"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget unRead(title, unreadCount) {
    return GestureDetector(
      onTap: () {
        Get.to(IndividualChat(name: title));
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: Get.height * 0.007),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 12,
              height: 12,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                color: Colors.grey[300],
              ),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: Colors.white,
                ),
                width: 9,
                height: 9,
              ),
            ),
            SizedBox(width: Get.width * 0.03),
            Text(
              "$title",
              style: MyTextStyles.montsBold16.copyWith(fontSize: 16),
            ),
            Spacer(),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                color: AppConfig.colors.deepPink,
              ),
              alignment: Alignment.center,
              width: 30,
              height: 15,
              child: Text(
                "$unreadCount",
                style: MyTextStyles.montsBold16
                    .copyWith(fontSize: 10, color: Colors.white),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget read(title) {
    return GestureDetector(
      onTap: () {
        Get.to(IndividualChat(name: title));
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: Get.height * 0.007),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 12,
              height: 12,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                color: Colors.grey[300],
              ),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: Colors.white,
                ),
                width: 9,
                height: 9,
              ),
            ),
            SizedBox(width: Get.width * 0.03),
            Text(
              "$title",
              style: MyTextStyles.montsBold16.copyWith(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }

  Widget button(int index) {
    return Align(
      alignment: Alignment.center,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: Get.height * 0.005),
        width: Get.width * 0.4,
        height: 37.0,
        alignment: Alignment.center,
        decoration: tab == index
            ? BoxDecoration(
                borderRadius: BorderRadius.circular(6.0),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.16),
                    offset: Offset(0, 6.0),
                    blurRadius: 2,
                  ),
                ],
              )
            : BoxDecoration(
                borderRadius: BorderRadius.circular(6.0),
                color: Colors.grey[300],
              ),
        child: Text(
          index == 0 ? 'DMs' : 'Threads',
          style: MyTextStyles.montsNormal16.copyWith(
            fontSize: 13.0,
            color: Colors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
