import 'package:tasq/models/post_model.dart';
import 'package:tasq/ui/widgets/shared/task_card.dart';
import 'package:tasq/utils/globals/app_data/app_data.dart';
import 'package:tasq/utils/globals/app_data/dummy_data.dart';
import 'package:tasq/utils/globals/import_hub.dart';

class UserProfile extends StatefulWidget {
  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile>
    with TickerProviderStateMixin {
  TabController tCont;
  initTabController() {
    tCont = TabController(length: 2, vsync: this);
  }

  @override
  void initState() {
    initTabController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppbar(
        title: "me",
      ),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(flex: 0, child: userInfo()),
            Expanded(child: tabs()),
          ],
        ),
      ),
    );
  }

  Widget userInfo() {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundImage: NetworkImage(AppData.userImage),
            backgroundColor: Colors.transparent,
            radius: 42,
          ),
        ),
        Expanded(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Ayyaz Khan',
              style: MyTextStyles.montsBold16.copyWith(
                fontSize: 14.0,
                color: Colors.black,
                fontWeight: FontWeight.w700,
                height: 1.14,
              ),
            ),
            // Group: Group 1347
            SizedBox(
              height: 12,
            ),
            SizedBox(
              child: Row(
                children: <Widget>[
                  SvgPicture.string(
                    // Icon awesome-star
                    '<svg viewBox="81.83 101.0 18.81 18.0" ><path transform="translate(81.11, 101.0)" d="M 9.116015434265137 0.625781238079071 L 6.8203125 5.280468940734863 L 1.683984398841858 6.029296875 C 0.762890636920929 6.162890434265137 0.3937500715255737 7.298437595367432 1.061718702316284 7.948828220367432 L 4.777734279632568 11.56992149353027 L 3.898828029632568 16.68515586853027 C 3.740624904632568 17.60976600646973 4.714453220367432 18.30234336853027 5.530077934265137 17.86992073059082 L 10.125 15.45468711853027 L 14.71992206573486 17.86992073059082 C 15.53554725646973 18.29882621765137 16.50937461853027 17.60976409912109 16.35117149353027 16.68515586853027 L 15.47226524353027 11.56992149353027 L 19.18828010559082 7.948827743530273 C 19.85624885559082 7.298437118530273 19.48710823059082 6.162890434265137 18.56601524353027 6.029296398162842 L 13.4296875 5.280468940734863 L 11.13398456573486 0.625781238079071 C 10.72265625 -0.203906238079071 9.53085994720459 -0.2144531607627869 9.116016387939453 0.625781238079071 Z" fill="#ffc811" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>',
                    width: 20,
                    height: 20,
                  ),
                  Spacer(flex: 10),
                  Text(
                    '124',
                    style: MyTextStyles.montsNormal16.copyWith(
                      fontSize: 18.0,
                      color: Colors.black,
                      fontWeight: FontWeight.w800,
                      height: 1.37,
                    ),
                  ),
                  Spacer(flex: 19),
                  Align(
                    alignment: Alignment(0.0, 0.33),
                    child: Text(
                      'tasQs points',
                      style: MyTextStyles.montsNormal16.copyWith(
                        fontSize: 14.0,
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        height: 1.36,
                      ),
                    ),
                  ),
                  Spacer(flex: 90),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      'redeem',
                      style: MyTextStyles.montsNormal16.copyWith(
                        fontSize: 12.0,
                        color: const Color(0xFF3A1FF6),
                        fontWeight: FontWeight.w700,
                        height: 1.33,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Row(
              children: <Widget>[
                Align(
                  alignment: Alignment(0.0, 0.11),
                  child: SvgPicture.string(
                    // Icon feather-check-square
                    '<svg viewBox="2.25 2.25 14.25 13.5" ><path  d="M 6.75 8.25 L 9 10.5 L 16.5 3" fill="none" stroke="#3ba410" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round" /><path  d="M 15.75 9 L 15.75 14.25 C 15.75 15.0784273147583 15.0784273147583 15.75 14.25 15.75 L 3.75 15.75 C 2.921572685241699 15.75 2.25 15.0784273147583 2.25 14.25 L 2.25 3.75 C 2.25 2.921572685241699 2.921573162078857 2.249999761581421 3.750000238418579 2.25 L 12 2.25" fill="none" stroke="#3ba410" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round" /></svg>',
                    width: 18,
                    height: 18,
                  ),
                ),
                Spacer(flex: 10),
                Text(
                  '16',
                  style: MyTextStyles.montsNormal16.copyWith(
                    fontSize: 18.0,
                    color: Colors.black,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                Spacer(flex: 19),
                Align(
                  alignment: Alignment(0.0, 0.33),
                  child: Text(
                    'tasQs created',
                    style: MyTextStyles.montsNormal16.copyWith(
                      fontSize: 14.0,
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      height: 1.36,
                    ),
                  ),
                ),
                Spacer(flex: 90),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    'see all',
                    style: MyTextStyles.montsNormal16.copyWith(
                      fontSize: 12.0,
                      color: const Color(0xFF3A1FF6),
                      fontWeight: FontWeight.w700,
                      height: 1.33,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ))
      ],
    );
  }

  Widget tabs() {
    return Column(
      children: [
        TabBar(
          controller: tCont,
          indicatorColor: Colors.black,
          indicatorSize: TabBarIndicatorSize.tab,
          tabs: List.generate(2, (index) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                index == 0 ? "applied" : "in progress",
                style: MyTextStyles.montsSemiBold16
                    .copyWith(color: Colors.black, fontSize: 20),
              ),
            );
          }),
        ),
        Expanded(
          child: TabBarView(controller: tCont, children: [
            applied(),
            inProgress(),
          ]),
        ),
      ],
    );
  }

  Widget applied() {
    return FutureBuilder(
      future: Future.delayed(Duration(milliseconds: 2), () => 1),
      builder: (context, AsyncSnapshot<int> value) {
        if (!value.hasData) {
          return Padding(
              padding: EdgeInsets.all(Get.width * 0.4), child: Container());
        } else {
          return Container(
            padding: EdgeInsets.symmetric(horizontal: Get.width * 0.01),
            child: Column(
              children: List.generate(2, (index) {
                PostModel p = DummyData.posts[index];
                return TaskWidget(
                  post: p,
                  showResponses: false,
                  showPoints: true,
                  showActive: true,
                  onTap: () {},
                );
              }),
            ),
          );
        }
      },
    );
  }

  Widget inProgress() {
    return FutureBuilder(
      future: Future.delayed(Duration(milliseconds: 2), () => 1),
      builder: (context, AsyncSnapshot<int> value) {
        if (!value.hasData) {
          return Container(
              height: 50, width: 50, child: CircularProgressIndicator());
        } else {
          return Container(
            padding: EdgeInsets.symmetric(horizontal: Get.width * 0.01),
            child: Column(
              children: List.generate(2, (index) {
                PostModel p = DummyData.posts[index];
                return TaskWidget(
                  post: p,
                  showResponses: false,
                  showPoints: true,
                  showActive: false,
                );
              }),
            ),
          );
        }
      },
    );
  }
}
