import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rentit/features/rental/data/model/request_form_model.dart';
import 'package:rentit/features/rental/presentation/bloc/rental_bloc/rental_bloc.dart';
import 'package:rentit/features/rental/presentation/bloc/rental_bloc/rental_event.dart';
import 'package:rentit/features/rental/presentation/bloc/rental_bloc/rental_state.dart';

class CarDetails extends StatelessWidget {
  const CarDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RentalRequestBloc, RentalRequestState>(
      builder: (context, state) {
        if (state is RentalRequestInitial) {
          final user = FirebaseAuth.instance.currentUser!.uid;
          context
              .read<RentalRequestBloc>()
              .add(FetchUserRentalRequestsWithCarDetailsEvent(user));
          return const Center(child: CircularProgressIndicator());
        } else if (state is RentalRequestLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is UserRentalRequestsWithCarDetailsLoaded) {
          final rentalRequestWithCarDetails =
              state.requestsWithCarDetails.first;
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  color: const Color.fromARGB(255, 227, 231, 233),
                  elevation: 3,
                  child: Stack(
                    children: [
                      Image.network(
                          rentalRequestWithCarDetails.car.imageUrls.last),
                      Positioned(
                        bottom: 8,
                        left: 8,
                        child: Row(
                          children: [
                            const Icon(Icons.star,
                                color: Colors.yellow, size: 25),
                            const SizedBox(width: 5),
                            Text(
                              rentalRequestWithCarDetails.car.model,
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18),
                            )
                          ],
                        ),
                      ),
                      Positioned(
                        bottom: 5,
                        right: 8,
                        child: Container(
                          padding: const EdgeInsets.all(14),
                          color: Colors.black.withOpacity(0.5),
                          child: Text(
                            rentalRequestWithCarDetails.car.body,
                            //rentalRequestWithCarDetails.rentalRequest.carId,
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    rentalRequestWithCarDetails.rentalRequest.status
                        .toString()
                        .split('.')
                        .last,
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: getStatusColor(
                            rentalRequestWithCarDetails.rentalRequest.status)),
                  ),
                ),
              ),
            ],
          );
        } else if (state is RentalRequestError) {
          return Center(child: Text(state.message));
        }
        return Container();
      },
    );
  }
}
