import 'package:flutter/cupertino.dart';
import 'package:tasq/models/job.dart';
import 'package:tasq/models/job_application.dart';
import 'package:tasq/models/org_member.dart';
import 'package:tasq/models/reward_model.dart';
import 'package:tasq/models/todo.dart';
import 'package:tasq/services/admin/Prefs.dart';
import 'package:tasq/services/admin/home.dart';
import 'package:tasq/services/admin/rewards.dart';
import 'package:tasq/utils/globals/import_hub.dart';

class AdminProvider extends ChangeNotifier {
  bool isLoading = false;
  HomeServices _homeServices = HS();
  RewardsServices _rewardServices = RS();
  PrefServices _preferenceServices = PS();
  List<JobApplication> activeTasks = [];
  List<RewardModel> rewardList = [];
  List<OrgMember> ordMemberList = [];
  List<Todo> adminTodos = [];
  StreamSubscription _activeTasksSub;
  StreamSubscription _rewardSub;
  StreamSubscription _preferenceSub;

  onInit() {
    loadAllActiveTasks();
    loadMyTodos();
    getRewards();
    loadPendingPreferences();
    single();
  }

  // get active assigned tasks
  Future<void> createTask({Job task}) async {
    print("createTask");
    print("${task.toJson()}");
    startLoader();
    await _homeServices.postTasQ(task: task);
    stopLoader();
    AppRoutes.makeFirst(Get.context, OrgDashboard());
  }

  void loadAllActiveTasks() async {
    startLoader();
    var value = await _homeServices.getAllActiveTasks();
    stopLoader();
    if (_activeTasksSub == null) {
      _activeTasksSub = value.listen((event) {
        activeTasks = event;
      });
    }
    print("task List ${rewardList.length}");
    notifyListeners();
  }

  void loadMyTodos() {
    // _homeServices.
  }

  Future<void> addReward(RewardModel r) async {
    print("enter");
    startLoader();
    await _rewardServices.postReward(reward: r);
    stopLoader();
    Get.back();
  }

  void getRewards() async {
    print("getRewards");
    rewardList = [];
    startLoader();
    var value = await _rewardServices.fetchAllRewards();
    stopLoader();
    if (_rewardSub == null) {
      _rewardSub = value.listen((event) {
        rewardList = event;
        print("Reward List ${rewardList.length}");
      });
    }
    notifyListeners();
  }

  void loadPendingPreferences() async {
    ordMemberList = [];
    startLoader();
    var value = await _preferenceServices.getAllPendingRequest();
    stopLoader();
    if (_preferenceSub == null) {
      _preferenceSub = value.listen((event) {
        ordMemberList = event;
        print("pending request List ${ordMemberList?.length ?? 0}");
      });
    }

    notifyListeners();
  }

  void single() {
    _preferenceServices.singleReq();
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
    _preferenceSub?.cancel();
    _preferenceSub = null;
  }
}
