import 'package:tasq/models/job.dart';
import 'package:tasq/models/job_application.dart';

abstract class UserHomeServices {
  Future<List<JobApplication>> fetchMyActiveTasks();
  Future<Stream<List<Job>>> getAllJobs();
}

class HomeServices implements UserHomeServices {
  @override
  Future<List<JobApplication>> fetchMyActiveTasks() {
    // TODO: implement fetchMyActiveTasks
    throw UnimplementedError();
  }

  @override
  Future<Stream<List<Job>>> getAllJobs() {
    // TODO: implement getAllJobs
    throw UnimplementedError();
  }
}
