import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rentit/features/rental/data/model/combined.dart';
import 'package:rentit/features/rental/presentation/bloc/rental_bloc/rental_bloc.dart';
import 'package:rentit/features/rental/presentation/bloc/rental_bloc/rental_state.dart';

class BookingDetailScreen extends StatelessWidget {
  BookingDetailScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Booking"),
        backgroundColor: Colors.deepPurple,
      ),
      body: BlocBuilder<RentalRequestBloc, RentalRequestState>(
        builder: (context, state) {
          if (state is RentalRequestLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is RentalRequestError) {
            return Center(child: Text("Error: ${state.message}"));
          } else if (state is UserRentalRequestsWithCarDetailsLoaded) {
            final ongoingRentals = state.requestsWithCarDetails
                .where((rental) => rental.rentalRequest.paymentStatus != "completed")
                .toList();
            final completedRentals = state.requestsWithCarDetails
                .where((rental) =>
                    rental.rentalRequest.paymentStatus == "completed")
                .toList();

            return SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Ongoing Rentals Section
                  if (ongoingRentals.isNotEmpty)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Ongoing/Upcoming Booking",
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 16),
                        _buildOngoingRentalsList(ongoingRentals),
                        SizedBox(height: 30),
                      ],
                    ),

                  // Completed Rentals Section
                  if (completedRentals.isNotEmpty)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Completed Rentals",
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 16),
                        _buildCompletedRentalsList(completedRentals),
                      ],
                    ),
                ],
              ),
            );
          } else {
            return Center(child: Text("No booking data found."));
          }
        },
      ),
    );
  }

  // Ongoing Rentals List Widget
  Widget _buildOngoingRentalsList(
      List<RentalRequestWithCarDetails> ongoingRentals) {
    return Column(
      children: ongoingRentals.map((rental) {
        return Card(
          elevation: 8,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.network(
                      rental.car.imageUrls
                          .first, // Assuming car image URL is available
                      height: 150,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  rental.car.make, // Car model name
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Text(
                  rental.car.color, // Car description (optional)
                  style: TextStyle(color: Colors.grey),
                ),
                SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildIconText(Icons.calendar_today,
                        rental.rentalRequest.pickupDate.timeZoneName),
                    _buildIconText(Icons.attach_money,
                        '${rental.car.rentalPriceRange}/day'),
                  ],
                ),
                SizedBox(height: 16),
                _buildSummaryRow(
                    "Pick-up Location", rental.rentalRequest.pickUpLocation?? "PICKUP"),
                _buildSummaryRow(
                    "Drop-off Location", rental.rentalRequest.dropOffLocation ?? "DROP OF"),
                SizedBox(height: 16),
                Row(
                  children: [
                    Text(
                      "Status: ",
                      style: TextStyle(fontSize: 18, color: Colors.grey),
                    ),
                    Chip(
                      label: Text(
                        rental.rentalRequest.paymentStatus
                            , // Ongoing, Pending, etc.
                        style: TextStyle(color: Colors.white),
                      ),
                      backgroundColor: rental.rentalRequest.status == "ongoing"
                          ? Colors.green
                          : Colors.orangeAccent,
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  // Completed Rentals List Widget
  Widget _buildCompletedRentalsList(
      List<RentalRequestWithCarDetails> completedRentals) {
    return Column(
      children: completedRentals.map((rental) {
        return Card(
          elevation: 6,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          child: ListTile(
            leading:
                Icon(Icons.directions_car, size: 40, color: Colors.deepPurple),
            title: Text(rental.car.make,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            subtitle: Text(rental.rentalRequest.actualReturnDate.toString()),
            trailing: Chip(
              label: Text('Completed', style: TextStyle(color: Colors.white)),
              backgroundColor: Colors.green,
            ),
            onTap: () {
              // Optionally navigate to detailed rental page
            },
          ),
        );
      }).toList(),
    );
  }

  // Helper Widget for Summary Rows
  Widget _buildSummaryRow(String title, String detail) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
          Text(
            detail,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  // Helper for IconText Row
  Widget _buildIconText(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, color: Colors.deepPurple),
        SizedBox(width: 8),
        Text(
          text,
          style: TextStyle(fontSize: 16, color: Colors.black),
        ),
      ],
    );
  }
}
