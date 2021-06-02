import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tasq/models/job.dart';
import 'package:tasq/models/job_application.dart';
import 'package:tasq/utils/constants/firebase_collections.dart';
import 'package:tasq/utils/globals/app_data/app_user.dart';

abstract class UserProfileServices {
  // fetch all jobs that i've applied and filter the lists according to status
  // to reduce the firebase calls
  Future<List<JobApplication>> fetchMyAppliedJobs();
  Future<Job> getJobById(String jobId);
}

class UServices implements UserProfileServices {
  @override
  Future<List<JobApplication>> fetchMyAppliedJobs() async {
    Query query = FBCollections.jobApplications;
    DocumentReference documentReference =
        FBCollections.users.doc(AppUser.user.email);
    query = query.where("applicant", isEqualTo: documentReference);
    QuerySnapshot _jobsSnap = await query.get();
    List<JobApplication> myJobs = [];
    _jobsSnap.docs.forEach((job) {
      myJobs.add(JobApplication.fromJson(job.data()));
    });
    return Future.value(myJobs);
  }

  @override
  Future<Job> getJobById(String jobId) async {
    DocumentReference query = FBCollections.jobs.doc(jobId);
    DocumentSnapshot doc = await query.get();
    Job job = Job.fromJson(doc.data());
    return job;
  }
}
