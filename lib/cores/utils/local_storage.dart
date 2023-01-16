import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'logger.dart';

class LocalStorage {
  static final LocalStorage instance = LocalStorage._internal();
  LocalStorage._internal();
  factory LocalStorage() => instance;

  final FlutterSecureStorage storage = const FlutterSecureStorage();
  final loginDetailsKey = 'LoginDetailsKey';
  final lastSelectedStudentKey = 'lastLogin';

  Future<void> saveLoginDetails(String username, String password) async {
    try {
      final Map data = {'username': username, 'password': password};
      final String value = json.encode(data);

      await storage.write(key: loginDetailsKey, value: value);
    } catch (e, s) {
      LoggerHelper.log(e, s);
    }
  }

  Future<Map<String, dynamic>> getSavedUser() async {
    Map<String, dynamic> loginModel;

    try {
      final String? value = await storage.read(key: loginDetailsKey);

      if (value == null) {
        throw 'No User Was Found Or A change password operation was preform, Please Login With Email And Password';
      }

      final Map<String, dynamic> data = json.decode(value);

      loginModel = data;
    } catch (e) {
      throw e.toString();
    }

    return loginModel;
  }

  Future<String> getSavedUsername() async {
    try {
      final String? value = await storage.read(key: loginDetailsKey);

      if (value == null) return '';

      final Map<String, dynamic> data = json.decode(value);

      return data['username'];
    } catch (e) {
      return '';
    }
  }

  void clearLoginData() {}
}
