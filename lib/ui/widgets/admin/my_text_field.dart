import 'package:tasq/utils/globals/import_hub.dart';

class MyTextField extends StatelessWidget {
  final TextEditingController controller;
  final String title;
  final int maxLines;
  final FocusNode focusNode;
  MyTextField({this.title, this.controller, this.maxLines = 1, this.focusNode});
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(top: Get.height * 0.024),
          child: Text(
            "$title",
            style: MyTextStyles.montsSemiBold16.copyWith(fontSize: 16),
          ),
        ),
        TextFormField(
          maxLines: maxLines,
          focusNode: focusNode,
          controller: controller,
          decoration: InputDecoration(
              enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: AppConfig.colors.themeBlue))),
        ),
      ],
    );
  }
}
