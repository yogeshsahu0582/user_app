import 'package:flutter/material.dart';

import 'package:dio/dio.dart';

import '../services/api_service.dart';

class BookingProvider extends ChangeNotifier {
  final ApiService apiService = ApiService();

  String bookingStatus = "pending";

  Future<void> getBookingStatus(int bookingId) async {
    try {
      Response response = await apiService.dio.get(
        "/bookings/status/$bookingId",
      );

      bookingStatus = response.data["status"];

      notifyListeners();
    } catch (e) {
      bookingStatus = "error";

      notifyListeners();
    }
  }
}
