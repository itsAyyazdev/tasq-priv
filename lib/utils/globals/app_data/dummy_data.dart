import 'package:tasq/models/post_model.dart';
import 'package:tasq/models/reward_model.dart';
import 'package:tasq/models/user.dart';
import 'package:tasq/utils/globals/app_data/app_data.dart';
import 'package:tasq/utils/globals/import_hub.dart';

class DummyData {
  static List<RewardModel> rewards = [
    RewardModel(
        name: "\$100 worth of Apple Store Credit",
        voucher: "asdgavd5et",
        companyName: "Apple Inc.",
        description:
            "This is a dummy description of the reward which will be displayed on the card later",
        companyLogo: "",
        rewardId: "id",
        orgId: "id"),
    RewardModel(
        name: "A free Latte at Starbucks",
        voucher: "asdgfasdva",
        companyName: "Starbucks Inc.",
        description:
            "This is a dummy description of the reward which will be displayed on the card later",
        companyLogo: "",
        rewardId: "id",
        orgId: ""),
    RewardModel(
        name: "Rs.100 of on your new Boats earphones",
        voucher: "sdgasdfadfga",
        companyName: "Boat Lifestyle Pvt. Ltd.",
        description:
            "This is a dummy description of the reward which will be displayed on the card later",
        companyLogo: "",
        rewardId: "id",
        orgId: ""),
  ];

  static List<UserData> dummyUsers = [
    UserData(name: "Alex Reyli", imageUrl: AppData.dummyUser, uid: ""),
    UserData(name: "Neil Pesky", imageUrl: AppData.userImage, uid: ""),
    UserData(name: "Ibram p.", imageUrl: AppData.dummyUser, uid: ""),
    UserData(name: "Lucy Kris", imageUrl: AppData.userImage, uid: ""),
    UserData(name: "Tina Redis", imageUrl: AppData.dummyUser, uid: ""),
  ];

  static List<PostModel> posts = [
    PostModel(
        postName: "Web developer required",
        description:
            "We need a volunteer with Bootstrap and JavaScript skills to upgrade the YfS website to make it more user friendly on mobile devices. Interested volunteers may apply before the due date.",
        category: AppData.activityCategories[2],
        assignTo: "",
        dueDate: "28",
        rewardOffer: "500 worth of bocca coupens",
        rewardOfferId: "343",
        orgName: "YFS India",
        orgId: "srga",
        points: "230",
        createdAt: AppUtils.minAgoTime),
    PostModel(
        postName: "Web developer required",
        description:
            "We need a volunteer with Bootstrap and JavaScript skills to upgrade the YfS website to make it more user friendly on mobile devices. Interested volunteers may apply before the due date.",
        category: AppData.activityCategories[2],
        assignTo: "",
        dueDate: "28",
        rewardOffer: "500 worth of bocca coupens",
        rewardOfferId: "343",
        orgName: "YFS India",
        orgId: "srga",
        points: "230",
        createdAt: AppUtils.minAgoTime),
    PostModel(
        postName: "Web developer required",
        description:
            "We need a volunteer with Bootstrap and JavaScript skills to upgrade the YfS website to make it more user friendly on mobile devices. Interested volunteers may apply before the due date.",
        category: AppData.activityCategories[2],
        assignTo: "",
        dueDate: "28",
        rewardOffer: "500 worth of bocca coupens",
        rewardOfferId: "343",
        orgName: "YFS India",
        orgId: "srga",
        points: "230",
        createdAt: AppUtils.minAgoTime),
    PostModel(
        postName: "Web developer required",
        description:
            "We need a volunteer with Bootstrap and JavaScript skills to upgrade the YfS website to make it more user friendly on mobile devices. Interested volunteers may apply before the due date.",
        category: AppData.activityCategories[2],
        assignTo: "",
        dueDate: "28",
        rewardOffer: "500 worth of bocca coupens",
        rewardOfferId: "343",
        orgName: "YFS India",
        orgId: "srga",
        points: "230",
        createdAt: AppUtils.minAgoTime),
    PostModel(
        postName: "Web developer required",
        description:
            "We need a volunteer with Bootstrap and JavaScript skills to upgrade the YfS website to make it more user friendly on mobile devices. Interested volunteers may apply before the due date.",
        category: AppData.activityCategories[2],
        assignTo: "",
        dueDate: "28",
        rewardOffer: "500 worth of bocca coupens",
        rewardOfferId: "343",
        orgName: "YFS India",
        orgId: "srga",
        points: "230",
        createdAt: AppUtils.minAgoTime),
    PostModel(
        postName: "Web developer required",
        description:
            "We need a volunteer with Bootstrap and JavaScript skills to upgrade the YfS website to make it more user friendly on mobile devices. Interested volunteers may apply before the due date.",
        category: AppData.activityCategories[2],
        assignTo: "",
        dueDate: "28",
        rewardOffer: "500 worth of bocca coupens",
        rewardOfferId: "343",
        orgName: "YFS India",
        orgId: "srga",
        points: "230",
        createdAt: AppUtils.minAgoTime),
    PostModel(
        postName: "Web developer required",
        description:
            "We need a volunteer with Bootstrap and JavaScript skills to upgrade the YfS website to make it more user friendly on mobile devices. Interested volunteers may apply before the due date.",
        category: AppData.activityCategories[2],
        assignTo: "",
        dueDate: "28",
        rewardOffer: "500 worth of bocca coupens",
        rewardOfferId: "343",
        orgName: "YFS India",
        orgId: "srga",
        points: "230",
        createdAt: AppUtils.minAgoTime),
    PostModel(
        postName: "Web developer required",
        description:
            "We need a volunteer with Bootstrap and JavaScript skills to upgrade the YfS website to make it more user friendly on mobile devices. Interested volunteers may apply before the due date.",
        category: AppData.activityCategories[2],
        assignTo: "",
        dueDate: "28",
        rewardOffer: "500 worth of bocca coupens",
        rewardOfferId: "343",
        orgName: "YFS India",
        orgId: "srga",
        points: "230",
        createdAt: AppUtils.minAgoTime),
  ];
}
