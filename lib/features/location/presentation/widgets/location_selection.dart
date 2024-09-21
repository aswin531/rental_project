import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rentit/features/location/presentation/bloc/location_bloc.dart';
import 'package:rentit/features/location/presentation/bloc/location_event.dart';
import 'package:rentit/features/location/presentation/bloc/location_state.dart';

class LocationSelectionCommonWidget extends StatelessWidget {
  final TextEditingController searchController;
  final VoidCallback onCurrentLocationTap;
  final Function(String) onSearchSubmitted;

  const LocationSelectionCommonWidget({
    super.key,
    required this.searchController,
    required this.onCurrentLocationTap,
    required this.onSearchSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          TextField(
            controller: searchController,
            decoration: InputDecoration(
              hintText: 'Search for a location',
              suffixIcon: IconButton(
                icon: const Icon(Icons.search),
                onPressed: () => onSearchSubmitted(searchController.text),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            onSubmitted: onSearchSubmitted,
          ),
          const SizedBox(height: 16),
          ElevatedButton.icon(
            onPressed: onCurrentLocationTap,
            icon: const Icon(Icons.my_location),
            label: const Text('Use Current Location'),
          ),
          const SizedBox(height: 16),
          BlocBuilder<LocationMapBloc, LocationMapState>(
            builder: (context, state) {
              if (state.searchResults.isNotEmpty) {
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: state.searchResults.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(state.searchResults[index].address),
                      onTap: () {
                        // Handle search result selection
                        context.read<LocationMapBloc>().add(
                            UpdatePickupLocationEvent(
                                state.searchResults[index]));
                      },
                    );
                  },
                );
              }
              if (state.searchResults.isEmpty) {
                const Text('No Data ');
               // return Lottie.asset('assets/animation/loc_blue.json');
              }

              return const SizedBox.shrink();
            },
          ),
        ],
      ),
    );
  }
}
