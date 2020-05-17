import 'package:lifecompassapp/constants.dart';

class FieldsValidator {
  static bool isValidPhoneNumber(String input) {
    final isNumeric = int.tryParse(input);
    return isNumeric != null &&
        input.length >= kMinDigitsInPhoneNumber &&
        input.length <= kMaxDigitsInPhoneNumber;
  }

  static bool isValidName(String value) {
    final fullName = value.split(' ');
    final result = value.isNotEmpty && fullName.length > 1;
    return result;
  }
}