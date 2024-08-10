import 'package:flutter/material.dart';
import 'package:rentit/features/home/domain/entity/brand_entity.dart';
import 'package:rentit/features/home/presentation/pages/widgets/brand_logo.dart';

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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Brands',
          style: Theme.of(context).textTheme.bodyLarge,
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
            TextButton(
              onPressed: onViewAll,
              child: const Text('View All'),
            ),
          ],
        ),
      ],
    );
  }
}
