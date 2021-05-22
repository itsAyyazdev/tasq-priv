import 'package:tasq/models/reward_model.dart';
import 'package:tasq/ui/widgets/user/points.dart';
import 'package:tasq/utils/globals/import_hub.dart';

class RewardExploreCard extends StatelessWidget {
  final RewardModel reward;
  final Color color;

  RewardExploreCard({@required this.reward, this.color = Colors.white});
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(
            top: 8.0, left: Get.width * 0.03, right: Get.width * 0.03),
        child: card(),
      ),
    );
  }

  Widget card() {
    return Padding(
      padding: const EdgeInsets.only(top: 14.0),
      child: Container(
        padding: AppUtils.cardsPadding,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(9.0),
          color: color,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.16),
              offset: Offset(0, 3.0),
              blurRadius: 6.0,
            ),
          ],
        ),
        child: SizedBox(
          width: Get.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: CircleAvatar(
                      backgroundImage: AssetImage(AppConfig.images.apple),
                      radius: 26,
                      backgroundColor: color,
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${reward.description}',
                            style: MyTextStyles.montsNormal16.copyWith(
                              fontSize: 16.0,
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              height: 1.25,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            'By Apple Inc.',
                            style: MyTextStyles.montsNormal16.copyWith(
                              fontSize: 11.0,
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  PointsWidget(
                    value: "320",
                  ),
                  SizedBox(
                    width: Get.width * 0.03,
                  ),
                  Container(
                    width: Get.width * 0.34,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4.0),
                      color: Colors.white,
                      border: Border.all(
                        width: 1.0,
                        color: const Color(0xFF0022FF),
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 4),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(left: Get.width * 0.03),
                            child: Text(
                              'redeem',
                              style: MyTextStyles.montsNormal16.copyWith(
                                fontSize: 14.0,
                                color: const Color(0xFF1040FF),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(right: Get.width * 0.03),
                            child: SvgPicture.string(
                              // Icon feather-chevrons-right
                              '<svg viewBox="5.0 5.83 10.0 8.33" ><path  d="M 10.83333301544189 14.16666698455811 L 15 10 L 10.83333301544189 5.833333492279053" fill="none" stroke="#0022ff" stroke-width="1.6666666269302368" stroke-linecap="round" stroke-linejoin="round" /><path  d="M 5 14.16666698455811 L 9.166666984558105 10 L 5 5.833333492279053" fill="none" stroke="#0022ff" stroke-width="1.6666666269302368" stroke-linecap="round" stroke-linejoin="round" /></svg>',
                              width: 10.0,
                              height: 10,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
