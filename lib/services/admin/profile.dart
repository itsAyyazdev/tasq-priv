import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tasq/models/job.dart';
import 'package:tasq/models/job_application.dart';
import 'package:tasq/utils/constants/firebase_collections.dart';
import 'package:tasq/utils/enums.dart';
import 'package:tasq/utils/globals/app_data/app_user.dart';
import 'package:tasq/utils/globals/import_hub.dart';

abstract class MyProfileServices {
  Future<Stream<List<JobApplication>>> getAllAssignedTasks();
  Future<List<Job>> getMyPostedTasks();
  Future<List<JobApplication>> getApplicationsByJob(String jobId);
  Future<void> assignTask({Job job});
}

class MPS implements MyProfileServices {
  FirebaseFirestore db = FirebaseFirestore.instance;
  @override
  Future<Stream<List<JobApplication>>> getAllAssignedTasks() async {
    var ref = FBCollections.jobApplications
        .where("org_id", isEqualTo: AppUser.organization.orgId)
        .where("status", isEqualTo: Enums.taskStatus.assigned)
        .snapshots()
        .asBroadcastStream();
    var x = ref.map((event) =>
        event.docs.map((e) => JobApplication.fromJson(e.data())).toList());
    return x;
  }

  @override
  Future<List<Job>> getMyPostedTasks() async {
    Query query = FBCollections.jobs
        .where("org_id", isEqualTo: AppUser.organization.orgId);
    QuerySnapshot querySnapshot = await query.get();
    List<Job> jobs = [];
    if (querySnapshot.docs.isNotEmpty) {
      querySnapshot.docs.forEach((job) {
        jobs.add(Job.fromJson(job));
      });
    }
    print("Jobs = ${jobs.length}");
    return Future.value(jobs);
  }

  @override
  Future<List<JobApplication>> getApplicationsByJob(String jobId) async {
    Query query = FBCollections.jobApplications;
    query = query.where("job_id", isEqualTo: jobId);
    QuerySnapshot taskSnap = await query.get();
    List<JobApplication> apps = [];
    taskSnap.docs.forEach((job) {
      apps.add(JobApplication.fromJson(job.data()));
    });
    return Future.value(apps);
  }

  @override
  Future<void> assignTask({Job job}) async {
    await FBCollections.jobs.doc(job.jobId).update(job.toJson());
  }
}
