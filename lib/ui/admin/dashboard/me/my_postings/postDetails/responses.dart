import 'package:tasq/utils/globals/import_hub.dart';

class Responses extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: List.generate(12, (index) {
        return responseCard();
      }),
    );
  }

  Widget responseCard() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: Get.width * 0.05),
      child: InkWell(
        onTap: () {},
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          alignment: Alignment(0.18, 0.08),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4.0),
            color: const Color(0xFFF2F2F2),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.16),
                offset: Offset(0, 6.0),
                blurRadius: 15.0,
              ),
            ],
          ),
          child: Column(
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: CircleAvatar(
                          radius: 30,
                          backgroundImage: AssetImage(AppConfig.images.apple),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Bishant Nayak',
                            style: MyTextStyles.montsNormal16.copyWith(
                              fontSize: 16.0,
                              color: Colors.black,
                              fontWeight: FontWeight.w700,
                              height: 1.15,
                            ),
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          Row(
                            children: <Widget>[
                              Align(
                                alignment: Alignment.topCenter,
                                child: SvgPicture.string(
                                  AppConfig.svgIcons.star,
                                  width: 14.0,
                                  height: 14.0,
                                ),
                              ),
                              Text.rich(
                                TextSpan(
                                  style: MyTextStyles.montsNormal16.copyWith(
                                    fontSize: 12.0,
                                    color: Colors.black,
                                    height: 1.71,
                                  ),
                                  children: [
                                    TextSpan(
                                      text: '1500 ',
                                      style:
                                          MyTextStyles.montsNormal16.copyWith(
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    TextSpan(
                                      text: 'tasQ points',
                                      style:
                                          MyTextStyles.montsNormal16.copyWith(
                                        fontSize: 10.0,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: Icon(Icons.more_vert),
                  ),
                ],
              ),
              Text.rich(
                TextSpan(
                  style: MyTextStyles.montsNormal16.copyWith(
                    fontSize: 8.0,
                    color: Colors.black,
                    height: 1.6,
                  ),
                  children: [
                    TextSpan(
                      text: 'Bishant',
                      style: MyTextStyles.montsNormal16
                          .copyWith(fontWeight: FontWeight.w700, fontSize: 12),
                    ),
                    TextSpan(
                      text:
                          ': Hello team, I\'m interested for this role offered, I have developed numerous application in the past as well, and I believe I\'d be a great asset for your team developing this....',
                      style: MyTextStyles.montsNormal16
                          .copyWith(fontWeight: FontWeight.w500, fontSize: 12),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
