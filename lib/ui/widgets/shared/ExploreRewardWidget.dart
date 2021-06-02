import 'package:tasq/models/reward_model.dart';
import 'package:tasq/utils/globals/import_hub.dart';

class ExploreRewardWidget extends StatelessWidget {
  final String buttonTitle;
  final Function onButtonTap;
  final RewardModel reward;
  ExploreRewardWidget({this.buttonTitle, this.onButtonTap, this.reward});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: Container(
        padding: AppUtils.cardsPadding,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(9.0),
          color: Colors.white,
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
                      backgroundImage: NetworkImage(reward.companyLogo ?? ""),
                      radius: 26,
                      backgroundColor: Colors.transparent,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: Get.width * 0.016),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ConstrainedBox(
                          constraints:
                              BoxConstraints(maxWidth: Get.width * 0.64),
                          child: Text(
                            '${reward?.description ?? ""}',
                            style: MyTextStyles.montsNormal16.copyWith(
                              fontSize: 15.0,
                              color: Colors.black,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'By ${reward.companyName}',
                          style: MyTextStyles.montsNormal16.copyWith(
                            fontSize: 12.0,
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  InkWell(
                    onTap: () {
                      onButtonTap(reward);
                    },
                    child: Container(
                      alignment: Alignment(0.0, -0.14),
                      width: Get.width * 0.34,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(24.0),
                        color: Colors.white,
                        border: Border.all(
                          width: 1.0,
                          color: const Color(0xFF0022FF),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 6.0),
                        child: Text(
                          '$buttonTitle',
                          style: MyTextStyles.montsNormal16.copyWith(
                            fontSize: 12.0,
                            color: const Color(0xFF1040FF),
                            fontWeight: FontWeight.w500,
                            height: 1.27,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
