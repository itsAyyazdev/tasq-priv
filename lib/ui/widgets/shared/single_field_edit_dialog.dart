import 'package:tasq/ui/widgets/admin/my_text_field.dart';
import 'package:tasq/utils/globals/import_hub.dart';
import 'package:tasq/utils/valiadators.dart';

class SingleFieldEditDialog extends StatelessWidget {
  final String title;
  SingleFieldEditDialog({this.title});

  TextEditingController controller = TextEditingController();
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Container(
        // decoration: BoxDecoration(color: Colors.white),
        padding: EdgeInsets.symmetric(
            vertical: Get.height * 0.02, horizontal: Get.width * 0.06),
        // height: Get.height * 0.3,
        // width: Get.width * 0.8,
        child: Form(
          key: formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                title,
                style: MyTextStyles.montsBold16.copyWith(fontSize: 16),
              ),
              MyTextField(
                controller: controller,
                title: "enter name",
                validator: FieldValidator.validateBlank,
              ),
              Padding(
                padding: EdgeInsets.only(top: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                        onPressed: () => Get.back(), child: Text("Cancel")),
                    TextButton(
                        onPressed: () {
                          if (!formKey.currentState.validate()) {
                            return;
                          }
                          Get.back(result: controller.text);
                        },
                        child: Text("OK")),
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
