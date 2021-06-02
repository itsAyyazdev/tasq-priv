import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:tasq/models/chat_room.dart';
import 'package:tasq/models/job.dart';
import 'package:tasq/models/job_application.dart';
import 'package:tasq/models/message.dart';
import 'package:tasq/models/reward_model.dart';
import 'package:tasq/models/reward_user.dart';
import 'package:tasq/services/firestore_services.dart';
import 'package:tasq/services/shared/chat_services.dart';
import 'package:tasq/services/user/explore.dart';
import 'package:tasq/services/user/home.dart';
import 'package:tasq/services/user/my_profile.dart';
import 'package:tasq/services/user/prefs.dart';
import 'package:tasq/services/user/rewards.dart';
import 'package:tasq/utils/constants/firebase_collections.dart';
import 'package:tasq/utils/enums.dart';
import 'package:tasq/utils/globals/app_data/app_user.dart';
import 'package:tasq/utils/globals/import_hub.dart';

class UserProvider extends ChangeNotifier {
  //services
  UserHomeServices _homeServices = HomeServices();
  UserRewardsServices _rewardsServices = RewardsServices();
  ExplorePageServices _exploreServices = ExServices();
  UserPrefServices _prefServices = PrefServices();
  UserProfileServices _profileServices = UServices();
  AuthFSServices fs = CFS();
  ChatServices _chatServices = CSs();

  // data objects to be used in corresponding classes
  List<JobApplication> appliedJobs = [];
  List<JobApplication> activeJobs = [];
  List<JobApplication> inProgressJobs = [];
  List<JobApplication> completedJobs = [];
  List<Job> openJobs = [];
  List<Job> exploreJobs = [];
  List<Job> endingSoonJobs = [];
  List<RewardUser> myRewards = [];
  List<RewardModel> exploreRewards = [];
  bool isLoading = false;
  StreamSubscription _allRewardsSub;

//fetch User data according to page
  void getHomeData() async {
    try {
      startLoader();
      activeJobs = await _homeServices.fetchMyActiveTasks();
      await _homeServices.getAllJobs();
      stopLoader();
    } catch (e) {
      stopLoader();
      print("error ${e.toString()}");
      AppUtils.showSnackbar(msg: e.toString(), isError: true);
    }
  }

  void getRewardsData() async {
    try {
      startLoader();
      myRewards = await _rewardsServices.getMyRewards();
      exploreRewards = await _rewardsServices.fetchAllRewards();
      print("Rewards = ${exploreRewards.length}");
      stopLoader();
    } catch (e) {
      stopLoader();
      print("error ${e.toString()}");
      AppUtils.showSnackbar(msg: e.toString(), isError: true);
    }
  }

  void redeemReward(RewardModel reward) async {
    //redeem reward and add to my rewards
    int myPoints = AppUser.user.points;
    if (myPoints < reward.points) {
      return AppUtils.showSnackbar(
          msg: "Not enough points to redeem", isError: true);
    }
    RewardUser ru = RewardUser(
      points: reward.points,
      userId: AppUser.user.email,
      reward: reward,
    );
    try {
      startLoader();
      await _rewardsServices.redeemReward(rewardUser: ru);
      await _rewardsServices.getMyRewards();
      Future.delayed(Duration(milliseconds: 500), () async {
        AppUser.user = await fs.getUserById(AppUser.user.email);
        notifyListeners();
      });
      AppUtils.showSnackbar(msg: "reward redeemed", isError: false);
      stopLoader();
    } catch (e) {
      stopLoader();
      AppUtils.showSnackbar(msg: e.toString(), isError: true);
    }
  }

  void getExploreData() async {
    try {
      startLoader();
      List<Job> jobs = await _exploreServices.getAllJobs();
      exploreJobs = [];
      exploreJobs.addAll(jobs);
      endingSoonJobs = jobs
          .where((job) =>
              job.expiry.toDate().difference(DateTime.now()).inDays < 5)
          .toList();
      print("all jobs = ${exploreJobs.length}");
      stopLoader();
    } catch (e) {
      stopLoader();
      print("error ${e.toString()}");
      AppUtils.showSnackbar(msg: e.toString(), isError: true);
    }
  }

  void applyForJob(Job job, String proposal) async {
    // apply for a task
    if (proposal.isEmpty) {
      return AppUtils.showSnackbar(
          msg: "Proposal can not be empty", isError: true);
    }
    DocumentReference myDocRef = FBCollections.users.doc(AppUser.user.email);
    DocumentReference jobRef = FBCollections.jobs.doc(job.jobId);
    JobApplication application = JobApplication(
        proposal: Proposal(proposal: proposal),
        status: Enums.taskApplication.applied,
        jobId: job.jobId,
        jobRef: jobRef,
        orgId: job.orgId,
        applicantName: AppUser.user.name,
        applicant: myDocRef);
    ChatRoom chatRoom = ChatRoom(
        unreadCount: 1,
        jobId: job.jobId,
        users: [job.postedBy, AppUser.user.email],
        createdBy: AppUser.user.email);
    Message msg = Message(
        msg: application.proposal.proposal,
        receiverId: job.postedBy,
        type: Enums.msgType.text,
        senderId: AppUser.user.email,
        seen: false);
    try {
      startLoader();
      ChatRoom room = await _chatServices.createChatRoom(room: chatRoom);
      application.roomId = chatRoom.roomId;
      await _exploreServices.applyForTask(application: application);
      msg.roomId = room.roomId;
      await _chatServices.sendMessage(msg: msg);
      AppRoutes.makeFirst(Get.context, UserDashboard());
      Future.delayed(Duration(seconds: 1), () {
        AppUtils.userPageController.animateToPage(4,
            duration: AppUtils.pageTrxDuration, curve: AppUtils.pageCurve);
      });
      stopLoader();
    } catch (e) {
      stopLoader();
      AppUtils.showSnackbar(msg: e.toString(), isError: true);
    }
  }

  void getPreferencesData() async {
    try {
      startLoader();
      // await _prefServices.();
      stopLoader();
    } catch (e) {
      stopLoader();
      print("error ${e.toString()}");
      AppUtils.showSnackbar(msg: e.toString(), isError: true);
    }
  }

  void getMyProfileData() async {
    try {
      startLoader();
      List<JobApplication> jobs = await _profileServices.fetchMyAppliedJobs();
      appliedJobs = jobs
          .where((job) => job.status == Enums.taskApplication.applied)
          .toList();
      inProgressJobs = jobs
          .where((job) => job.status == Enums.taskApplication.inProgress)
          .toList();
      completedJobs = jobs
          .where((job) => job.status == Enums.taskApplication.completed)
          .toList();
      stopLoader();
    } catch (e) {
      stopLoader();
      print("error ${e.toString()}");
      AppUtils.showSnackbar(msg: e.toString(), isError: true);
    }
  }

  Future<Job> getJobById(String jobId) async {
    return _profileServices.getJobById(jobId);
  }

  onDispose() {
    _allRewardsSub.cancel();
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
