import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:rentit/core/injection_container/dependency_injection.dart';
import 'package:rentit/features/rental/presentation/bloc/rental_bloc/rental_bloc.dart';
import 'package:rentit/features/rental/presentation/bloc/rental_bloc/rental_state.dart';
import 'package:rentit/features/returncar/domain/usecases/return_car_confirm_usecases.dart';
import 'package:rentit/features/returncar/domain/usecases/return_car_initial_usecases.dart';
import 'package:rentit/features/returncar/presentation/bloc/return_car_bloc.dart';

class CarReturnProcessScreen extends StatelessWidget {
  const CarReturnProcessScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CarReturnBloc(
        returnCarInitialUsecases: sl<ReturnCarInitialUsecases>(),
        returnCarConfirmUsecase: sl<ReturnCarConfirmUsecase>(),
      ),
      child: Scaffold(
        body: BlocBuilder<RentalRequestBloc, RentalRequestState>(
            builder: (context, rentalRequestState) {
          if (rentalRequestState is RentalRequestLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (rentalRequestState
              is UserRentalRequestsWithCarDetailsLoaded) {
            if (rentalRequestState.requestsWithCarDetails.isEmpty) {
              return const Center(child: Text('No active rentals found'));
            }
            final rentalDetails =
                rentalRequestState.requestsWithCarDetails.first;
            debugPrint('DETSILS : $rentalDetails==========================');
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildHeader(),
                    const SizedBox(height: 24),
                    _buildRentalInfo(rentalDetails),
                    const SizedBox(height: 24),
                    _buildReturnChecklist(),
                    const SizedBox(height: 24),
                    // _buildInitiateReturnButton(),
                  ],
                ),
              ),
            );
          } else if (rentalRequestState is RentalRequestError) {
            return Center(child: Text('Error: ${rentalRequestState.message}'));
          } else {
            return const Center(child: Text('No data available'));
          }
        }),
      ),
    );
  }

  Widget _buildHeader() {
    return const Text(
      'Car Return Process',
      style: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildRentalInfo(var rentalDetails) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Rental ID: $rentalDetails',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text('User ID:$rentalDetails '),
            const SizedBox(height: 8),
            Text(
                'Return Date: ${DateFormat('yyyy-MM-dd').format(DateTime.now())}'),
          ],
        ),
      ),
    );
  }

  Widget _buildReturnChecklist() {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Return Checklist',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            _buildChecklistItem('Full tank of gas'),
            _buildChecklistItem('Clean interior'),
            _buildChecklistItem('No new damages'),
            _buildChecklistItem('All accessories returned'),
          ],
        ),
      ),
    );
  }

  Widget _buildChecklistItem(String text) {
    return Row(
      children: [
        const Icon(Icons.check_circle, color: Colors.green),
        const SizedBox(width: 8),
        Text(text),
      ],
    );
  }
}
