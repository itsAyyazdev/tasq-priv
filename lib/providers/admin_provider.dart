import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:tasq/models/job.dart';
import 'package:tasq/models/job_application.dart';
import 'package:tasq/models/org_member.dart';
import 'package:tasq/models/reward_model.dart';
import 'package:tasq/models/todo.dart';
import 'package:tasq/models/user.dart';
import 'package:tasq/services/admin/Prefs.dart';
import 'package:tasq/services/admin/home.dart';
import 'package:tasq/services/admin/profile.dart';
import 'package:tasq/services/admin/rewards.dart';
import 'package:tasq/ui/admin/dashboard/me/OrgTeams.dart';
import 'package:tasq/utils/constants/firebase_collections.dart';
import 'package:tasq/utils/enums.dart';
import 'package:tasq/utils/globals/app_data/app_user.dart';
import 'package:tasq/utils/globals/import_hub.dart';

class AdminProvider extends ChangeNotifier {
  bool isLoading = false;
  HomeServices _homeServices = HS();
  RewardsServices _rewardServices = RS();
  PrefServices _preferenceServices = PS();
  MyProfileServices _profileServices = MPS();
  List<Job> activeTasks = [];
  List<JobApplication> assignedTasks = [];
  List<Job> postedTasks = [];
  List<RewardModel> rewardList = [];
  List<RewardModel> exploreRewards = [];
  List<OrgMember> pendingRequests = [];
  List<OrgMember> myTeamMembers = [];
  List<Todo> adminTodos = [];
  StreamSubscription _activeTasksSub;
  StreamSubscription _rewardSub;
  StreamSubscription _preferenceSub;

  onInit() {
    loadAllActiveTasks();
    loadMyTodos();
    getRewards();
    // loadPendingPreferences();
    fetchAllMyToDos();
    getPendingRequests();
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

    _activeTasksSub = value.listen((event) {
      activeTasks = event;
    });

    print("task List ${rewardList.length}");
    notifyListeners();
  }

  void loadAllAssignedTasks() async {
    //Loads all tasks that are assigned and are currently in progress
    startLoader();
    var value = await _profileServices.getAllAssignedTasks();
    stopLoader();

    _activeTasksSub = value.listen((event) {
      assignedTasks = event;
    });

    print("task List ${rewardList.length}");
    notifyListeners();
  }

  Future<Job> getJobById(String id) async {
    DocumentSnapshot doc = await FBCollections.jobs.doc(id).get();
    Job job = Job.fromJson(doc.data());
    return Future.value(job);
  }

