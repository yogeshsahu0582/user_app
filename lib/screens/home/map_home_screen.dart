import 'dart:async';

import 'package:flutter/material.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:geolocator/geolocator.dart';

import '../../services/tracking_service.dart';

class MapHomeScreen extends StatefulWidget {
  const MapHomeScreen({super.key});

  @override
  State<MapHomeScreen> createState() => _MapHomeScreenState();
}

class _MapHomeScreenState extends State<MapHomeScreen> {
  GoogleMapController? mapController;

  final TrackingService trackingService = TrackingService();

  LatLng currentPosition = const LatLng(21.9000, 77.9000);

  LatLng workerPosition = const LatLng(21.9100, 77.9050);

  final Set<Marker> markers = {};

  final Set<Polyline> polylines = {};

  Timer? liveTimer;

  @override
  void initState() {
    super.initState();

    initializeMap();
  }

  Future<void> initializeMap() async {
    await getCurrentLocation();

    await loadWorkerLocation();

    startLiveTracking();
  }

  Future<void> getCurrentLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      return;
    }

    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    Position position = await Geolocator.getCurrentPosition();

    setState(() {
      currentPosition = LatLng(position.latitude, position.longitude);
    });
  }

  Future<void> loadWorkerLocation() async {
    final data = await trackingService.getWorkerLocation(1);

    if (data != null && data["latitude"] != null) {
      setState(() {
        workerPosition = LatLng(data["latitude"], data["longitude"]);

        updateMarkers();

        updatePolyline();
      });
    }
  }

  void startLiveTracking() {
    liveTimer = Timer.periodic(const Duration(seconds: 5), (timer) async {
      await loadWorkerLocation();
    });
  }

  void updateMarkers() {
    markers.clear();

    markers.add(
      Marker(
        markerId: const MarkerId("user"),

        position: currentPosition,

        infoWindow: const InfoWindow(title: "You"),
      ),
    );

    markers.add(
      Marker(
        markerId: const MarkerId("worker"),

        position: workerPosition,

        infoWindow: const InfoWindow(title: "PA Worker"),
      ),
    );
  }

  void updatePolyline() {
    polylines.clear();

    polylines.add(
      Polyline(
        polylineId: const PolylineId("route"),

        points: [currentPosition, workerPosition],

        width: 5,

        color: Colors.blue,
      ),
    );
  }

  @override
  void dispose() {
    liveTimer?.cancel();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: CameraPosition(
              target: currentPosition,
              zoom: 14,
            ),

            markers: markers,

            polylines: polylines,

            myLocationEnabled: true,

            myLocationButtonEnabled: true,

            zoomControlsEnabled: false,

            onMapCreated: (controller) {
              mapController = controller;
            },
          ),

          Positioned(
            top: 50,
            left: 20,
            right: 20,

            child: Container(
              padding: const EdgeInsets.all(15),

              decoration: BoxDecoration(
                color: Colors.white,

                borderRadius: BorderRadius.circular(15),
              ),

              child: const Text(
                "Live Worker Tracking",

                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ),

          Positioned(
            bottom: 0,
            left: 0,
            right: 0,

            child: Container(
              padding: const EdgeInsets.all(20),

              decoration: const BoxDecoration(
                color: Colors.white,

                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25),

                  topRight: Radius.circular(25),
                ),
              ),

              child: Column(
                mainAxisSize: MainAxisSize.min,

                children: [
                  const Text(
                    "PA Worker Coming",

                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 15),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,

                    children: const [Text("Arrival Time"), Text("5 mins")],
                  ),

                  const SizedBox(height: 20),

                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF6FE7DD),

                      minimumSize: Size(double.infinity, 55),
                    ),

                    onPressed: () {},

                    child: const Text("Contact Worker"),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
