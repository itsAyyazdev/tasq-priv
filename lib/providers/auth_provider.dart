import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:tasq/models/organizationData.dart';
import 'package:tasq/services/auth_service.dart';
import 'package:tasq/services/firestorage_service.dart';
import 'package:tasq/services/firestore_services.dart';
import 'package:tasq/ui/shared/auth_page.dart';
import 'package:tasq/ui/shared/splash.dart';
import 'package:tasq/utils/constants/firebase_collections.dart';
import 'package:tasq/utils/enums.dart';
import 'package:tasq/utils/globals/app_data/app_user.dart';
import 'package:tasq/utils/globals/import_hub.dart';

import '../models/user.dart';
import '../ui/user/dashboard/user_navigator.dart';
import '../utils/app_routes.dart';

class AuthProvider extends ChangeNotifier {
  BaseAuth auth = Auth();
  AuthFSServices fs = CFS();
  bool isLoading = false;
  UserData userDataToSet = UserData();
  FStorageServices fStorage = FStorageServices();
  Organization orgToSet = Organization();
  List<Organization> allOrgaizations = [];
  File croppedFile;

  //check current user and navigate according to the user role
  Future<Widget> getInitialPage() {
    return Future.delayed(Duration(seconds: 1),
        () => SplashScreen()); // implement with current user
  }

// google sign-in
  void signInWithGoogle() async {
    // FBCollections.jobApplications.doc("please-font-change").get().then((value) {
    //   print("job Apps \n ${jsonEncode(value.data())}");
    // });
    // return;
    try {
      startLoader();
      User user = await auth.signInWithGoogle();
      stopLoader();
      print("user = ${user.email}");
      if (user != null) {
        navigateByRole(user);
      }
    } catch (e) {
      AppUtils.showSnackbar(msg: e.toString(), isError: true);
    }
  }

  void searchOrganization() async {
    startLoader();
    allOrgaizations = await fs.getAllOrganizations();
    stopLoader();
    AppRoutes.push(Get.context, SearchOrganization());
  }

  void navigateByRole(User user) async {
// read user data then check whether the user is already fully registered or not,
// and navigate according to the role.

    UserData userData = await fs.getUserById(user.email);

    if (userData == null) {
      userDataToSet = UserData(
        name: user.displayName,
        uid: user.uid,
        email: user.email,
        imageUrl: "",
      );

      AppRoutes.push(Get.context, RoleSelection());
    } else {
      AppUser.user = userData;
      if (userData.role == Enums.role.user) {
        AppRoutes.makeFirst(Get.context, UserDashboard());
      } else {
        await navigateToAdmin();
      }
    }
  }

  Future<void> navigateToAdmin() async {
    stopLoader();
    Organization org = await fs.getMyOrg();
    stopLoader();
    if (org == null || org.orgId == null) {
      AppRoutes.push(Get.context, CreateOrganization());
    } else {
      AppUser.organization = org;
      AppRoutes.makeFirst(Get.context, OrgDashboard());
    }
  }

  void createUserInDB(File cropped) async {
    if (cropped == null) {
      return AppUtils.showSnackbar(
          msg: "Please select a profile image", isError: true);
    }
    croppedFile = cropped;
    startLoader();
    String url = await fStorage.uploadSingleFile(
        bucketName: "User Images",
        file: cropped,
        userEmail: userDataToSet.email);
    startLoader();
    if (url != null) {
      userDataToSet.imageUrl = url;
      userDataToSet.orgId = orgToSet?.orgId ?? "";
      userDataToSet.isOrg = false;
      await registerUser();
      startLoader();
      AppUser.user = await fs.getUserById(userDataToSet.email);
      stopLoader();
      AppRoutes.push(Get.context, UserDashboard());
    } else {
      AppUtils.showSnackbar(
          msg: "There was a problem with file upload", isError: true);
    }
  }

  Future<void> registerUser() async {
    try {
      startLoader();
      userDataToSet.createdAt = Timestamp.now();
      await fs.setUserData(
          userEmail: userDataToSet.email, payload: userDataToSet.toJson());
      stopLoader();
    } catch (e) {
      stopLoader();
      AppUtils.showSnackbar(msg: e.toString(), isError: true);
    }
  }

  void registerOrg(String orgName, File cropped) async {
    if (cropped == null) {
      return AppUtils.showSnackbar(
          msg: "Please select an organization logo", isError: true);
    }
    croppedFile = cropped;
    startLoader();
    UserData userData = await fs.getUserById(userDataToSet.email);
    stopLoader();
    if (userData == null) {
      userDataToSet.isActive = true;
      registerUser();
    }
    // upload the image to firebase storage and return image url
    startLoader();
    String imageUrl = await fStorage.uploadSingleFile(
        bucketName: "Org Images",
        userEmail: userDataToSet.uid,
        file: croppedFile);
    stopLoader();
    // organization Id
    String timestamp = Timestamp.now().millisecondsSinceEpoch.toString();

    // adding current user to the team, as he's always be a member of that team,
    Member member =
        Member(name: userDataToSet.name, email: userDataToSet.email);

    Organization org = Organization(
      name: orgName,
      createdAt: Timestamp.now(),
      orgId: timestamp,
      logo: imageUrl,
      ownerId: userDataToSet.email,
      ownerName: userDataToSet.name,
      isActive: true,
      members: [member],
    );

    stopLoader();

    //register organization and add to firestore against this user,

    await FBCollections.organizations.doc(timestamp).set(org.toJson());
    croppedFile = null;
    stopLoader();
    //
    AppRoutes.push(Get.context, OrgInstructions());
  }

  Future<void> checkCurrentUser() async {
    startLoader();
    User user = await auth.getCurrentUser();
    stopLoader();
    if (user == null) {
      AppRoutes.makeFirst(Get.context, AuthPage());
    } else {
      navigateByRole(user);
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
}
