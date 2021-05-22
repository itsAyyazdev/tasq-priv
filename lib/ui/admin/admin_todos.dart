import 'package:tasq/utils/globals/import_hub.dart';

class AdminTodos extends StatefulWidget {
  @override
  _AdminTodosState createState() => _AdminTodosState();
}

class _AdminTodosState extends State<AdminTodos> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(1, (index) {
        return myTodo();
      }),
    );
  }

  Widget myTodo() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        padding: EdgeInsets.all(Get.width * 0.05),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4.0),
          color: Colors.white,
          border: Border.all(
            width: 1.0,
            color: const Color(0xFF0C65FF),
          ),
        ),
        child: Row(
          children: <Widget>[
            Spacer(flex: 12),
            Container(
              height: 16,
              width: 16,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
                border: Border.all(
                  width: 1.0,
                  color: const Color(0xFF0022FF),
                ),
              ),
            ),
            Spacer(flex: 13),
            Text(
              'collect funding milestones',
              style: MyTextStyles.montsSemiBold16.copyWith(
                fontSize: 16,
                color: Colors.black,
                fontWeight: FontWeight.w500,
              ),
            ),
            Spacer(flex: 116),
          ],
        ),
      ),
    );
  }
}
