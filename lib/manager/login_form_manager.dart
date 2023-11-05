import 'package:cross_flutter_application/helper/password_helper.dart';
import 'package:cross_flutter_application/validators/data_validators.dart';
import 'package:flutter/cupertino.dart';

import '../models/User.dart';

class LoginFormManager extends ChangeNotifier {
  String _username = "";
  String _passwordPlain = "";
  bool _isPasswordVisible = false;
  bool _isLoading = false;

  set setUsername(String username) => _username = username;
  set setPasswordPlain(String passwordPlain) => _passwordPlain = passwordPlain;
  set setIsLoading(bool isLoading) {
    _isLoading = isLoading;
    notifyListeners();
  }

  get getIsPasswordVisible => _isPasswordVisible;
  get getIsLoading => _isLoading;

  User getUserObject() {
    if (DataValidators.isValidUsername(_username) &&
        DataValidators.isValidPasswordLength(_passwordPlain.length)) {
      return User(
          _username, PasswordHelper.hashPassword(_passwordPlain, _username));
    }
    throw const FormatException("Invalid user data");
  }

  void switchPasswordVisibility() {
    _isPasswordVisible = !_isPasswordVisible;
    notifyListeners();
  }

  void resetData() {
    _username = "";
    _passwordPlain = "";
    _isPasswordVisible = false;
    _isLoading = false;

    notifyListeners();
  }
}
