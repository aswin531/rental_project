import 'dart:async';
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
  final Completer<GoogleMapController> googleMapCompleterController =
      Completer<GoogleMapController>();
  GoogleMapController? controllerGoogleMap;
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ));
    return BlocBuilder<LocationMapBloc, LocationMapState>(
      builder: (context, state) {
        debugPrint(state.cameraPosition.toString());
        return GoogleMap(
          padding: const EdgeInsets.only(top: 26, bottom: 0),
          mapType: MapType.normal,
          initialCameraPosition: state.cameraPosition,
          onMapCreated: (GoogleMapController mapController) {
            context.read<LocationMapBloc>().add(InitializeMap(mapController));
            // controllerGoogleMap = mapController;
            // googleMapCompleterController.complete(controllerGoogleMap);
          },
        );
      },
    );
  }
}
