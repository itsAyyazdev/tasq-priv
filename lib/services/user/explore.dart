import 'package:tasq/models/job.dart';

abstract class ExplorePageServices {
  Future<List<Job>> getAllJobs();
}

class ExServices implements ExplorePageServices {
  @override
  Future<List<Job>> getAllJobs() {
    throw UnimplementedError();
  }
}
