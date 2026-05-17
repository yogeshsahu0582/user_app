import 'package:flutter/material.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:geolocator/geolocator.dart';

class MapHomeScreen extends StatefulWidget {
  const MapHomeScreen({super.key});

  @override
  State<MapHomeScreen> createState() => _MapHomeScreenState();
}

class _MapHomeScreenState extends State<MapHomeScreen> {
  GoogleMapController? mapController;

  LatLng currentPosition = const LatLng(21.9000, 77.9000);

  final Set<Marker> markers = {};

  @override
  void initState() {
    super.initState();

    getCurrentLocation();
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

      markers.add(
        Marker(
          markerId: const MarkerId("user"),

          position: currentPosition,

          infoWindow: const InfoWindow(title: "You"),
        ),
      );

      markers.add(
        const Marker(
          markerId: MarkerId("worker1"),

          position: LatLng(21.9100, 77.9050),

          infoWindow: InfoWindow(title: "PA Worker"),
        ),
      );
    });
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
                "Find Nearby PA Workers",

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
                    "Need Help?",

                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 15),

                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF6FE7DD),

                      minimumSize: const Size(double.infinity, 55),
                    ),

                    onPressed: () {},

                    child: const Text("Book PA Worker"),
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
