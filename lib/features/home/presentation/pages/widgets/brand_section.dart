import 'package:flutter/material.dart';
import 'package:rentit/features/home/domain/entity/brand_entity.dart';
import 'package:rentit/features/home/presentation/pages/widgets/brand_logo.dart';
import 'package:rentit/utils/primary_text.dart';

class BrandListWidget extends StatelessWidget {
  final List<BrandEntity> brands;
  final VoidCallback onViewAll;

  const BrandListWidget({
    super.key,
    required this.brands,
    required this.onViewAll,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const PrimaryText(
                text: "Brands",
                size: 30,
                color: Colors.black,
                fontWeight: FontWeight.w500,
              ),
              TextButton(
                onPressed: onViewAll,
                child: const Text('View All'),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: brands
                        .take(5)
                        .map((brand) => Padding(
                              padding: const EdgeInsets.only(right: 16.0),
                              child: BrandLogoWidget(
                                logoUrl: brand.logoUrl,
                                brandName: brand.brandName,
                                onTap: () {},
                              ),
                            ))
                        .toList(),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
