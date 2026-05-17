import 'package:dio/dio.dart';

import 'api_service.dart';

class BookingService {
  final ApiService apiService = ApiService();

  Future<List<dynamic>> getWorkers() async {
    Response response = await apiService.dio.get("/workers/nearby");

    return response.data;
  }

  Future<bool> createBooking({
    required int userId,
    required String serviceType,
  }) async {
    try {
      await apiService.dio.post(
        "/bookings/create",
        data: {"user_id": userId, "worker_id": 1, "service_type": serviceType},
      );

      return true;
    } catch (e) {
      return false;
    }
  }
}
