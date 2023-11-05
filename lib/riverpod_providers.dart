import 'package:cross_flutter_application/manager/login_form_manager.dart';
import 'package:cross_flutter_application/manager/tab_selection_manager.dart';
import 'package:cross_flutter_application/manager/vehicle_form_manager.dart';
import 'package:cross_flutter_application/repositories/user_repository.dart';
import 'package:cross_flutter_application/repositories/vehicle_repository.dart';
import 'package:cross_flutter_application/services/map_controller_service.dart';
import 'package:cross_flutter_application/services/marker_icon_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:package_info_plus/package_info_plus.dart';

/// Creation of provider instances
///
/// Unimplemented providers are injected in the main to await for initialization
///

// UI
final tabSelectionManagerNotifierProvider =
    ChangeNotifierProvider<TabSelectionManager>((ref) => TabSelectionManager());
final vehicleFormManagerProvider =
    Provider<VehicleFormManager>((ref) => VehicleFormManager());
final loginFormManagerNotifierProvider =
    ChangeNotifierProvider<LoginFormManager>((ref) => LoginFormManager());

// Device Specific
final appVersionFutureProvider = FutureProvider<String>((ref) async {
  final packageInfo = await PackageInfo.fromPlatform();
  return packageInfo.version;
});
final locationStreamProvider =
    StreamProvider.autoDispose<Position>((ref) async* {
  await for (var position in Geolocator.getPositionStream()) {
    yield position;
  }
});

// Repositories
final vehicleRepositoryNotifierProvider =
    ChangeNotifierProvider<VehicleRepository>((ref) => VehicleRepository());
final userRepositoryNotifierProvider =
    ChangeNotifierProvider<UserRepository>((ref) => throw UnimplementedError());

// Services
final markerIconServiceProvider =
    Provider<MarkerIconService>((ref) => throw UnimplementedError());
final mapControllerServiceNotifierProvider =
    ChangeNotifierProvider<MapControllerService>(
        (ref) => MapControllerService());
