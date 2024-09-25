import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  final double latitude;
  final double longitude;

  MapScreen({Key? key, required this.latitude, required this.longitude})
      : super(key: key);

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late GoogleMapController mapController;
  late Marker marker;

  @override
  void initState() {
    super.initState();

    // Create the marker in initState
    marker = Marker(
      markerId: const MarkerId('YourMarkerID'),
      position: LatLng(widget.latitude, widget.longitude),
      infoWindow: const InfoWindow(
        title: 'Marker Title', // Add your title
        snippet: 'Marker Snippet', // Add your snippet
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        onMapCreated: (controller) {
          mapController = controller;
        },
        initialCameraPosition: CameraPosition(
          target: LatLng(widget.latitude, widget.longitude),
          zoom: 15.0, // You can adjust the initial zoom level
        ),
        markers: Set<Marker>.of([marker]), // Add the marker to the map
      ),
    );
  }
}
