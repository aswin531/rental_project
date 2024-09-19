
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rentit/features/location/presentation/bloc/location_bloc.dart';
import 'package:rentit/features/location/presentation/bloc/location_event.dart';
import 'package:rentit/features/location/presentation/bloc/location_state.dart';

class LocationPickerBottomSheet extends StatelessWidget {
  final Function(String) onLocationSelected;

  const LocationPickerBottomSheet({super.key, required this.onLocationSelected});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocationMapBloc, LocationMapState>(
      builder: (context, state) {
        return Container(
          height: 300,
          child: Column(
            children: [
              ElevatedButton(
                onPressed: () {
                  context.read<LocationMapBloc>().add(MoveToCurrentLocation());
                },
                child: const Text('Use Current Location'),
              ),
              TextField(
                controller: context.read<LocationMapBloc>().searchController,
                decoration: const InputDecoration(
                  hintText: 'Search location',
                  suffixIcon: Icon(Icons.search),
                ),
                onChanged: (query) {
                  context.read<LocationMapBloc>().debouncer.run(() {
                    context.read<LocationMapBloc>().add(SearchLocationEvent(query: query));
                  });
                },
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: state.searchResults.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(state.searchResults[index].address),
                      onTap: () {
                        onLocationSelected(state.searchResults[index].address);
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}