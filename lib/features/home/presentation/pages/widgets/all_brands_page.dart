import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rentit/features/home/presentation/bloc/brand/brand_bloc.dart';
import 'package:rentit/features/home/presentation/bloc/brand/brand_states.dart';
import 'package:rentit/features/home/presentation/pages/widgets/brand_logo.dart';

class AllBrandsPage extends StatelessWidget {
  const AllBrandsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('All Brands')),
      body: BlocBuilder<BrandsBloc, BrandsState>(
        builder: (context, state) {
          if (state is BrandsLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is BrandsLoaded) {
            return GridView.builder(
              padding: const EdgeInsets.all(16.0),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3, 
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              itemCount: state.brands.length,
              itemBuilder: (context, index) {
                final brand = state.brands[index];
                return BrandLogoWidget(
                  logoUrl: brand.logoUrl,
                  brandName: brand.brandName,
                  onTap: () {
                  },
                );
              },
            );
          } else if (state is BrandsError) {
            return Center(child: Text(state.message));
          } else {
            return const Center(child: Text('No brands available'));
          }
        },
      ),
    );
  }
}
