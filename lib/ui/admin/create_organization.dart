import 'package:flutter/material.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:tasq/ui/widgets/shared/gradient_container_blue.dart';
import 'package:tasq/utils/app_routes.dart';
import 'package:tasq/utils/constants/text_styles.dart';
import 'package:tasq/utils/globals/import_hub.dart';
import 'package:tasq/utils/globals/utils.dart';

class CreateOrganization extends StatelessWidget {
  final TextEditingController cont = TextEditingController();
  String orgName = "";

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
        builder: (context, p, _) => LoadingOverlay(
              isLoading: p.isLoading,
              child: Scaffold(
                body: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(
                          AppUtils.topMargin,
                          Get.width * 0.14,
                          Get.width * 0.034,
                          Get.width * 0.02),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "We're almost there,\n${p.userDataToSet.name}",
                            style: MyTextStyles.montsSemiBold16
                                .copyWith(fontSize: 26),
                          ),
                          SizedBox(
                            height: Get.height * 0.05,
                          ),
                          Text(
                            "name your organization",
                            style: MyTextStyles.montsSemiBold16
                                .copyWith(fontSize: 20),
                          ),
                          SizedBox(
                            height: Get.height * 0.04,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 12.0),
                            child: TextFormField(
                              controller: cont,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  contentPadding:
                                      EdgeInsets.symmetric(vertical: 3)),
                              onChanged: (v) => orgName = v,
                            ),
                          ),
                          GradientContainerBlue(
                            height: Get.height * 0.004,
                            width: Get.width,
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: SizedBox(),
                    ),
                    NextNavigationBottom(
                      onTap: () => onTapNext(context, p),
                    )
                  ],
                ),
              ),
            ));
  }

  void onTapNext(BuildContext context, AuthProvider p) {
    if (orgName.isEmpty) {
      return AppUtils.showSnackbar(
          msg: "Please enter organization name", isError: true);
    }

    AppRoutes.push(
        context,
        SetImage(
          heading: "add your organisation logo",
          description:
              "add a logo, so your peers and team members can identify and join you.",
          onNext: (c) => p.registerOrg(orgName, c),
        ));
  }
}
