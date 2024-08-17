import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:rentit/features/home/presentation/bloc/selectedcar/selected_bloc.dart';
import 'package:rentit/features/home/presentation/bloc/selectedcar/selectedcar_state.dart';
import 'package:rentit/features/home/presentation/pages/widgets/rating.dart';
import 'package:rentit/features/home/presentation/pages/widgets/tapbar.dart';
import 'package:rentit/features/rental/presentation/pages/rental/widgets/booknowbutton.dart';
import 'package:rentit/utils/appcolors.dart';
import 'package:rentit/utils/primary_text.dart';
import 'package:rentit/widgets/custom_carbody_container.dart';

class CarDetailPage extends StatelessWidget {
  const CarDetailPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SelectedCarBloc, SelectedCarState>(
      builder: (context, state) {
        if (state is CarSelected) {
          final car = state.car;
          debugPrint('Car updated: ${state.car.make} ${state.car.model}');

          return Scaffold(
            backgroundColor: ExternalAppColors.bg,
            appBar: AppBar(
              backgroundColor: ExternalAppColors.bg,
              leading: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, color: ExternalAppColors.white),
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () => context.pop(),
                  ),
                ),
              ),
              title: PrimaryText(
                text: "Car Details",
                color: ExternalAppColors.black,
              ),
              centerTitle: true,
              actions: [
                Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: Container(
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: ExternalAppColors.white),
                      child: IconButton(
                          icon: const Icon(Icons.share), onPressed: () {})),
                ),
                Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: Container(
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: ExternalAppColors.white),
                      child: IconButton(
                          icon: const Icon(Icons.favorite_outline),
                          onPressed: () {})),
                ),
              ],
            ),
            body: Column(
              children: [
                Expanded(
                  child: ListView(
                    //crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Image.network(car.imageUrls.last,
                                fit: BoxFit.cover),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: ExternalAppColors.white),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 16),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    CustomCarBodyContainer(
                                      text: car.body.toUpperCase(),
                                    ),
                                    
                                    const StarRating(
                                      rating: 4.9,
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 20),
                                Row(
                                  children: [
                                    PrimaryText(
                                      text: car.make.toUpperCase(),
                                      size: 24,
                                      fontWeight: FontWeight.bold,
                                      color: ExternalAppColors.black,
                                    ),
                                    PrimaryText(
                                      text: ' - ${car.model.toUpperCase()}',
                                      size: 24,
                                      fontWeight: FontWeight.bold,
                                      color: ExternalAppColors.black,
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 16),
                                const TabBarSection(),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                      splashColor: Colors.amber,
                      tileColor: ExternalAppColors.white,
                      contentPadding: const EdgeInsets.all(15),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      title: const Text(
                        'Price:',
                        style: TextStyle(
                          fontSize: 19,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text:
                                  '\$${car.rentalPriceRange.start.toStringAsFixed(2)}',
                              style: TextStyle(
                                color: ExternalAppColors.blue,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextSpan(
                              text: '/hrs',
                              style: TextStyle(
                                  color: ExternalAppColors.grey,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ),
                      trailing: BookNowButton(
                        onPressed: () {
                          context.push("/bookingContinuePage");
                        },
                      )
                      // BookingButton(carId: car.carId),
                      ),
                ),
              ],
            ),
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}

/*class BookingButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        final state = context.read<SelectedCarBloc>().state;
        if (state is CarSelected) {
          final car = state.car;
          // Use car data to start booking process
          startBookingProcess(context, car);
        }
      },
      child: Text('Book Now'),
    );
  }

  void startBookingProcess(BuildContext context, CarVehicleEntity car) {
    // Implement booking logic
  }
}*/