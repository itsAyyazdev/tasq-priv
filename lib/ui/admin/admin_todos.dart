import 'package:tasq/models/todo.dart';
import 'package:tasq/ui/widgets/admin/todo_edit.dart';
import 'package:tasq/ui/widgets/shared/empty_screen.dart';
import 'package:tasq/utils/globals/import_hub.dart';

class AdminTodos extends StatefulWidget {
  @override
  _AdminTodosState createState() => _AdminTodosState();
}

class _AdminTodosState extends State<AdminTodos> {
  @override
  Widget build(BuildContext context) {
    return Consumer<AdminProvider>(builder: (context, p, _) {
      if (p.adminTodos.isEmpty) {
        return EmptyScreen(
          msg: "No todos added yet",
        );
      } else {
        return Column(
          children: List.generate(p.adminTodos.length, (index) {
            Todo todo = p.adminTodos[index];
            return myTodo(todo);
          }),
        );
      }
    });
  }

  Widget myTodo(Todo todo) {
    return GestureDetector(
      onTap: () async {
        await Get.bottomSheet(ChangeTodoStatus(
          todo: todo,
        ));
        setState(() {});
      },
      child: Padding(
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
                  color: todo.isChecked
                      ? AppConfig.colors.themeBlue
                      : Colors.white,
                  border: Border.all(
                    width: 1.0,
                    color: const Color(0xFF0022FF),
                  ),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: todo.isChecked
                        ? AppConfig.colors.themeBlue
                        : Colors.white,
                  ),
                ),
              ),
              Spacer(flex: 13),
              Text(
                todo.name ?? "",
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
      ),
    );
  }
}
