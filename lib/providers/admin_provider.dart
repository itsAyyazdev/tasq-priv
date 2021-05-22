import 'package:flutter/cupertino.dart';
import 'package:tasq/models/job.dart';
import 'package:tasq/models/job_application.dart';
import 'package:tasq/models/reward_model.dart';
import 'package:tasq/models/todo.dart';
import 'package:tasq/services/admin/home.dart';
import 'package:tasq/services/admin/rewards.dart';
import 'package:tasq/utils/globals/import_hub.dart';

class AdminProvider extends ChangeNotifier {
  bool isLoading = false;
  HomeServices _homeServices = HS();
  RewardsServices _rewardServices = RS();
  List<JobApplication> activeTasks = [];
  List<RewardModel> rewardList = [];
  List<Todo> adminTodos = [];
  StreamSubscription _activeTasksSub;
  StreamSubscription _rewardSub;

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

  void getRewards() async {
    startLoader();
    var value = await _rewardServices.fetchAllRewards();
    stopLoader();
    if (_rewardSub == null) {
      _rewardSub = value.listen((event) {
        rewardList = event;
        print("Reward List ${rewardList.length}");
        notifyListeners();
      });
    }
  }

  void loadMyTodos() {
    // _homeServices.
  }
  Future<void> createTask({Job task}) async {
    startLoader();
    await _homeServices.postTasQ(task: task);
    stopLoader();
  }

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

  void onDispose() {
    _rewardSub?.cancel();
    _rewardSub = null;
    _activeTasksSub?.cancel();
    _activeTasksSub = null;
  }
}
