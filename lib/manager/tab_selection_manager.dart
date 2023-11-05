import 'package:flutter/cupertino.dart';

class TabSelectionManager extends ChangeNotifier {
  int _tabIndex = 0;
  int get tabIndex => _tabIndex;

  void updateIndex(int newIndex) {
    _tabIndex = newIndex;
    notifyListeners();
  }
}
