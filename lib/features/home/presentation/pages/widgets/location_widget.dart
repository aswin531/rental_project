import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rentit/features/location/presentation/bloc/location_bloc.dart';
import 'package:rentit/features/location/presentation/bloc/location_state.dart';

class LocationWidget extends StatelessWidget {
  const LocationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // PrimaryText(
              //   text: 'Location',
              //   color: ExternalAppColors.white,
              //   size: 18,
              // ),
              BlocBuilder<LocationMapBloc, LocationMapState>(
                builder: (context, state) {
                  debugPrint(
                      "Building map with state: ${state.cameraPosition.target.latitude}, ${state.cameraPosition.target.longitude}");
                  return Row(
                    children: [
                      const Icon(Icons.location_on, color: Colors.white),
                      const SizedBox(width: 8),
                      Text(
                        state.currentAddress ??
                            //   _extractCityFromAddress(state.currentAddress) ??
                            "Fetching address...",
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 3, 169, 244),
                  borderRadius: BorderRadius.circular(12)),
              child: IconButton(
                icon: const Icon(
                  Icons.notifications,
                  color: Colors.white,
                ),
                onPressed: () {},
              ),
            ),
          ),
        ],
      ),
    );
  }

  String? _extractCityFromAddress(String? address) {
    if (address == null || address.isEmpty) {
      return null;
    }
    List<String> parts = address.split(',');
    if (parts.length > 3) {
      return parts[3].trim();
    }
    return null;
  }
}
