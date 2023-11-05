import 'dart:developer';

import 'package:collection/collection.dart';
import 'package:cross_flutter_application/helper/string_helper.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../models/User.dart';

class UserRepository extends ChangeNotifier {
  bool _initialized = false;
  String _activeUserName = "";

  Box<User>? _userBox;

  Iterable<User> get users => _userBox?.values ?? const Iterable.empty();
  String get getActiveUsername => _activeUserName;

  Future<void> initialize() async {
    if (_initialized) return;

    _userBox = await Hive.openBox<User>("users");
    log("User repo initialized");
    log("User count: ${_userBox?.values.length}");
    notifyListeners();

    _initialized = true;
  }

  User? getUser(String username) {
    return users.firstWhereOrNull(
        (user) => StringHelper.equalsIgnoreCase(username, user.username));
  }

  void addUser(User user) {
    _userBox?.add(user);
    user.save();
    notifyListeners();
  }

  void setActiveUsername(String username) {
    _activeUserName = username;
    notifyListeners();
  }
}
