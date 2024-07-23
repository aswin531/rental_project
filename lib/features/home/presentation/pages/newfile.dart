import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rentit/features/home/domain/usecases/getcar_usecase.dart';
import 'package:rentit/features/home/presentation/bloc/car/carbloc.dart';
import 'package:rentit/features/home/presentation/bloc/car/carevent.dart';
import 'package:rentit/features/home/presentation/bloc/car/carstates.dart';

class CarRentalHomePage extends StatelessWidget {
  const CarRentalHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CarBloc(getcarUsecase: context.read<GetcarUsecase>())..add(FetchCars()),
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const LocationWidget(),
                  const SizedBox(height: 16),
                  const SearchBar(),
                  const SizedBox(height: 24),
                  BrandsSection(),
                  const SizedBox(height: 24),
                  const PopularCarSection(),
                ],
              ),
            ),
          ),
        ),
        backgroundColor: Colors.blue,
      ),
    );
  }
}

class LocationWidget extends StatelessWidget {
  const LocationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Location',
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
        Row(
          children: [
            Icon(Icons.location_on, color: Colors.white),
            SizedBox(width: 8),
            Text(
              'New York, USA', // Hardcoded location
              style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ],
    );
  }
}

class SearchBar extends StatelessWidget {
  const SearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        prefixIcon: const Icon(Icons.search),
        hintText: 'Search',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}

class BrandsSection extends StatelessWidget {
  final List<String> brands = ['Mercedes', 'Skoda', 'Ferrari', 'Other'];

   BrandsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Brands',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: brands.map((brand) => BrandLogo(brand: brand)).toList(),
        ),
      ],
    );
  }
}

class BrandLogo extends StatelessWidget {
  final String brand;

  const BrandLogo({Key? key, required this.brand}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.read<CarBloc>().add(FilterCars(brand)),
      child: Container(
        width: 60,
        height: 60,
        decoration: const BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
        ),
        child: Center(child: Text(brand[0])),
      ),
    );
  }
}

class PopularCarSection extends StatelessWidget {
  const PopularCarSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Popular Car',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            TextButton(
              onPressed: () => context.read<CarBloc>().add(FetchCars()),
              child: const Text('View All'),
            ),
          ],
        ),
        const SizedBox(height: 16),
        BlocBuilder<CarBloc, CarState>(
          builder: (context, state) {
            if (state is CarLoading) {
              return const CircularProgressIndicator();
            } else if (state is CarLoaded) {
              return ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: state.cars.length,
                itemBuilder: (context, index) {
                  final car = state.cars[index];
                  return CarCard(
                    rating: 4.9, // Hardcoded rating
                    imageUrl: car.imageUrls.first,
                    carType: car.model,
                    carName: '${car.make} ${car.model}',
                    pricePerHour: car.rentalPriceRange,
                    fuelType: car.engine,
                    seats: car.seatCapacity,
                    transmission: 'Manual', // Hardcoded transmission
                  );
                },
              );
            } else if (state is CarError) {
              return Text('Error: ${state.message}');
            }
            return Container();
          },
        ),
      ],
    );
  }
}

class CarCard extends StatelessWidget {
  final double rating;
  final String imageUrl;
  final String carType;
  final String carName;
  final RangeValues pricePerHour;
  final String fuelType;
  final int seats;
  final String transmission;

  const CarCard({
    super.key,
    required this.rating,
    required this.imageUrl,
    required this.carType,
    required this.carName,
    required this.pricePerHour,
    required this.fuelType,
    required this.seats,
    required this.transmission,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(Icons.star, color: Colors.yellow),
                  Text('$rating'),
                ],
              ),
              const Icon(Icons.favorite_border),
            ],
          ),
          Image.network(imageUrl, height: 120),
          Text(carType, style: const TextStyle(color: Colors.grey)),
          Text(carName, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              //Text('\$${pricePerHour.toStringAsFixed(2)}/hr', style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.blue)),
              Row(
                children: [
                  const Icon(Icons.local_gas_station, size: 16),
                  Text(fuelType),
                  const SizedBox(width: 8),
                  const Icon(Icons.person, size: 16),
                  Text('$seats Seats'),
                ],
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text('+ $transmission', style: const TextStyle(color: Colors.grey)),
        ],
      ),
    );
  }
}