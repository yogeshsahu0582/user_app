import 'package:flutter/material.dart';

import '../../../worker_app/lib/services/socket_service.dart';

class BookingStatusScreen extends StatefulWidget {
  const BookingStatusScreen({super.key});

  @override
  State<BookingStatusScreen> createState() => _BookingStatusScreenState();
}

class _BookingStatusScreenState extends State<BookingStatusScreen> {
  final SocketService socketService = SocketService();

  String bookingStatus = "PENDING";

  @override
  void initState() {
    super.initState();

    listenSocket();
  }

  void listenSocket() {
    socketService.bookingStream.listen((data) {
      if (data["type"] == "booking_accepted") {
        setState(() {
          bookingStatus = "ACCEPTED";
        });
      }

      if (data["type"] == "booking_rejected") {
        setState(() {
          bookingStatus = "REJECTED";
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF6FE7DD),

        title: const Text("Booking Status"),
      ),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,

          children: [
            const Text(
              "Current Booking Status",

              style: TextStyle(fontSize: 20),
            ),

            const SizedBox(height: 20),

            Text(
              bookingStatus,

              style: const TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
