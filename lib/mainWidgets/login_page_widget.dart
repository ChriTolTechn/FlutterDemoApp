import 'package:cross_flutter_application/helper/password_helper.dart';
import 'package:cross_flutter_application/mainWidgets/main_page_widget.dart';
import 'package:cross_flutter_application/riverpod_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../helper/toast_helper.dart';
import '../validators/data_validators.dart';

class LoginPage extends ConsumerWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loginFormManager = ref.watch(loginFormManagerNotifierProvider);
    final userRepo = ref.watch(userRepositoryNotifierProvider);
    final vehicleRepo = ref.watch(vehicleRepositoryNotifierProvider);

    void redirectToMainPage(String username) {
      loginFormManager.setIsLoading = true;

      userRepo.setActiveUsername(username);
      vehicleRepo.initialize("${username}_vehicles").then((value) {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => MainPage(username: username)));
        loginFormManager.resetData();
      });
    }

    void onLoginPressed() {
      try {
        var loginData = loginFormManager.getUserObject();
        var fetchedUserData = userRepo.getUser(loginData.username);

        if (fetchedUserData != null &&
            PasswordHelper.isCorrectPassword(
                loginData.passwordHash, fetchedUserData.passwordHash)) {
          ToastHelper.showSuccessToast(context, "Successfully logged in!");
          redirectToMainPage(loginData.username);
        } else {
          ToastHelper.showErrorToast(context, "Invalid credentials");
        }
      } on FormatException catch (ex) {
        ToastHelper.showErrorToast(context, ex.message);
      }
    }

    void onRegisterPressed() {
      try {
        var loginData = loginFormManager.getUserObject();
        var fetchedUserData = userRepo.getUser(loginData.username);

        if (fetchedUserData != null) {
          ToastHelper.showErrorToast(context,
              "User with username '${loginData.username}' does already exist!");
        } else {
          userRepo.addUser(loginData);
          ToastHelper.showSuccessToast(context, "Successfully registered!");
          redirectToMainPage(loginData.username);
        }
      } on FormatException catch (ex) {
        ToastHelper.showErrorToast(context, ex.message);
      }
    }

    return Scaffold(
        body: SafeArea(
            child: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Text("Login", style: Theme.of(context).textTheme.headlineLarge),
          const Spacer(),
          TextFormField(
            onChanged: (String newValue) =>
                loginFormManager.setUsername = newValue,
            validator: (String? value) => DataValidators.isValidUsername(value)
                ? null
                : "Name must be at least five characters",
            autovalidateMode: AutovalidateMode.onUserInteraction,
            readOnly: loginFormManager.getIsLoading,
            decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Enter username",
                labelText: "Username"),
          ),
          const SizedBox(height: 16),
          TextFormField(
            onChanged: (String newValue) =>
                loginFormManager.setPasswordPlain = newValue,
            validator: (String? value) =>
                DataValidators.isValidPasswordLength(value?.length ?? 0)
                    ? null
                    : "Password must be at least five characters",
            autovalidateMode: AutovalidateMode.onUserInteraction,
            obscureText: !loginFormManager.getIsPasswordVisible,
            readOnly: loginFormManager.getIsLoading,
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              hintText: "Enter password",
              labelText: "Password",
              suffixIcon: IconButton(
                icon: Icon(
                  loginFormManager.getIsPasswordVisible
                      ? Icons.visibility_off
                      : Icons.visibility,
                ),
                onPressed: () {
                  loginFormManager.switchPasswordVisibility();
                },
              ),
            ),
          ),
          const SizedBox(height: 64),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              minimumSize: const Size.fromHeight(48),
            ),
            onPressed: !loginFormManager.getIsLoading ? onLoginPressed : null,
            child: const Text('Login'),
          ),
          const SizedBox(height: 24),
          OutlinedButton(
            style: ElevatedButton.styleFrom(
              minimumSize: const Size.fromHeight(48),
            ),
            onPressed:
                !loginFormManager.getIsLoading ? onRegisterPressed : null,
            child: const Text('Register'),
          ),
          if (loginFormManager.getIsLoading)
            const CircularProgressIndicator(color: Colors.white),
          const Spacer()
        ],
      ),
    )));
  }
}
