class CoordinateHelper {
  static bool isValidLatitude(num? latitude) =>
      (latitude != null) && (latitude >= -90.0) && (latitude <= 90.0);

  static bool isValidLongitude(num? longitude) =>
      (longitude != null) && (longitude >= -180.0) && (longitude <= 180.0);
}
