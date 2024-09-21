import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rentit/features/location/presentation/bloc/location_bloc.dart';
import 'package:rentit/features/location/presentation/bloc/location_event.dart';
import 'package:rentit/features/location/presentation/bloc/location_state.dart';
import 'package:rentit/utils/appcolors.dart';
import 'package:rentit/utils/primary_text.dart';

class LocationPickerBottomSheet extends StatelessWidget {
  final Function(String) onLocationSelected;

  const LocationPickerBottomSheet(
      {super.key, required this.onLocationSelected});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocationMapBloc, LocationMapState>(
      builder: (context, state) {
        return Container(
          padding: const EdgeInsets.all(16),
          height: 400,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 8,
                spreadRadius: 1,
                offset: Offset(0, -2),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Select a Location',
                style: Theme.of(context)
                    .textTheme
                    .bodySmall
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  context
                      .read<LocationMapBloc>()
                      .add(MoveToCurrentLocation());
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: ExternalAppColors.bg,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: PrimaryText(
                    text: 'Use Current Location',
                    size: 15,
                    color: ExternalAppColors.blue,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: context.read<LocationMapBloc>().searchController,
                decoration: InputDecoration(
                  hintText: 'Search location',
                  suffixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide:
                        BorderSide(color: Theme.of(context).primaryColor),
                  ),
                ),
                onChanged: (query) {
                  context.read<LocationMapBloc>().debouncer.run(() {
                    context
                        .read<LocationMapBloc>()
                        .add(SearchLocationEvent(query: query));
                  });
                },
              ),
              const SizedBox(height: 16),
              Flexible(
                fit: FlexFit.loose, 
          
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: state.searchResults.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(state.searchResults[index].address),
                      onTap: () {
                        onLocationSelected(
                            state.searchResults[index].address);
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
