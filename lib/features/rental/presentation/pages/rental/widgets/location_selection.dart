import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rentit/features/location/presentation/bloc/location_bloc.dart';
import 'package:rentit/features/location/presentation/bloc/location_event.dart';
import 'package:rentit/features/location/presentation/bloc/location_state.dart';
import 'package:rentit/features/rental/presentation/bloc/rental_bloc/rental_bloc.dart';
import 'package:rentit/features/rental/presentation/bloc/rental_bloc/rental_event.dart';
import 'package:rentit/utils/appcolors.dart';
import 'package:rentit/utils/primary_text.dart';

class LocationSelectionWidget extends StatelessWidget {
  final TextEditingController pickupLocationController =
      TextEditingController();
  final TextEditingController dropOffLocationController =
      TextEditingController();
  final LocationMapState locationState;

  LocationSelectionWidget({
    super.key,
    required this.locationState,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 5),
        PrimaryText(
          text: "Location",
          color: ExternalAppColors.black,
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              child: TextField(
                decoration: const InputDecoration(
                  labelText: "Pick-Up Location",
                  border: OutlineInputBorder(),
                ),
                controller: pickupLocationController,
                onChanged: (value) {
                  context
                      .read<RentalRequestBloc>()
                      .add(UpdatePickupLocationEvent(value));
                },
              ),
            ),
            const SizedBox(width: 8),
            CircleAvatar(
              radius: 25,
              child: IconButton(
                onPressed: () {
                  _useCurrentLocationForPickup(context);
                },
                icon: const Icon(FontAwesomeIcons.locationDot),
              ),
            )
          ],
        ),
        const SizedBox(height: 15),
        Row(
          children: [
            Expanded(
              child: TextField(
                decoration: const InputDecoration(
                  labelText: "Drop-Off Location",
                  border: OutlineInputBorder(),
                ),
                controller: dropOffLocationController,
                onChanged: (value) {
                  context
                      .read<RentalRequestBloc>()
                      .add(UpdateDropOffLocationEvent(value));
                },
              ),
            ),
            const SizedBox(width: 8),
            CircleAvatar(
              radius: 25,
              child: IconButton(
                onPressed: () {
                  
            context.read<LocationMapBloc>().add(MoveToCurrentLocation());
      
                 // _useCurrentLocationForDropoff(context);
                },
                icon: const Icon(FontAwesomeIcons.mapLocationDot),
              ),
            )
          ],
        ),
        const SizedBox(height: 10),
        Container(
          height: 75,
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            border: BorderDirectional(
                start: BorderSide(color: ExternalAppColors.blue, width: 8)),
            color: Colors.blue[50],
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              Expanded(
                child: RichText(
                  text: TextSpan(
                    style: DefaultTextStyle.of(context).style,
                    children: <TextSpan>[
                      const TextSpan(
                        text: "Choose Current Location as your",
                        style: TextStyle(color: Colors.black),
                      ),
                      TextSpan(
                        text: ' Pick-Up & Drop-Off ',
                        style: TextStyle(
                          fontSize: 15,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.bold,
                          color: ExternalAppColors.blue,
                        ),
                      ),
                      const TextSpan(text: 'location.'),
                    ],
                  ),
                ),
              ),
              Checkbox(
                value: _isUsingCurrentLocationForBoth(),
                onChanged: (value) {
                  if (value == true) {
                    _useCurrentLocationForBoth(context);
                  }
                },
              )
            ],
          ),
        )
      ],
    );
  }

  void _useCurrentLocationForPickup(BuildContext context) {
      debugPrint("Using current location for pickup"); // Add this line

    if (locationState.currentAddress != null) {
      pickupLocationController.text = locationState.currentAddress!;
      context
          .read<RentalRequestBloc>()
          .add(UpdatePickupLocationEvent(locationState.currentAddress!));
    }
  }

  void _useCurrentLocationForDropoff(BuildContext context) {
    if (locationState.currentAddress != null) {
      dropOffLocationController.text = locationState.currentAddress!;
      context
          .read<RentalRequestBloc>()
          .add(UpdateDropOffLocationEvent(locationState.currentAddress!));
    }
  }

  void _useCurrentLocationForBoth(BuildContext context) {
    _useCurrentLocationForPickup(context);
    _useCurrentLocationForDropoff(context);
  }

  bool _isUsingCurrentLocationForBoth() {
    return locationState.currentAddress != null &&
        pickupLocationController.text == locationState.currentAddress &&
        dropOffLocationController.text == locationState.currentAddress;
  }
}
