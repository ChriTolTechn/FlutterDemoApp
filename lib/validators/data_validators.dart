import 'package:cross_flutter_application/helper/coordinate_helper.dart';

class DataValidators {
  static bool isValidLatitudeInput(String? input) {
    return input != null &&
        CoordinateHelper.isValidLatitude(num.tryParse(input));
  }

  static bool isValidLongitudeInput(String? input) {
    return input != null &&
        CoordinateHelper.isValidLongitude(num.tryParse(input));
  }

  static bool isValidName(String? input) {
    return input != null && input.isNotEmpty;
  }

  static bool isValidUsername(String? input) {
    return isValidName(input) && input!.length >= 3;
  }

  static bool isValidPasswordLength(int length) {
    return length >= 5;
  }
}
