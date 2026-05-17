import 'package:flutter/material.dart';

import 'package:dio/dio.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../services/api_service.dart';

class AuthProvider extends ChangeNotifier {
  final ApiService apiService = ApiService();

  bool isLoading = false;

  Future<bool> userLogin(String phone) async {
    try {
      isLoading = true;

      notifyListeners();

      Response response = await apiService.dio.post(
        "/auth/user-login",
        data: {"phone": phone},
      );

      String token = response.data["access_token"];

      SharedPreferences prefs = await SharedPreferences.getInstance();

      await prefs.setString("token", token);

      isLoading = false;

      notifyListeners();

      return true;
    } catch (e) {
      isLoading = false;

      notifyListeners();

      return false;
    }
  }
}
