import 'package:flutter/services.dart';

class DecimalTextInputFormatter extends TextInputFormatter {
  final RegExp _decimalRegExp = RegExp(r'^\d*\.?\d*$');

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (_decimalRegExp.hasMatch(newValue.text)) {
      return newValue;
    } else {
      // If the input doesn't match the allowed format, return the old value.
      return oldValue;
    }
  }
}