  void loadMyPostings() async {
    startLoader();
    List<Job> posted = await _profileServices.getMyPostedTasks();
    postedTasks = [];
    postedTasks.addAll(posted);
    stopLoader();
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

  Future<void> addToMyRewards(RewardModel r) async {
    //to add other organizations rewards to my rewards
    // check if the reward is already added to my rewards
    if (rewardList
        .where((element) => element.rewardId == r.rewardId)
        .isNotEmpty) {
      return AppUtils.showSnackbar(
          msg: "Reward is already added", isError: true);
    }
    startLoader();
    await _rewardServices.addToMyRewards(reward: r);
    AppUtils.showSnackbar(msg: "Added to my rewards", isError: false);
    getRewards();
    stopLoader();
    Get.back();
  }

  Future<List<JobApplication>> getApplicationsByJobId(
      {@required String jobId}) async {
    List<JobApplication> application =
        await _profileServices.getApplicationsByJob(jobId);
    return application;
  }

  void assignFromTeam(Job job) async {
    UserData userData = await Get.to(OrgTeams(),
        curve: AppUtils.pageCurve, transition: AppUtils.pageTransition);
    if (userData != null) {
      job.assignType = Enums.task.team;
      job.isActive = true;
      job.assignToId = userData.email;
      job.status = Enums.task.team;
      job.assignTo =
          AssignTo(name: userData.name, proposal: "", applicationId: "");
      await _profileServices.assignTask(job: job);
      Get.back();
      loadMyPostings();
      loadAllActiveTasks();
    } else {
      AppUtils.showSnackbar(msg: "No member selected", isError: true);
    }
  }

  void assignToApplicant(
      Job job, JobApplication application, UserData user) async {
    job.assignType = Enums.task.everyOne;
    job.isActive = true;
    job.assignToId = user.email;
    job.status = Enums.task.everyOne;
    job.assignTo = AssignTo(
        name: user.name,
        proposal: application.proposal?.proposal ?? "",
        applicationId: "");
    await _profileServices.assignTask(job: job);
    Get.back();
    loadMyPostings();
    loadAllActiveTasks();
  }

  void getRewards() async {
    //fetch all the rewards that are posted by any organization
    //as well as my organization.
    print("getRewards");
    rewardList = [];
    exploreRewards = [];
    startLoader();
    var value = await _rewardServices.fetchAllRewards();
    stopLoader();
    _rewardSub = value.listen((event) {
      List<RewardModel> allRewards = event;
      rewardList = allRewards
          .where((element) => element.orgId == AppUser.organization.orgId)
          .toList();
      exploreRewards = allRewards
          .where((element) => element.orgId != AppUser.organization.orgId)
          .toList();
      notifyListeners();
      print("Reward List ${rewardList.length}");
    });

    notifyListeners();
  }

  // void loadPendingPreferences() async {
  //   startLoader();
  //   var value = await _preferenceServices.getAllPendingRequest();
  //   stopLoader();
  //
  //   _preferenceSub = value.listen((event) {
  //     pendingRequests = event;
  //     print("pending request List ${pendingRequests?.length ?? 0}");
  //   });
  //
  //   notifyListeners();
  // }

  void getPendingRequests() async {
    startLoader();
    pendingRequests = await _preferenceServices.getPendingRequests();
    stopLoader();
  }

  void getOrgTeam() async {
    startLoader();
    myTeamMembers = await _preferenceServices.getOrgTeam();
    stopLoader();
  }

  void acceptRequest(String requestId) async {
    try {
      startLoader();
      await _preferenceServices.updateRequestStatus(
          requestId, Enums.orgRequest.accepted);
      getPendingRequests();
      startLoader();
    } catch (e) {
      startLoader();
      print(e.toString());
    }
  }

  void rejectRequest(String requestId) async {
    try {
      startLoader();
      await _preferenceServices.updateRequestStatus(
          requestId, Enums.orgRequest.rejected);
      getPendingRequests();
      startLoader();
    } catch (e) {
      startLoader();
      print(e.toString());
    }
  }

// add todDos for admin
  void addTodo({Todo todo}) async {
    try {
      startLoader();
      await _homeServices.addTodo(todo: todo);
      fetchAllMyToDos();
      stopLoader();
      Get.back();
    } catch (e) {
      stopLoader();
      AppUtils.showSnackbar(msg: e.toString(), isError: true);
    }
  }

  void fetchAllMyToDos() async {
    try {
      startLoader();
      adminTodos = await _homeServices.getMyTodos();
      stopLoader();
    } catch (e) {
      stopLoader();
      AppUtils.showSnackbar(msg: e.toString(), isError: true);
    }
  }

  void updateTodo(String id) async {
    try {
      startLoader();
      await _homeServices.updateTodo(id: id);
      fetchAllMyToDos();
      Get.back();
      stopLoader();
    } catch (e) {
      stopLoader();
      AppUtils.showSnackbar(msg: e.toString(), isError: true);
    }
  }

  void deletedTodo(String id) async {
    try {
      startLoader();
      await _homeServices.deleteTodo(id: id);
      fetchAllMyToDos();
      Get.back();
      stopLoader();
    } catch (e) {
      stopLoader();
      AppUtils.showSnackbar(msg: e.toString(), isError: true);
    }
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
