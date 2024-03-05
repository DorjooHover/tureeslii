import 'package:flutter/services.dart';

List<TextInputFormatter> onlyUnsignedNumbers([int length = 0]) {
  final disallowZero = FilteringTextInputFormatter.deny(
    RegExp(r'^0+'),
  );
  return [
    FilteringTextInputFormatter(RegExp("[0-9]"), allow: true),
    FilteringTextInputFormatter.digitsOnly,
    if (length != 0) LengthLimitingTextInputFormatter(1),
    TextInputFormatter.withFunction(
        (TextEditingValue oldValue, TextEditingValue newValue) {
      final newValueText = newValue.text;
      if (newValueText.length > 1 && newValueText[0].trim() == '0') {
        newValue = disallowZero.formatEditUpdate(oldValue, newValue);
        if (newValue.text.isEmpty) {
          return oldValue;
        }
      }
      if (newValueText.isNotEmpty) {
        return int.tryParse(newValueText) != null ? newValue : oldValue;
      }
      return newValue;
    })
  ];
}
