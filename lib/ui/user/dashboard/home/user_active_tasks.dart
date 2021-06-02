import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tasq/models/job.dart';
import 'package:tasq/models/job_application.dart';
import 'package:tasq/ui/widgets/shared/empty_screen.dart';
import 'package:tasq/ui/widgets/shared/shimmers/job.dart';
import 'package:tasq/utils/globals/import_hub.dart';

class UserActiveTasks extends StatefulWidget {
  final int maxLength;
  UserActiveTasks({this.maxLength});
  @override
  _UserActiveTasksState createState() =>
      _UserActiveTasksState(maxLength: maxLength);
}

class _UserActiveTasksState extends State<UserActiveTasks> {
  final int maxLength;
  _UserActiveTasksState({this.maxLength});

  @override
  void initState() {
    UserProvider p = Provider.of<UserProvider>(context, listen: false);
    p.getHomeData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(builder: (context, p, _) {
      if (p.isLoading) {
        return JobShimmer();
      } else {
        int length =
            p.activeJobs.length > maxLength ? maxLength : p.activeJobs.length;
        if (p.activeJobs.isEmpty) {
          return EmptyScreen(
            msg: "No Active Tasks Found",
          );
        } else {
          return SingleChildScrollView(
            child: Column(
              children: List.generate(length, (index) {
                JobApplication active = p.activeJobs[index];
                return FutureBuilder(
                  future: active.jobRef.get(),
                  builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                    if (!snapshot.hasData) {
                      return JobShimmerCard();
                    } else {
                      Job job = Job.fromJson(snapshot.data.data());
                      return TaskWidget(
                        onTap: () {},
                        showActive: true,
                        post: job,
                        showAssignedTo: false,
                        showPoints: false,
                        showProposal: true,
                        showResponses: false,
                        application: active,
                      );
                    }
                  },
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
            children: List.generate(p.assignedTasks.length, (index) {
              JobApplication application = p.assignedTasks[index];
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: FutureBuilder(
                  future: p.getJobById(application.jobId),
                  builder: (context, AsyncSnapshot<Job> snapshot) {
                    return TaskWidget(
                      onTap: () {},
                      showPoints: true,
                      showResponses: true,
                      showActive: true,
                      showAssignedTo: true,
                      post: snapshot.data,
                    );
                  },
                ),
              );
            }),
          );
        }
      }
    });
  }
}
