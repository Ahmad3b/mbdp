import 'package:flutter/cupertino.dart';

class BusyProvider with ChangeNotifier {
  bool isBusy = false;
  bool get IsBusy => isBusy;
  set IsBusy(bool val) {
    this.isBusy = val;
    notifyListeners();
  }
}
