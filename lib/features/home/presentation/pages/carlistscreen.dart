import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rentit/core/services/notification_services.dart';
import 'package:rentit/features/cardetail/cardetailpage.dart';
import 'package:rentit/features/home/presentation/bloc/car/carbloc.dart';
import 'package:rentit/features/home/presentation/bloc/car/carevent.dart';
import 'package:rentit/features/home/presentation/bloc/car/carstates.dart';
import 'package:rentit/features/home/presentation/pages/widgets/location_widget.dart';
import 'package:rentit/features/home/presentation/pages/widgets/popular_section.dart';

class CarListScreen extends StatelessWidget {
  const CarListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    NotificationService notificationService = NotificationService();
        debugPrint("Notification requested");

    notificationService.requestNotificationPermission();
    // notificationService.isTokenRefresh();
    notificationService.getDeviceToken().then((value) {
      debugPrint("Device Token : $value");
    });
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<CarBloc, CarState>(
          builder: (context, state) {
            if (state is CarInitial) {
              context.read<CarBloc>().add(FetchCars());
              return const Center(child: CircularProgressIndicator());
            } else if (state is CarLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is CarLoaded) {
              return SingleChildScrollView(
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
                      PopularCarSection(cars: state.cars),
                    ],
                  ),
                ),
              );
            } else if (state is CarError) {
              return Center(child: Text(state.message));
            }
            return Container();
          },
        ),
      ),
      backgroundColor: Colors.blue,
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.read<CarBloc>().add(FetchCars()),
        child: const Icon(Icons.refresh),
      ),
    );
  }
}

class BrandsSection extends StatelessWidget {
  final List<String> brands = [
    'Alfa Romeo',
    'BMW',
    'Audi',
  ];

  BrandsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Brands',
          style: TextStyle(
              fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
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

  const BrandLogo({super.key, required this.brand});

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

class CarCard extends StatelessWidget {
  final double rating;
  final String imageUrl;
  final String carType;
  final String carName;
  final RangeValues pricePerHour;
  final String fuelType;
  final int seats;
  final String? transmission;

  const CarCard({
    super.key,
    required this.rating,
    required this.imageUrl,
    required this.carType,
    required this.carName,
    required this.pricePerHour,
    required this.fuelType,
    required this.seats,
    this.transmission,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CarDetailPage(
                  carName: carName,
                  carType: carType,
                  imageUrl: imageUrl,
                  rating: rating,
                  pricePerHour: pricePerHour,
                  fuelType: fuelType,
                  seats: seats,
                  transmission: "Manual"),
            ));
      },
      child: Container(
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
            Text(carName,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '\$${pricePerHour.start.toStringAsFixed(2)}/hr',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
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
      ),
    );
  }
}
