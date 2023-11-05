import 'package:cross_flutter_application/riverpod_providers.dart';
import 'package:cross_flutter_application/widgets/skill_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AboutPage extends ConsumerWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appVersion = ref.watch(appVersionFutureProvider);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        title: Text("About",
            style:
                TextStyle(color: Theme.of(context).colorScheme.onBackground)),
      ),
      body: Container(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
        child: Column(
          children: [
            appVersion.when(
              loading: () => const CircularProgressIndicator(),
              error: (error, stack) => Text('Error: $error'),
              data: (version) => Text('App version: $version'),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                const CircleAvatar(
                  radius: 48,
                  backgroundImage:
                      AssetImage('assets/images/profilePicture.png'),
                ),
                const SizedBox(width: 16),
                Text(
                  "John Doe",
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
              ],
            ),
            const SizedBox(height: 32),
            const SkillListWidget(),
          ],
        ),
      ),
    );
  }
}
