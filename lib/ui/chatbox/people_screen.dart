import 'package:loading_overlay/loading_overlay.dart';
import 'package:tasq/providers/chat_provider.dart';
import 'package:tasq/ui/chatbox/dms.dart';
import 'package:tasq/ui/chatbox/threads.dart';
import 'package:tasq/utils/globals/import_hub.dart';

class ChatPeople extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<ChatProvider>(
        builder: (context, p, _) => LoadingOverlay(
              isLoading: p.isLoading,
              child: Scaffold(
                appBar: MyAppbar(
                  title: "messages",
                  showChatIcon: false,
                  trailing: addPeople(p),
                  autoImplyLeading: true,
                ),
                body: MessageSwitch(),
              ),
            ));
  }

  Widget addPeople(ChatProvider p) {
    return IconButton(
      icon: Icon(
        Icons.add,
        color: Colors.white,
        size: 36,
      ),
      onPressed: p.addPeopleFromTeam,
    );
  }
}

class MessageSwitch extends StatefulWidget {
  _MessageSwitch createState() => _MessageSwitch();
}

class _MessageSwitch extends State<MessageSwitch>
    with SingleTickerProviderStateMixin {
  Animation<double> animation;
  PageController pageController = PageController();
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
    return Container(
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
                                animatePageTo(0);
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
                                animatePageTo(1);
                              },
                              child: button(1))),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Expanded(
              child: PageView(
            controller: pageController,
            children: [
              DMs(),
              Threads(),
            ],
          )),
        ],
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

  // page moving function
  void animatePageTo(int index) {
    pageController.animateToPage(index,
        duration: Duration(milliseconds: 500),
        curve: Curves.fastLinearToSlowEaseIn);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
