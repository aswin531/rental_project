import 'package:flutter/material.dart';
import 'package:rentit/features/home/domain/entity/car_entity.dart';

class TabBarSection extends StatefulWidget {
    final CarVehicleEntity car;

  // final String carType;
  // final String fuelType;
  // final int seats;
  // final double rating;
  // final String transmission;
  // final String imageUrl;
  const TabBarSection({
    super.key, required this.car,
    // required this.carType,
    // required this.fuelType,
    // required this.seats,
    // required this.rating,
    // required this.transmission,
    // required this.imageUrl,
  });

  @override
  // ignore: library_private_types_in_public_api
  _TabBarSectionState createState() => _TabBarSectionState();
}

class _TabBarSectionState extends State<TabBarSection> {
  int _selectedIndex = 0;

  void _onTabSelected(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildTabButton('About', 0),
            _buildTabButton('Gallery', 1),
            _buildTabButton('Review', 2),
          ],
        ),
        const SizedBox(height: 16),
        _buildTabContent(),
      ],
    );
  }

  Widget _buildTabButton(String text, int index) {
    bool isSelected = _selectedIndex == index;
    return GestureDetector(
      onTap: () => _onTabSelected(index),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? Colors.blue : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          text,
          style: TextStyle(color: isSelected ? Colors.white : Colors.black),
        ),
      ),
    );
  }

  Widget _buildTabContent() {
    return IndexedStack(
      index: _selectedIndex,
      children: [
        _buildAboutTab(),
        _buildGalleryTab(),
        _buildReviewTab(),
      ],
    );
  }

  Widget _buildAboutTab() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // buildSpecItem(Icons.directions_car, 'Type',),
        // buildSpecItem(Icons.local_gas_station, 'Fuel Type', widget.fuelType),
        // buildSpecItem(Icons.event_seat, 'Seats', widget.seats.toString()),
        // buildSpecItem(Icons.speed, 'Transmission', widget.transmission),
        // buildSpecItem(Icons.star, 'Rating', widget.rating.toString()),
      ],
    );
  }

  Widget _buildGalleryTab() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Gallery', style: TextStyle(fontSize: 16)),
      ],
    );
  }

  Widget _buildReviewTab() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Reviews', style: TextStyle(fontSize: 16)),
      ],
    );
  }

  Widget buildSpecItem(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(icon, size: 24),
          const SizedBox(width: 8),
          Text('$label: $value'),
        ],
      ),
    );
  }
}
