import 'package:flutter/material.dart';
import 'package:rentit/features/home/domain/entity/car_entity.dart';
import 'package:rentit/features/home/presentation/pages/widgets/about_tab.dart';
import 'package:rentit/features/home/presentation/pages/widgets/review_tab.dart';
import 'package:rentit/utils/appcolors.dart';
import 'package:rentit/utils/primary_text.dart';

class TabBarSection extends StatefulWidget {
  final CarVehicleEntity car;
  const TabBarSection({
    super.key,
    required this.car,
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
        const SizedBox(height: 5),
        Divider(
          color: ExternalAppColors.grey.withOpacity(0.4),
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
        width: 110,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
                style: BorderStyle.solid,
                color: isSelected ? ExternalAppColors.blue : Colors.transparent,
                width: 5),
          ),
          color: isSelected ? Colors.transparent : Colors.transparent,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Align(
          alignment: Alignment.center,
          child: PrimaryText(
              text: text,
              color: isSelected ? Colors.blue : Colors.black,
              fontWeight: FontWeight.w600,
              size: 19),
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
    return const AboutTabWidget();
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
    return const ReviewTabWidget();
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
