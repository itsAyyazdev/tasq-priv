import 'package:flutter/cupertino.dart';

class UserProvider extends ChangeNotifier {
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
