import 'package:cross_flutter_application/mainWidgets/profile_page_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../riverpod_providers.dart';
import 'about_page_widget.dart';
import 'home_page_widget.dart';
import 'map_page_widget.dart';

class MainPage extends ConsumerWidget {
  const MainPage({super.key, required this.username});

  final String username;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedTabState = ref.watch(tabSelectionManagerNotifierProvider);

    return Scaffold(
      body: IndexedStack(
          index: selectedTabState.tabIndex,
          children: const [HomePage(), MapPage(), ProfilePage(), AboutPage()]),
      bottomNavigationBar: NavigationBar(
        selectedIndex: selectedTabState.tabIndex,
        onDestinationSelected: (int index) {
          selectedTabState.updateIndex(index);
        },
        destinations: const <NavigationDestination>[
          NavigationDestination(
            selectedIcon: Icon(Icons.home),
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.map),
            icon: Icon(Icons.map_outlined),
            label: 'Map',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.person),
            icon: Icon(Icons.person_outlined),
            label: 'Profile',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.info),
            icon: Icon(Icons.info_outlined),
            label: 'About',
          ),
        ],
      ),
    );
  }
}
