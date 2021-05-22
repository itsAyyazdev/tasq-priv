import 'package:tasq/ui/admin/admin_todos.dart';
import 'package:tasq/ui/admin/dashboard/me/active_tasks.dart';
import 'package:tasq/ui/widgets/admin/my_fab.dart';
import 'package:tasq/ui/widgets/shared/heading_tile.dart';
import 'package:tasq/utils/globals/import_hub.dart';

class AdminHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<AppProvider>(
        builder: (context, p, _) => Scaffold(
              floatingActionButton: MyFAB(
                text: "t+",
                onTap: () => AppRoutes.push(context, AddNewActivity()),
              ),
              body: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  children: [
                    AdminInfoCard(
                      isEdit: false,
                      isAdmin: true,
                    ),
                    HeadingTile(title: "manage tasks", buttonName: "see all"),
                    AdminActiveTasks(
                      maxLength: 2,
                    ),
                    HeadingTile(title: "my to-do", buttonName: "+add"),
                    AdminTodos(),
                  ],
                ),
              ),
            ));
  }
}
