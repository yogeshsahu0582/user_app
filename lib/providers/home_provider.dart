import 'package:flutter/material.dart';

import '../models/worker_model.dart';

import '../services/booking_service.dart';

class HomeProvider extends ChangeNotifier {
  final BookingService bookingService = BookingService();

  bool isLoading = false;

  List<WorkerModel> workers = [];

  Future<void> loadWorkers() async {
    isLoading = true;

    notifyListeners();

    try {
      List<dynamic> data = await bookingService.getWorkers();

      workers = data.map((worker) => WorkerModel.fromJson(worker)).toList();
    } catch (e) {
      workers = [];
    }

    isLoading = false;

    notifyListeners();
  }

  Future<bool> bookWorker({
    required int userId,
    required String serviceType,
  }) async {
    return await bookingService.createBooking(
      userId: userId,
      serviceType: serviceType,
    );
  }
}
