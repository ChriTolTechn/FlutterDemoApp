import 'package:hive/hive.dart'
    show
        BinaryReader,
        BinaryWriter,
        HiveField,
        HiveObject,
        HiveType,
        TypeAdapter;

part 'Vehicle.g.dart';

@HiveType(typeId: 0)
class Vehicle extends HiveObject {
  @HiveField(0)
  String uuid;

  @HiveField(1)
  String name;

  @HiveField(2)
  num longitude;

  @HiveField(3)
  num latitude;

  @HiveField(4)
  VehicleType vehicleType;

  Vehicle(
      this.uuid, this.name, this.longitude, this.latitude, this.vehicleType);
}

@HiveType(typeId: 1)
enum VehicleType {
  @HiveField(0)
  car,

  @HiveField(1)
  bike,

  @HiveField(2)
  truck,

  @HiveField(3)
  helicopter,

  @HiveField(4)
  plane
}
