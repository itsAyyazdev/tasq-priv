import 'package:flutter/cupertino.dart';
import 'package:tasq/services/user/explore.dart';
import 'package:tasq/services/user/home.dart';
import 'package:tasq/services/user/my_profile.dart';
import 'package:tasq/services/user/prefs.dart';
import 'package:tasq/services/user/rewards.dart';

class UserProvider extends ChangeNotifier {
  //services
  UserHomeServices _homeServices = HomeServices();
  UserRewardsServices _rewardsServices = RewardsServices();
  ExplorePageServices _exploreServices = ExServices();
  UserPrefServices _prefServices = PrefServices();
  UserProfileServices _profileServices = UServices();

  bool isLoading = false;

  startLoader() {
    isLoading = true;
    notifyListeners();
  }

  stopLoader() {
    isLoading = false;
    notifyListeners();
  }
}
