import 'package:flutter/services.dart';


class LowerCaseText extends TextInputFormatter{
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    // TODO: implement formatEditUpdate
    return newValue.copyWith(text: newValue.text.toLowerCase());
  }
  
}

class UpperCaseText extends TextInputFormatter{
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    // TODO: implement formatEditUpdate
    return newValue.copyWith(text: newValue.text.toUpperCase());
  }

}