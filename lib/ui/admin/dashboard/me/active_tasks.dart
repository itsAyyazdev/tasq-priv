import 'package:tasq/models/job.dart';
import 'package:tasq/ui/widgets/shared/empty_screen.dart';
import 'package:tasq/ui/widgets/shared/shimmers/job.dart';
import 'package:tasq/utils/globals/import_hub.dart';

class AdminActiveTasks extends StatefulWidget {
  final int maxLength;
  AdminActiveTasks({this.maxLength});
  @override
  _AdminActiveTasksState createState() =>
      _AdminActiveTasksState(maxLength: maxLength);
}

class _AdminActiveTasksState extends State<AdminActiveTasks> {
  final int maxLength;
  _AdminActiveTasksState({this.maxLength});

  @override
  void initState() {
    AdminProvider p = Provider.of<AdminProvider>(context, listen: false);
    p.onInit();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AdminProvider>(builder: (context, p, _) {
      if (p.isLoading) {
        return JobShimmer();
      } else {
        int length =
            p.activeTasks.length > maxLength ? maxLength : p.activeTasks.length;
        if (p.activeTasks.isEmpty) {
          return EmptyScreen(
            msg: "No Active Tasks Found",
          );
        } else {
          return SingleChildScrollView(
            child: Column(
              children: List.generate(length, (index) {
                Job active = p.activeTasks[index];
                return TaskWidget(
                  onTap: () {},
                  showActive: true,
                  post: active,
                  showAssignedTo: false,
                  showPoints: false,
                  showProposal: true,
                  showResponses: false,
                );
              }),
            ),
          );
        }
      }
    });
  }
}

class ActiveTaskProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<AdminProvider>(builder: (context, p, _) {
      if (p.isLoading) {
        return JobShimmer();
      } else {
        if (p.activeTasks.isEmpty) {
          return EmptyScreen(
            msg: "No Assigned Tasks",
          );
        } else {
          return ListView(
            children: List.generate(p.activeTasks.length, (index) {
              Job application = p.activeTasks[index];
              return TaskWidget(
                onTap: () {},
                showPoints: true,
                showResponses: false,
                showActive: true,
                showAssignedTo: true,
                post: application,
              );
            }),
          );
        }
      }
    });
  }
}
