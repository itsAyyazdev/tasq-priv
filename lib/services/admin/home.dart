import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tasq/models/job.dart';
import 'package:tasq/models/job_application.dart';
import 'package:tasq/utils/constants/firebase_collections.dart';
import 'package:tasq/utils/enums.dart';
import 'package:tasq/utils/globals/app_data/app_user.dart';
import 'package:tasq/utils/globals/import_hub.dart';

abstract class HomeServices {
  Future<Stream<List<JobApplication>>> getAllActiveTasks();
  Future<List<Job>> getMyPostedTasks();
  Future<void> postTasQ({Job task});
}

class HS implements HomeServices {
  FirebaseFirestore db = FirebaseFirestore.instance;
  @override
  Future<Stream<List<JobApplication>>> getAllActiveTasks() async {
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
    if (querySnapshot.docs.isEmpty) {
      querySnapshot.docs.forEach((job) {
        jobs.add(Job.fromJson(job));
      });
    }
    return Future.value(jobs);
  }

  @override
  Future<void> postTasQ({Job task}) async {
    String docId = AppUtils.getFreshTimeStamp();
    DocumentReference docRef = FBCollections.jobs.doc(docId);
    task.jobId = docId;
    await db.runTransaction((trx) async => trx.set(docRef, task.toJson()));
  }
}
