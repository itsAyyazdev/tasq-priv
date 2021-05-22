import 'package:tasq/models/post_model.dart';
import 'package:tasq/ui/widgets/admin/my_text_field.dart';
import 'package:tasq/ui/widgets/shared/k_button.dart';
import 'package:tasq/utils/globals/app_data/app_data.dart';
import 'package:tasq/utils/globals/import_hub.dart';

class AddNewActivity extends StatefulWidget {
  @override
  _AddNewActivityState createState() => _AddNewActivityState();
}

class _AddNewActivityState extends State<AddNewActivity> {
  String selectedCategory, dueIn, reward;
  int assignTo;
  TextEditingController nameCont = TextEditingController();
  TextEditingController descriptionCont = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppbar(
        autoImplyLeading: true,
        title: "new activity",
        showChatIcon: false,
        // trailing: Container(),
      ),
      body: Padding(
        padding: EdgeInsets.all(Get.width * 0.04),
        child: ListView(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MyTextField(
              title: "tasQ name",
            ),
            MyTextField(
              title: "description",
            ),
            dropDown(0,
                title: "category",
                hintText: "select category",
                list: AppData.activityCategories, onChanged: (r) {
              setState(() {
                selectedCategory = r;
              });
            }),
            dropDown(0,
                title: "activity due in",
                hintText: "select due days",
                list: AppData.activityDueCount, onChanged: (r) {
              setState(() {
                dueIn = r;
              });
            }),
            dropDown(0,
                title: "assign to",
                hintText: "select whom to assign",
                list: AppData.activityAssignTo, onChanged: (r) {
              setState(() {
                assignTo = AppData.activityAssignTo.indexOf(r);
              });
            }),
            dropDown(3,
                title: "rewards offered",
                hintText: "select reward",
                list: AppData.activityRewards, onChanged: (r) {
              setState(() {
                reward = r;
              });
            }),
            reward == null
                ? Container()
                : Padding(
                    padding: EdgeInsets.fromLTRB(
                        0, Get.height * 0.03, Get.width * 0.26, 10),
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40.0),
                        border: Border.all(
                          width: 1.0,
                          color: const Color(0xFFDC143D),
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Expanded(
                            child: Text(
                              '$reward',
                              style: MyTextStyles.montsSemiBold16.copyWith(
                                fontSize: 14.0,
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                                height: 1.56,
                              ),
                            ),
                          ),
                          IconButton(
                            visualDensity: VisualDensity.compact,
                            icon: Icon(Icons.remove_circle_outline),
                            onPressed: () {
                              setState(() {
                                reward = null;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
            Padding(
              padding: EdgeInsets.only(
                  top: Get.height * 0.1,
                  left: Get.width * 0.1,
                  right: Get.width * 0.1),
              child: MyButton(
                title: "SEE POST PREVIEW",
                onTap: onPreviewTapped,
              ),
            ),
            SizedBox(
              height: 64,
            ),
          ],
        ),
      ),
    );
  }

  Widget dropDown(int index,
      {String title, String hintText, List<String> list, Function onChanged}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(
              top: Get.height * 0.03, bottom: Get.height * 0.024),
          child: Text(
            "$title",
            style: MyTextStyles.montsSemiBold16.copyWith(fontSize: 18),
          ),
        ),
        Container(
          alignment: Alignment.centerLeft,
          constraints: BoxConstraints(maxWidth: Get.width * 0.54),
          child: DropdownButtonFormField(
            decoration: InputDecoration(
                hintText: "$hintText",
                hintStyle: MyTextStyles.montsSemiBold16
                    .copyWith(color: Colors.black, fontSize: 16),
                contentPadding: EdgeInsets.all(12),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: AppConfig.colors.themeBlue))),
            items: List.generate(list.length, (index) {
              return DropdownMenuItem(
                child: ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: Get.width * 0.4),
                  child: Text(
                    list[index],
                    style: MyTextStyles.montsSemiBold16
                        .copyWith(color: Colors.black, fontSize: 16),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                value: list[index],
              );
            }),
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }

  // class internal functions
  onPreviewTapped() {
    PostModel pm = PostModel(
        postName: nameCont.text,
        points: "12",
        orgId: "",
        orgName: "",
        assignTo: "",
        rewardOffer: reward,
        rewardOfferId: "",
        category: selectedCategory,
        createdAt: DateTime.now().subtract(Duration(minutes: 3)));
    AppRoutes.push(context, PostPreview(post: pm));
  }
}
