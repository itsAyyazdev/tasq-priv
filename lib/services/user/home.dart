import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tasq/models/job.dart';
import 'package:tasq/models/job_application.dart';
import 'package:tasq/utils/constants/firebase_collections.dart';
import 'package:tasq/utils/enums.dart';
import 'package:tasq/utils/globals/app_data/app_user.dart';

abstract class UserHomeServices {
  Future<List<JobApplication>> fetchMyActiveTasks();
  Future<List<Job>> getAllJobs();
}

class HomeServices implements UserHomeServices {
  @override
  Future<List<JobApplication>> fetchMyActiveTasks() async {
    DocumentReference myDocRef = FBCollections.users.doc(AppUser.user.email);
    Query query = FBCollections.jobApplications;
    query = query.where("applicant", isEqualTo: myDocRef);
    QuerySnapshot taskSnap = await query.get();
    List<JobApplication> tasks = [];
    taskSnap.docs.forEach((tsk) {
      tasks.add(JobApplication.fromJson(tsk.data()));
    });
    return Future.value(tasks);
  }

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
}
