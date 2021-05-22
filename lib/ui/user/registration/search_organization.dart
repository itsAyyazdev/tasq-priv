import 'package:tasq/ui/widgets/shared/gradient_container_blue.dart';
import 'package:tasq/ui/widgets/user/autocomplete_search.dart';
import 'package:tasq/utils/globals/import_hub.dart';

class SearchOrganization extends StatelessWidget {
  final TextEditingController cont = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(builder: (context, p, _) {
      String firstName = p.userDataToSet.name?.split(" ")?.first ?? "";

      return Scaffold(
        body: Column(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(AppUtils.topMargin, Get.width * 0.14,
                  Get.width * 0.034, Get.width * 0.02),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Ready to go\n" + "$firstName" + "?" + " :)",
                        style:
                            MyTextStyles.montsSemiBold16.copyWith(fontSize: 26),
                      ),
                      IconButton(
                          icon: SvgPicture.string(
                              // Icon feather-edit
                              '<svg viewBox="1.25 1.17 12.58 12.58" ><path  d="M 6.875 2.5 L 2.5 2.5 C 1.809643983840942 2.5 1.24999988079071 3.059644222259521 1.25 3.750000238418579 L 1.25 12.5 C 1.25 13.19035625457764 1.809644103050232 13.75 2.5 13.75 L 11.25 13.75 C 11.94035625457764 13.75 12.5 13.19035625457764 12.5 12.5 L 12.5 8.125" fill="none" stroke="#000000" stroke-width="1.25" stroke-linecap="round" stroke-linejoin="round" /><path  d="M 11.5625 1.5625 C 12.08026790618896 1.044733047485352 12.91973400115967 1.044733047485352 13.43750095367432 1.5625 C 13.95526790618896 2.080266952514648 13.95526790618896 2.919733047485352 13.43750095367432 3.4375 L 7.5 9.375 L 5 10 L 5.625 7.5 L 11.5625 1.5625 Z" fill="none" stroke="#000000" stroke-width="1.25" stroke-linecap="round" stroke-linejoin="round" /></svg>',
                              width: 16,
                              height: 16),
                          onPressed: () {})
                    ],
                  ),
                  SizedBox(
                    height: Get.height * 0.05,
                  ),
                  Text(
                    "search for your organisation, and you're good to go",
                    style: MyTextStyles.montsSemiBold16.copyWith(fontSize: 20),
                  ),
                  SizedBox(
                    height: Get.height * 0.04,
                  ),
                  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: AutoCompleteSearch(
                        onSelected: (org) => onNextTapped(firstName, p),
                      )),
                  GradientContainerBlue(
                    height: Get.height * 0.004,
                    width: Get.width,
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: Get.height * 0.05),
              child: TextButton(
                onPressed: () => onNextTapped(firstName, p),
                child: Text(
                  'skip',
                  style: MyTextStyles.montsNormal16.copyWith(
                    fontSize: 20.0,
                    color: const Color(0xFF2861E8),
                    fontWeight: FontWeight.w500,
                    height: 1.46,
                  ),
                ),
              ),
            ),
            Expanded(
              child: SizedBox(),
            ),
            NextNavigationBottom(
              onTap: () => onNextTapped(firstName, p),
            )
          ],
        ),
      );
    });
  }

  void onNextTapped(String name, AuthProvider p) {
    AppRoutes.push(
        Get.context,
        SetImage(
          heading: "Almost there\n" + "$name!" + ":)",
          description:
              "add a photograph, so your peers and potential clients can identify you.",
          onNext: p.createUserInDB,
        ));
  }
}
