import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:tasq/models/job.dart';
import 'package:tasq/models/reward_model.dart';
import 'package:tasq/ui/widgets/admin/my_text_field.dart';
import 'package:tasq/ui/widgets/shared/k_button.dart';
import 'package:tasq/utils/globals/app_data/app_data.dart';
import 'package:tasq/utils/globals/app_data/app_user.dart';
import 'package:tasq/utils/globals/import_hub.dart';
import 'package:tasq/utils/valiadators.dart';

class AddNewActivity extends StatefulWidget {
  @override
  _AddNewActivityState createState() => _AddNewActivityState();
}

class _AddNewActivityState extends State<AddNewActivity> {
  String selectedCategory, dueIn, assignTo;
  RewardModel rewards;
  int assignType;
  TextEditingController nameCont = TextEditingController();
  TextEditingController descriptionCont = TextEditingController();
  TextEditingController pointsCont = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Consumer<AdminProvider>(
        builder: (context, adminProvider, _) => Scaffold(
              appBar: MyAppbar(
                autoImplyLeading: true,
                title: "new activity",
                showChatIcon: false,
                // trailing: Container(),
              ),
              body: LoadingOverlay(
                isLoading: adminProvider.isLoading,
                child: Padding(
                  padding: EdgeInsets.all(Get.width * 0.04),
                  child: Form(
                    key: formKey,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    child: ListView(
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MyTextField(
                          title: "tasQ name",
                          controller: nameCont,
                          validator: FieldValidator.validateBlank,
                        ),
                        MyTextField(
                          title: "description",
                          controller: descriptionCont,
                          validator: FieldValidator.validateBlank,
                        ),
                        MyTextField(
                          title: "points",
                          controller: pointsCont,
                          keyboardType: TextInputType.phone,
                          validator: FieldValidator.validateBlank,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
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
                            assignTo = r;
                            assignType = AppData.activityAssignTo.indexOf(r);
                          });
                        }),
                        dropDownReward(3,
                            title: "rewards offered",
                            hintText: "select reward",
                            list: adminProvider.rewardList, onChanged: (r) {
                          setState(() {
                            rewards = r;
                          });
                        }),
                        rewards == null
                            ? Container()
                            : Padding(
                                padding: EdgeInsets.fromLTRB(
                                    0, Get.height * 0.03, Get.width * 0.26, 10),
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 14, vertical: 6),
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
                                          '${rewards.name}',
                                          style: MyTextStyles.montsSemiBold16
                                              .copyWith(
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
                                            rewards = null;
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
                ),
              ),
            ));
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
          constraints: BoxConstraints(maxWidth: Get.width * 0.7),
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
                  constraints: BoxConstraints(maxWidth: Get.width * 0.6),
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

  Widget dropDownReward(int index,
      {String title,
      String hintText,
      List<RewardModel> list,
      Function onChanged}) {
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
          constraints: BoxConstraints(maxWidth: Get.width * 0.7),
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
                    list[index].name,
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
    if (!formKey.currentState.validate()) {
      return AppUtils.showSnackbar(
          msg: "Please fill the form correctly", isError: true);
    }
    if (selectedCategory == null ||
        assignType == null ||
        dueIn == null ||
        rewards == null) {
      return AppUtils.showSnackbar(
          msg: "Please fill the form correctly", isError: true);
    }
    Job pm = Job(
        title: nameCont.text,
        postedAt: Timestamp.now(),
        expiry: expiry(dueIn),
        isActive: true,
        rewardOfferName: rewards.name,
        orgId: AppUser.organization.orgId,
        orgName: AppUser.organization.name,
        description: descriptionCont.text,
        assignToId: "",
        assignTo: AssignTo(name: "", proposal: "", applicationId: ""),
        assignType: assignType,
        rewardOfferId: rewards.rewardId,
        category: selectedCategory,
        categoryId: 0,
        postedBy: AppUser.user.email,
        points: int.parse(pointsCont.text));
    print(pm.expiry.toDate());
    AppRoutes.push(
        context,
        PostPreview(
          postData: pm,
          dueIn: dueIn,
        ));
  }

  Timestamp expiry(String duration) {
    int dur = int.parse(duration);
    DateTime time = DateTime.now().add(Duration(days: dur));
    return Timestamp.fromDate(time);
  }
}
