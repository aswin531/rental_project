import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rentit/features/home/presentation/bloc/car/carbloc.dart';
import 'package:rentit/features/home/presentation/bloc/car/carevent.dart';

class FilterDialog extends StatefulWidget {
  const FilterDialog({super.key});

  @override
  _FilterDialogState createState() => _FilterDialogState();
}

class _FilterDialogState extends State<FilterDialog> {
  String? selectedMake;
  String? selectedModel;
  RangeValues selectedPriceRange = const RangeValues(0, 1000);
  int? selectedYear;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Filter Cars'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            DropdownButton<String>(
              value: selectedMake,
              hint: const Text('Select Make'),
              onChanged: (String? newValue) {
                setState(() {
                  selectedMake = newValue;
                });
              },
              items: <String>['Toyota', 'Honda', 'Ford', 'BMW']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            DropdownButton<String>(
              value: selectedModel,
              hint: const Text('Select Model'),
              onChanged: (String? newValue) {
                setState(() {
                  selectedModel = newValue;
                });
              },
              items: <String>['Sedan', 'SUV', 'Hatchback', 'Truck']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            const Text('Price Range'),
            RangeSlider(
              values: selectedPriceRange,
              min: 0,
              max: 1000,
              divisions: 20,
              labels: RangeLabels(
                selectedPriceRange.start.round().toString(),
                selectedPriceRange.end.round().toString(),
              ),
              onChanged: (RangeValues values) {
                setState(() {
                  selectedPriceRange = values;
                });
              },
            ),
            TextField(
              decoration: const InputDecoration(labelText: 'Year'),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                setState(() {
                  selectedYear = int.tryParse(value);
                });
              },
            ),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: const Text('Cancel'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: const Text('Apply'),
          onPressed: () {
            context.read<CarBloc>().add(FilterCars(
                  make: selectedMake,
                  model: selectedModel,
                  priceRange: selectedPriceRange,
                  year: selectedYear,
                ));
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}