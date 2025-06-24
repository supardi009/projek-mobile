import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatelessWidget {
  const MapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    if (kIsWeb) {
      return Scaffold(
        appBar: AppBar(title: Text("Google Map")),
        body: Center(
          child: Text("Google Maps tidak didukung di platform Web."),
        ),
      );
    }

    return const _MapNativeScreen();
  }
}

class _MapNativeScreen extends StatefulWidget {
  const _MapNativeScreen({super.key});

  @override
  State<_MapNativeScreen> createState() => _MapNativeScreenState();
}

class _MapNativeScreenState extends State<_MapNativeScreen> {
  late GoogleMapController _mapController;
  final LatLng _initialPosition = LatLng(-6.200000, 106.816666); // Jakarta

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Google Map")),
      body: GoogleMap(
        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(
          target: _initialPosition,
          zoom: 12,
        ),
        markers: {
          Marker(
            markerId: MarkerId('jakarta'),
            position: _initialPosition,
            infoWindow: InfoWindow(
              title: 'Jakarta',
              snippet: 'Ibukota Indonesia',
            ),
          ),
        },
      ),
    );
  }
}
