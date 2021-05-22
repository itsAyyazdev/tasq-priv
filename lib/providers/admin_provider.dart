import 'package:flutter/cupertino.dart';
import 'package:tasq/models/job.dart';
import 'package:tasq/models/job_application.dart';
import 'package:tasq/models/reward_model.dart';
import 'package:tasq/models/todo.dart';
import 'package:tasq/services/admin/home.dart';
import 'package:tasq/utils/globals/import_hub.dart';

class AdminProvider extends ChangeNotifier {
  bool isLoading = false;
  HomeServices _homeServices = HS();
  List<JobApplication> activeTasks = [];
  List<Todo> adminTodos = [];
  StreamSubscription _activeTasksSub;

  onInit() {
    loadAllActiveTasks();
    loadMyTodos();
  }

  // get active assigned tasks
  void loadAllActiveTasks() async {
    startLoader();
    var value = await _homeServices.getAllActiveTasks();
    stopLoader();
    if (_activeTasksSub == null) {
      _activeTasksSub = value.listen((event) {
        activeTasks = event;
        notifyListeners();
      });
    }
  }

  void loadMyTodos() {
    // _homeServices.
  }
  void createTask({Job task}) {}

  void addReward(RewardModel m) {
    print("reward added");
  }

  startLoader() {
    isLoading = true;
    notifyListeners();
  }

  stopLoader() {
    isLoading = false;
    notifyListeners();
  }
}
