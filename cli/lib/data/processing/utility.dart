import 'dart:convert';

class Utilities {
  static String jsonGlowUp(dynamic json) {
    var spaces = ' ' * 4;
    var encoder = JsonEncoder.withIndent(spaces);
    return encoder.convert(json);
  }
}