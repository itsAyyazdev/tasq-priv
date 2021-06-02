import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:tasq/models/reward_model.dart';
import 'package:tasq/ui/widgets/admin/my_text_field.dart';
import 'package:tasq/ui/widgets/shared/k_button.dart';
import 'package:tasq/ui/widgets/shared/my_app_bar.dart';
import 'package:tasq/utils/globals/app_data/app_user.dart';
import 'package:tasq/utils/globals/import_hub.dart';
import 'package:tasq/utils/valiadators.dart';

// ignore: must_be_immutable
class AddNewReward extends StatelessWidget {
  TextEditingController rewardNameCont = TextEditingController();
  TextEditingController descriptionCont = TextEditingController();
  TextEditingController voucherCont = TextEditingController();
  TextEditingController dateCont = TextEditingController();
  TextEditingController pointsCont = TextEditingController();
  DateTime pickedDate;
  String pickedDateString = 'select date';
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Consumer<AdminProvider>(
        builder: (context, p, _) => Scaffold(
              appBar: MyAppbar(
                autoImplyLeading: true,
                title: "add a new reward",
                showChatIcon: false,
                // trailing: Container(),
              ),
              body: LoadingOverlay(
                isLoading: p.isLoading,
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.all(Get.width * 0.04),
                    child: Form(
                      key: formKey,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      child: Column(
                        children: [
                          MyTextField(
                            controller: rewardNameCont,
                            title: "reward name",
                            validator: FieldValidator.validateBlank,
                          ),
                          MyTextField(
                            controller: descriptionCont,
                            maxLines: null,
                            title: "description",
                            validator: FieldValidator.validateBlank,
                          ),
                          MyTextField(
                            controller: voucherCont,
                            title: "voucher code",
                            validator: FieldValidator.validateBlank,
                          ),
                          MyTextField(
                            controller: pointsCont,
                            title: "points",
                            keyboardType: TextInputType.phone,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            validator: FieldValidator.validateBlank,
                          ),
                          SizedBox(
                            height: Get.height * 0.02,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 16, bottom: 12),
                                child: Text(
                                  "valid till",
                                  style: MyTextStyles.montsSemiBold16
                                      .copyWith(fontSize: 16),
                                ),
                              ),
                              GestureDetector(
                                onTap: () => pickExpiry(p),
                                child: TextFormField(
                                  controller: dateCont,
                                  enabled: false,
                                  decoration: InputDecoration(
                                      hintText: "$pickedDateString",
                                      hintStyle: MyTextStyles.montsSemiBold16
                                          .copyWith(
                                              color: Colors.black,
                                              fontSize: 16),
                                      disabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color:
                                                  AppConfig.colors.themeBlue)),
                                      suffixIcon: IconButton(
                                        icon:
                                            Icon(Icons.calendar_today_outlined),
                                        onPressed: () {},
                                      )),
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: Get.height * 0.1),
                            child: MyButton(
                              title: "ADD TO REWARDS",
                              onTap: () => addToRewards(p),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ));
  }

  //functions
  void pickExpiry(AdminProvider p) async {
    DateTime picked = await showDatePicker(
        context: Get.context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime.parse("20220101"));
    if (picked != null) {
      pickedDate = picked;
      pickedDateString = DateFormat("dd-MM-yyyy").format(picked).toString();
      dateCont.text = pickedDateString;
      // ignore: invalid_use_of_visible_for_testing_member
      p.notifyListeners();
    }
  }

  void addToRewards(AdminProvider p) async {
    if (!formKey.currentState.validate()) {
      return AppUtils.showSnackbar(
          msg: "Please fill the form correctly", isError: true);
    }
    if (pickedDate == null) {
      return AppUtils.showSnackbar(
          msg: "Please fill the form correctly", isError: true);
    }
    RewardModel model = RewardModel(
      name: rewardNameCont.text,
      description: descriptionCont.text,
      voucher: voucherCont.text,
      validTill: Timestamp.fromDate(pickedDate),
      orgId: AppUser.organization.orgId,
      companyLogo: AppUser.organization.logo,
      companyName: AppUser.organization.name,
      isActive: true,
      points: int.parse(pointsCont.text),
      rewardId: Timestamp.now().millisecondsSinceEpoch.toString(),
    );
    p.addReward(model);
  }
}
