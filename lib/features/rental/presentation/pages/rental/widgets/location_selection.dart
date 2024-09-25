import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rentit/features/location/data/models/location_model.dart';
import 'package:rentit/features/location/presentation/bloc/location_bloc.dart';
import 'package:rentit/features/location/presentation/bloc/location_event.dart';
import 'package:rentit/features/location/presentation/bloc/location_state.dart';
import 'package:rentit/utils/appcolors.dart';
import 'package:rentit/utils/primary_text.dart';

class LocationSelectionWidget extends StatelessWidget {
  final TextEditingController pickupLocationController =
      TextEditingController();
  final TextEditingController dropOffLocationController =
      TextEditingController();

  LocationSelectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocationMapBloc, LocationMapState>(
      builder: (context, locationState) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 5),
            PrimaryText(
              text: "Location",
              color: ExternalAppColors.black,
            ),
            const SizedBox(height: 10),
            _buildLocationField(
              context: context,
              label: "Pick-Up Location",
              controller: pickupLocationController,
              onChanged: (value) => _onSearchLocation(context, value),
              onLocationSelected: (location) =>
                  _onPickupLocationSelected(context, location),
              useCurrentLocation: () => _useCurrentLocationForPickup(context),
            ),
            const SizedBox(height: 15),
            _buildLocationField(
              context: context,
              label: "Drop-Off Location",
              controller: dropOffLocationController,
              onChanged: (value) => _onSearchLocation(context, value),
              onLocationSelected: (location) =>
                  _onDropOffLocationSelected(context, location),
              useCurrentLocation: () => _useCurrentLocationForDropOff(context),
            ),
            const SizedBox(height: 10),
            _buildCurrentLocationCheckbox(context, locationState),
          ],
        );
      },
    );
  }

  Widget _buildLocationField({
    required BuildContext context,
    required String label,
    required TextEditingController controller,
    required Function(String) onChanged,
    required Function(LocationModel) onLocationSelected,
    required VoidCallback useCurrentLocation,
  }) {
    return Row(
      children: [
        Expanded(
          child: Autocomplete<LocationModel>(
            displayStringForOption: (LocationModel option) => option.address,
            optionsBuilder: (TextEditingValue textEditingValue) {
              if (textEditingValue.text == '') {
                return const Iterable<LocationModel>.empty();
              }
              return context.read<LocationMapBloc>().state.searchResults;
            },
            onSelected: onLocationSelected,
            fieldViewBuilder: (BuildContext context,
                TextEditingController fieldController,
                FocusNode fieldFocusNode,
                VoidCallback onFieldSubmitted) {
              return TextField(
                controller: fieldController,
                focusNode: fieldFocusNode,
                decoration: InputDecoration(
                  labelText: label,
                  border: const OutlineInputBorder(),
                ),
                onChanged: onChanged,
              );
            },
          ),
        ),
        const SizedBox(width: 8),
        CircleAvatar(
          radius: 25,
          child: IconButton(
            onPressed: useCurrentLocation,
            icon: const Icon(FontAwesomeIcons.locationDot),
          ),
        )
      ],
    );
  }

  Widget _buildCurrentLocationCheckbox(
      BuildContext context, LocationMapState locationState) {
    return Container(
      height: 75,
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: BorderDirectional(
          start: BorderSide(color: ExternalAppColors.blue, width: 8),
        ),
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
            value: _isUsingCurrentLocationForBoth(locationState),
            onChanged: (value) {
              if (value == true) {
                _useCurrentLocationForBoth(context, locationState);
              }
            },
          )
        ],
      ),
    );
  }

  void _onSearchLocation(BuildContext context, String query) {
    context.read<LocationMapBloc>().add(SearchLocationEvent(query: query));
  }

  void _onPickupLocationSelected(BuildContext context, LocationModel location) {
    context
        .read<LocationMapBloc>()
        .add(UpdatePickupLocationEvent(location));
    pickupLocationController.text = location.address;
  }

  void _onDropOffLocationSelected(
      BuildContext context, LocationModel location) {
    context
        .read<LocationMapBloc>()
        .add(UpdateDropOffLocationEvent(location));
    dropOffLocationController.text = location.address;
  }

  void _useCurrentLocationForPickup(BuildContext context) {
    context.read<LocationMapBloc>().add(const UseCurrentLocationForPickup());
  }

  void _useCurrentLocationForDropOff(BuildContext context) {
    context.read<LocationMapBloc>().add(const UseCurrentLocationForDropOff());
  }
 

  void _useCurrentLocationForBoth(
      BuildContext context, LocationMapState locationState) {
    if (locationState.currentAddress != null) {
      final LocationModel currentLocation = LocationModel(
      latitude: locationState.cameraPosition.target.latitude,
      longitude: locationState.cameraPosition.target.longitude,
      address: locationState.currentAddress!,
    );
      pickupLocationController.text = currentLocation.address;
      dropOffLocationController.text = currentLocation.address;
      context
          .read<LocationMapBloc>()
          .add(UpdatePickupLocationEvent(currentLocation));
      context
          .read<LocationMapBloc>()
          .add(UpdateDropOffLocationEvent(currentLocation));
    }
  }

  bool _isUsingCurrentLocationForBoth(LocationMapState locationState) {
    return locationState.pickupLocation == locationState.currentAddress &&
        locationState.dropOffLocation == locationState.currentAddress;
  }
}
