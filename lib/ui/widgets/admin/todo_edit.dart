import 'package:loading_overlay/loading_overlay.dart';
import 'package:tasq/models/todo.dart';
import 'package:tasq/utils/globals/import_hub.dart';

class ChangeTodoStatus extends StatelessWidget {
  final Todo todo;
  ChangeTodoStatus({@required this.todo});
  @override
  Widget build(BuildContext context) {
    return Consumer<AdminProvider>(
        builder: (context, p, _) => Material(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              child: LoadingOverlay(
                isLoading: p.isLoading,
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: Get.height * 0.05),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Center(
                        child: Text(
                          "Manage Todos",
                          style:
                              MyTextStyles.montsBold16.copyWith(fontSize: 18),
                        ),
                      ),
                      ListTile(
                        leading: Icon(
                          Icons.done_outline,
                          color: Colors.green,
                        ),
                        title: Text("Mark as done"),
                        onTap: () => p.updateTodo(todo.id),
                      ),
                      ListTile(
                        leading: Icon(
                          Icons.delete,
                          color: Colors.red,
                        ),
                        title: Text("Delete"),
                        onTap: () => p.deletedTodo(todo.id),
                      ),
                    ],
                  ),
                ),
              ),
            ));
  }
}
