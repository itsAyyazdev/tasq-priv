import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tasq/models/org_member.dart';
import 'package:tasq/models/user.dart';
import 'package:tasq/ui/widgets/shared/empty_screen.dart';
import 'package:tasq/utils/globals/import_hub.dart';

class PendingRequests extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<AdminProvider>(
        builder: (context, p, _) => LoadingOverlay(
              isLoading: p.isLoading,
              child: Scaffold(
                appBar: MyAppbar(
                  title: "pending requests",
                  autoImplyLeading: true,
                  showChatIcon: false,
                ),
                body: p.pendingRequests.isEmpty
                    ? EmptyScreen(
                        msg: "No requests pending",
                      )
                    : ListView.separated(
                        itemCount: p.pendingRequests.length,
                        itemBuilder: (context, index) {
                          OrgMember member = p.pendingRequests[index];
                          return FutureBuilder(
                              future: member.user.get(),
                              builder: (context,
                                  AsyncSnapshot<DocumentSnapshot> snapshot) {
                                if (!snapshot.hasData) {
                                  return requestShimmer();
                                } else {
                                  UserData user =
                                      UserData.fromJson(snapshot.data.data());
                                  return request(
                                      user: user, member: member, p: p);
                                }
                              });
                        },
                        separatorBuilder: (context, index) => Divider(
                          color: Colors.black,
                        ),
                      ),
              ),
            ));
  }

  Widget request({UserData user, OrgMember member, AdminProvider p}) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: Get.width * 0.03, vertical: Get.height * 0.01),
      child: Row(
        children: <Widget>[
          Container(
            width: 55.0,
            height: 55.0,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: NetworkImage(user.imageUrl),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Expanded(
            child: Center(
              child: Text(
                user.name ?? "",
                style: MyTextStyles.montsNormal16.copyWith(
                  fontSize: 20.0,
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                GestureDetector(
                  onTap: () => p.acceptRequest(member.requestedId),
                  child: Container(
                    alignment: Alignment.center,
                    width: 30.0,
                    height: 30.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: const Color(0xFFF62B40),
                    ),
                    child: SvgPicture.string(
                      // Icon metro-cross
                      '<svg viewBox="247.86 97.72 8.57 8.57" ><path transform="translate(247.14, 97.18)" d="M 9.204978942871094 7.419748783111572 C 9.20494556427002 7.419715404510498 9.204912185668945 7.419682025909424 9.204878807067871 7.419665336608887 L 6.605355739593506 4.820083618164062 L 9.204887390136719 2.220502138137817 L 9.204987525939941 2.220418453216553 C 9.232021331787109 2.193349599838257 9.252893447875977 2.160763502120972 9.266177177429199 2.124887466430664 C 9.30170726776123 2.029690265655518 9.281439781188965 1.918343067169189 9.204887390136719 1.841790795326233 L 7.976878643035889 0.6137908101081848 C 7.900326251983643 0.5372552275657654 7.789012432098389 0.5170041918754578 7.693799018859863 0.5525355935096741 C 7.657925605773926 0.5658268928527832 7.62533712387085 0.5866906642913818 7.598250865936279 0.6137069463729858 C 7.598250865936279 0.6137406229972839 7.598217487335205 0.613757312297821 7.598184108734131 0.6137908101081848 L 4.998619079589844 3.213389158248901 L 2.399054288864136 0.6138075590133667 L 2.398970603942871 0.6137238740921021 C 2.371899366378784 0.5867050886154175 2.339321136474609 0.5658405423164368 2.30345630645752 0.5525524020195007 C 2.208225965499878 0.5170042514801025 2.096912145614624 0.537272036075592 2.020359754562378 0.6138075590133667 L 0.7923430800437927 1.841824293136597 C 0.7157907485961914 1.918376564979553 0.6955397129058838 2.029707193374634 0.7310711145401001 2.124903678894043 C 0.744367241859436 2.160773515701294 0.7652370929718018 2.193356990814209 0.7922595143318176 2.220434904098511 C 0.7922928929328918 2.220451831817627 0.792309582233429 2.22048544883728 0.7923430800437927 2.220518827438354 L 3.391924619674683 4.820083618164062 L 0.7923430800437927 7.419682025909424 L 0.79227614402771 7.419765472412109 C 0.7652584314346313 7.446844577789307 0.744384229183197 7.479420185089111 0.7310709953308105 7.515280723571777 C 0.6955230236053467 7.610476970672607 0.7157908082008362 7.721824169158936 0.7923430800437927 7.798376560211182 L 2.020359754562378 9.026376724243164 C 2.096928834915161 9.10292911529541 2.208242654800415 9.123180389404297 2.30345606803894 9.087648391723633 C 2.3393235206604 9.074347496032715 2.371906042098999 9.053478240966797 2.398987054824829 9.026459693908691 C 2.399004220962524 9.026426315307617 2.399037837982178 9.026409149169922 2.399071216583252 9.026375770568848 L 4.998636245727539 6.426794052124023 L 7.598200798034668 9.026375770568848 L 7.598301410675049 9.026442527770996 C 7.625374317169189 9.053467750549316 7.657951831817627 9.074342727661133 7.693816184997559 9.087646484375 C 7.789029598236084 9.123178482055664 7.900376796722412 9.102928161621094 7.976895809173584 9.026375770568848 L 9.204895973205566 7.798358917236328 C 9.281448364257812 7.721806526184082 9.301715850830078 7.610459327697754 9.26618480682373 7.515262603759766 C 9.252884864807129 7.479395389556885 9.232008934020996 7.446817398071289 9.20497989654541 7.419747352600098 Z" fill="#ffffff" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>',
                      width: 8.57,
                      height: 8.57,
                    ),
                  ),
                ),
                SizedBox(
                  width: Get.width * 0.08,
                ),
                GestureDetector(
                  onTap: () => p.rejectRequest(member.requestedId),
                  child: Container(
                    alignment: Alignment(0.04, 0.0),
                    margin: EdgeInsets.only(right: 10),
                    width: 45.0,
                    height: 45.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: const Color(0xFF2BCC1A),
                    ),
                    child: SvgPicture.string(
                      // Icon awesome-check
                      '<svg viewBox="312.4 92.92 23.0 17.15" ><path transform="translate(312.4, 90.0)" d="M 7.811824321746826 19.73885154724121 L 0.3368244171142578 12.26385116577148 C -0.112259566783905 11.8147668838501 -0.112259566783905 11.08662891387939 0.3368244171142578 10.63749980926514 L 1.963131070137024 9.011148452758789 C 2.412214994430542 8.562019348144531 3.140398502349854 8.562019348144531 3.58948278427124 9.011148452758789 L 8.625 14.04662132263184 L 19.4105167388916 3.261148452758789 C 19.85960006713867 2.812064409255981 20.58778381347656 2.812064409255981 21.03686904907227 3.261148452758789 L 22.66317558288574 4.887499809265137 C 23.11225891113281 5.336583614349365 23.11225891113281 6.064722537994385 22.66317558288574 6.513851165771484 L 9.438175201416016 19.73889541625977 C 8.989046096801758 20.18797874450684 8.260908126831055 20.18797874450684 7.811823844909668 19.73884963989258 Z" fill="#ffffff" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>',
                      width: 23.0,
                      height: 17.15,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget requestShimmer() {
    return Shimmer.fromColors(
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: Get.width * 0.03, vertical: Get.height * 0.01),
        child: Row(
          children: <Widget>[
            Container(
              width: 55.0,
              height: 55.0,
              decoration:
                  BoxDecoration(shape: BoxShape.circle, color: Colors.grey),
            ),
            Expanded(
              child: Center(
                child: Container(
                  height: 20,
                  width: Get.width * 0.3,
                  color: Colors.grey,
                ),
              ),
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Container(
                    width: 40.0,
                    height: 40.0,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: Colors.grey),
                  ),
                  SizedBox(
                    width: Get.width * 0.08,
                  ),
                  Container(
                    width: 45.0,
                    height: 45.0,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: Colors.grey),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      enabled: true,
      baseColor: Colors.grey[300],
      highlightColor: Colors.grey[100],
    );
  }
}
