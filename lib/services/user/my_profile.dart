import 'package:tasq/models/job_application.dart';

abstract class UserProfileServices {
  // fetch all jobs that i've applied and filter the lists according to status
  // to reduce the firebase calls
  Future<List<JobApplication>> fetchAppliedJobs();
}

class UServices implements UserProfileServices {
  @override
  Future<List<JobApplication>> fetchAppliedJobs() {
    // TODO: implement fetchAppliedJobs
    throw UnimplementedError();
  }
}
