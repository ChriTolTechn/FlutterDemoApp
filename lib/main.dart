import 'package:cross_flutter_application/mainWidgets/login_page_widget.dart';
import 'package:cross_flutter_application/models/User.dart';
import 'package:cross_flutter_application/models/Vehicle.dart';
import 'package:cross_flutter_application/repositories/user_repository.dart';
import 'package:cross_flutter_application/riverpod_providers.dart';
import 'package:cross_flutter_application/services/marker_icon_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

Future<void> main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  // Hive init
  await Hive.initFlutter();
  Hive.registerAdapter(VehicleTypeAdapter());
  Hive.registerAdapter(VehicleAdapter());
  Hive.registerAdapter(UserAdapter());

  // Repo creation
  final userRepo = UserRepository();

  // Service creation
  final markerIconService = MarkerIconService();

  await Future.wait([
    userRepo.initialize(),
    markerIconService.initialize(),
  ]);

  runApp(
    ProviderScope(
      overrides: [
        markerIconServiceProvider.overrideWith((ref) => markerIconService),
        userRepositoryNotifierProvider.overrideWith((ref) => userRepo)
      ],
      child: const MyApp(),
    ),
  );

  FlutterNativeSplash.remove();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'CrossApp',
        theme: ThemeData(
          brightness: Brightness.light,
          colorScheme: ColorScheme.fromSeed(
              seedColor: Colors.blue, brightness: Brightness.light),
        ),
        darkTheme: ThemeData(
          brightness: Brightness.dark,
          colorScheme: ColorScheme.fromSeed(
              seedColor: Colors.deepPurple, brightness: Brightness.dark),
        ),
        themeMode: ThemeMode.system,
        home: const LoginPage());
  }
}
