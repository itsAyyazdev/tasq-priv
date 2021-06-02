import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tasq/models/job.dart';
import 'package:tasq/models/job_application.dart';
import 'package:tasq/utils/constants/firebase_collections.dart';
import 'package:tasq/utils/enums.dart';
import 'package:tasq/utils/globals/app_data/app_user.dart';
import 'package:tasq/utils/globals/import_hub.dart';

abstract class ExplorePageServices {
  Future<List<Job>> getAllJobs();
  Future<void> applyForTask({JobApplication application});
}

class ExServices implements ExplorePageServices {
  FirebaseFirestore db = FirebaseFirestore.instance;
  @override
  Future<List<Job>> getAllJobs() async {
    Query query = FBCollections.jobs;
    // query = query.where("org_id", isEqualTo: AppUser.user.orgId);
    QuerySnapshot jobsSnap = await query.get();
    List<Job> jobs = [];
    jobsSnap.docs.forEach((job) {
      Job myJob = Job.fromJson(job.data());
      if (myJob.assignType == Enums.task.everyOne ||
          (myJob.assignType == Enums.task.organization &&
              (myJob.orgId == AppUser.user.orgId)) ||
          (myJob.assignType == Enums.task.team &&
              myJob.assignToId == AppUser.user.email)) {
        jobs.add(myJob);
      }
    });
    return Future.value(jobs);
  }

  @override
  Future<void> applyForTask({JobApplication application}) async {
    String docId = AppUtils.getFreshTimeStamp();
    DocumentReference docRef = FBCollections.jobApplications.doc(docId);
    application.appliedAt = Timestamp.now();
    db.runTransaction((trx) async => trx.set(docRef, application.toJson()));
  }
}
