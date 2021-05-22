import 'package:flutter_svg/flutter_svg.dart';
import 'package:tasq/utils/globals/import_hub.dart';

class MyRewards extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(
            top: 8.0, left: Get.width * 0.03, right: Get.width * 0.03),
        child: Column(
          children: List.generate(10, (index) {
            return rewardWidget();
          }),
        ),
      ),
    );
  }

  Widget rewardWidget() {
    return Padding(
      padding: EdgeInsets.only(
        top: 20.0,
      ),
      child: Container(
        width: Get.width,
        padding: AppUtils.cardsPadding,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6.0),
          color: Colors.black,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.16),
              offset: Offset(0, 6.0),
              blurRadius: 15.0,
            ),
          ],
        ),
        child: SizedBox(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Align(
                alignment: Alignment.centerLeft,
                child: SizedBox(
                  child: Row(
                    children: <Widget>[
                      SvgPicture.string(
                        // Icon awesome-medal
                        '<svg viewBox="23.35 136.23 30.0 30.0" ><path transform="translate(23.35, 136.23)" d="M 13.1103515625 7.6611328125 L 9.059765815734863 0.9105468988418579 C 8.720988273620605 0.3456701040267944 8.110630035400391 7.987022399902344e-06 7.451952934265137 0 L 0.939257800579071 0 C 0.1804687529802322 0 -0.263671875 0.853710949420929 0.1710937470197678 1.475390672683716 L 6.690820693969727 10.78945255279541 C 8.43222713470459 9.162303924560547 10.64707088470459 8.045507431030273 13.1103515625 7.661132335662842 Z M 29.06074142456055 0 L 22.54804611206055 0 C 21.88945198059082 0 21.27890586853027 0.345703125 20.94023323059082 0.9105468988418579 L 16.8896484375 7.6611328125 C 19.35293006896973 8.045507431030273 21.56777381896973 9.162304878234863 23.30917930603027 10.78886699676514 L 29.82890701293945 1.475390672683716 C 30.263671875 0.853710949420929 29.81953048706055 0 29.06074142456055 0 Z M 15 9.375 C 9.3046875 9.375 4.6875 13.9921875 4.6875 19.6875 C 4.6875 25.3828125 9.3046875 30 15 30 C 20.6953125 30 25.3125 25.3828125 25.3125 19.6875 C 25.3125 13.9921875 20.6953125 9.375 15 9.375 Z M 20.42109298706055 18.58945274353027 L 18.19863128662109 20.75507736206055 L 18.72421646118164 23.81484222412109 C 18.81796646118164 24.36327934265137 18.24023246765137 24.78222465515137 17.74863052368164 24.52324104309082 L 15 23.07890701293945 L 12.251953125 24.52324295043945 C 11.759765625 24.78398513793945 11.1826171875 24.36269569396973 11.2763671875 23.81484413146973 L 11.80195331573486 20.75507926940918 L 9.579492568969727 18.58945465087891 C 9.179883003234863 18.20039176940918 9.400781631469727 17.52128982543945 9.951562881469727 17.44160270690918 L 13.02363300323486 16.99394607543945 L 14.396484375 14.20957088470459 C 14.52011680603027 13.95878982543945 14.75918006896973 13.83515644073486 14.99882793426514 13.83515644073486 C 15.23964786529541 13.83515644073486 15.48046875 13.96054744720459 15.60410118103027 14.20957088470459 L 16.97695350646973 16.99394607543945 L 20.04902458190918 17.44160270690918 C 20.59980583190918 17.52128982543945 20.82070350646973 18.20039176940918 20.42109489440918 18.58945465087891 Z" fill="#ffffff" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>',
                        width: 40.0,
                        height: 40.0,
                      ),
                      SizedBox(
                        width: 24,
                      ),
                      Text(
                        '₹500 Bocca Café \nVoucher',
                        style: MyTextStyles.montsBold16.copyWith(
                          fontSize: 20.0,
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          height: 1.25,
                        ),
                      ),
                      Spacer(flex: 16),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 16,
              ),
              // Group: Group 1343
              Padding(
                padding: const EdgeInsets.only(left: 64),
                child: Container(
                  width: Get.width * 0.4,
                  padding: EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(19.0),
                    color: Colors.white,
                  ),
                  child: Text(
                    '456YFSIN',
                    style: MyTextStyles.montsSemiBold16.copyWith(
                      fontSize: 13.0,
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                      height: 1.23,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 12),
            ],
          ),
        ),
      ),
    );
  }
}
