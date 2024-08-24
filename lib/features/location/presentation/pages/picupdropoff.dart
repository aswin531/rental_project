import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rentit/features/location/presentation/bloc/location_bloc.dart';
import 'package:rentit/features/location/presentation/bloc/location_event.dart';
import 'package:rentit/features/location/presentation/bloc/location_state.dart';

class LocationMapTestWidget extends StatefulWidget {
  const LocationMapTestWidget({super.key});

  @override
  State<LocationMapTestWidget> createState() => _LocationMapTestWidgetState();
}

class _LocationMapTestWidgetState extends State<LocationMapTestWidget> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ));
    return BlocBuilder<LocationMapBloc, LocationMapState>(
        builder: (context, state) {
      print(
          "Building map with state: ${state.cameraPosition.target.latitude}, ${state.cameraPosition.target.longitude}");

      // final LatLng cameraTarget = state.cameraPosition.target;
      // final Marker marker = Marker(
      //   markerId: const MarkerId('currentLocationMarker'),
      //   position: cameraTarget,
      //   infoWindow: const InfoWindow(title: 'Current Location'),

      return Stack(
        children: [
          GoogleMap(
            key: ValueKey(
                "${state.cameraPosition.target.latitude},${state.cameraPosition.target.longitude}"),
            padding: const EdgeInsets.only(top: 26, bottom: 0),
            mapType: MapType.normal,
            initialCameraPosition: state.cameraPosition,
            onMapCreated: (GoogleMapController mapController) {
              context.read<LocationMapBloc>().add(InitializeMap(mapController));
            },
            markers: {
              Marker(
                markerId: const MarkerId('currentLocation'),
                position: state.cameraPosition.target,
                infoWindow: const InfoWindow(title: 'Current Location'),
              ),
            },
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
          ),
          Positioned(
            bottom: 16,
            left: 16,
            right: 16,
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                state.currentAddress ?? "Fetching address...",
                style: const TextStyle(fontSize: 16),
              ),
            ),
          ),
        ],
      );
    });
  }
}
