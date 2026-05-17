import 'dart:async';

import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../../providers/booking_provider.dart';

class BookingStatusScreen extends StatefulWidget {
  final int bookingId;

  const BookingStatusScreen({super.key, required this.bookingId});

  @override
  State<BookingStatusScreen> createState() => _BookingStatusScreenState();
}

class _BookingStatusScreenState extends State<BookingStatusScreen> {
  Timer? timer;

  @override
  void initState() {
    super.initState();

    loadStatus();

    timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      loadStatus();
    });
  }

  void loadStatus() {
    Provider.of<BookingProvider>(
      context,
      listen: false,
    ).getBookingStatus(widget.bookingId);
  }

  @override
  void dispose() {
    timer?.cancel();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<BookingProvider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF6FE7DD),

        title: const Text("Booking Status"),
      ),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,

          children: [
            const Text("Current Status", style: TextStyle(fontSize: 20)),

            const SizedBox(height: 20),

            Text(
              provider.bookingStatus.toUpperCase(),

              style: const TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
