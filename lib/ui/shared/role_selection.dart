import 'package:flutter/material.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:tasq/utils/app_routes.dart';
import 'package:tasq/utils/constants/text_styles.dart';
import 'package:tasq/utils/enums.dart';
import 'package:tasq/utils/globals/import_hub.dart';

class RoleSelection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, p, _) => LoadingOverlay(
        isLoading: p.isLoading,
        child: Scaffold(
          body: Padding(
            padding: EdgeInsets.fromLTRB(Get.width * 0.03, Get.width * 0.1,
                Get.width * 0.03, Get.width * 0.02),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        "Hey,\n${p.userDataToSet.name} :)",
                        style: MyTextStyles.montsBold16.copyWith(fontSize: 24),
                      ),
                    ),
                    IconButton(icon: Icon(Icons.edit), onPressed: () {}),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: Get.width * 0.08),
                  child: KOutlinedButton(title: "register as a", onTap: () {}),
                ),
                GradientContainerBlue(
                  height: Get.height * 0.1,
                  width: Get.width * 0.9,
                  title: "User",
                  onTap: () {
                    p.userDataToSet.role = Enums.role.user;
                    p.searchOrganization();
                  },
                ),
                SizedBox(
                  height: Get.height * 0.026,
                ),
                GradientContainerGreen(
                  height: Get.height * 0.1,
                  width: Get.width * 0.9,
                  title: "admin",
                  onTap: () {
                    p.userDataToSet.role = Enums.role.admin;
                    AppRoutes.push(Get.context, CreateOrganization());
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
