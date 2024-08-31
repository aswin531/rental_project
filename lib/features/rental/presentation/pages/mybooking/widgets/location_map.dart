import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationMap extends StatelessWidget {
  const LocationMap({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(8.0),
      child: SizedBox(
        width: 250,
        height: 150,
        child: GoogleMap(
          initialCameraPosition: CameraPosition(
            target: LatLng(37.7749, -122.4194),
            zoom: 14.0,
          ),
        ),
      ),
    );
  }
}
