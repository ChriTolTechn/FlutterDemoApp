import 'package:cross_flutter_application/mainWidgets/login_page_widget.dart';
import 'package:cross_flutter_application/riverpod_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProfilePage extends ConsumerWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userRepo = ref.watch(userRepositoryNotifierProvider);

    void logout() {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const LoginPage()));
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        title: Text("Profile",
            style:
                TextStyle(color: Theme.of(context).colorScheme.onBackground)),
        actions: [
          IconButton(
              onPressed: logout,
              icon: Icon(
                Icons.logout,
                color: Theme.of(context).colorScheme.onBackground,
              ))
        ],
      ),
      body: Center(
        child: Text("Active user: ${userRepo.getActiveUsername}"),
      ),
    );
  }
}
