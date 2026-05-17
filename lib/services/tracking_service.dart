import 'package:dio/dio.dart';

import 'api_service.dart';

class TrackingService {
  final ApiService apiService = ApiService();

  Future<Map<String, dynamic>?> getWorkerLocation(int workerId) async {
    try {
      Response response = await apiService.dio.get(
        "/locations/worker/$workerId",
      );

      return response.data;
    } catch (e) {
      return null;
    }
  }
}
