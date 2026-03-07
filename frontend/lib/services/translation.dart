import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class TranslationService extends Translations {
  static final Map<String, Map<String, String>> _keys = {};

  static Future<void> init() async {
    _keys['en_US'] = await _loadJson('en_US');
    _keys['bn_BD'] = await _loadJson('bn_BD');
  }

  static Future<Map<String, String>> _loadJson(String code) async {
    final String response = await rootBundle.loadString(
      'assets/locale/$code.json',
    );
    final Map<String, dynamic> jsonMap = json.decode(response);
    final Map<String, String> flattenedMap = {};

    void flatten(String prefix, dynamic value) {
      if (value is Map) {
        value.forEach((key, value) {
          flatten(prefix.isEmpty ? key : '$prefix.$key', value);
        });
      } else {
        flattenedMap[prefix] = value.toString();
      }
    }

    flatten('', jsonMap);
    return flattenedMap;
  }

  @override
  Map<String, Map<String, String>> get keys => TranslationService._keys;
}
