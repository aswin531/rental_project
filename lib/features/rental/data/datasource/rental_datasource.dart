// rental_request_data_source.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:rentit/features/rental/data/model/car_req.dart';
import 'package:rentit/features/rental/data/model/combined.dart';
import 'package:rentit/features/rental/data/model/request_form_model.dart';

abstract class RentalRequestDataSource {
  Future<void> createRentalRequest(RentalRequestModel request);
  Future<List<RentalRequestWithCarDetails>> getUserRentalRequests(
      String userId);
  Future<void> updateRentalRequestStatus(String requestId, String status);
  Future<bool> isCarAvailable(
      String carId, DateTime? startDate, DateTime? endDate);
  Future<void> completeReturnProcess(String requestId);
}

class FirebaseRentalRequestDataSource implements RentalRequestDataSource {
  final FirebaseFirestore _firestore;

  FirebaseRentalRequestDataSource(this._firestore);

  @override
  Future<void> createRentalRequest(RentalRequestModel request) async {
    await _firestore.collection('rental_requests').add(request.toJson());
  }

  @override
  Future<List<RentalRequestWithCarDetails>> getUserRentalRequests(
      String userId) async {
    final rentalRequestsQuerySnapshot = await FirebaseFirestore.instance
        .collection('rental_requests')
        .where('userId', isEqualTo: userId)
        .get();
// .orderBy('createdAt', descending: true)
    List<RentalRequestWithCarDetails> results = [];

    for (var doc in rentalRequestsQuerySnapshot.docs) {
      final rentalRequest = RentalRequestModel.fromJson(doc.data(), doc.id);
      debugPrint(
          "CarID from fetching : ${rentalRequest.carId} and UserID from Fetching : ${rentalRequest.userId} and DocumentId : ${doc.id}");

      // Fetch car details
      final carDoc = await FirebaseFirestore.instance
          .collection('cars')
          .doc(rentalRequest.carId)
          .get();

      if (carDoc.exists) {
        final carData = carDoc.data();
        if (carData != null) {
          final car = CarModel.fromJson(carData, rentalRequest.carId);
          results.add(RentalRequestWithCarDetails(
              rentalRequest: rentalRequest, car: car));
        } else {
          debugPrint("Car data is null for carId: ${rentalRequest.carId}");
        }
      } else {
        debugPrint("No car found with carId: ${rentalRequest.carId}");
      }
    }

    return results;
  }

  @override
  Future<bool> isCarAvailable(
    String carId,
    DateTime? startDate, // Now nullable
    DateTime? endDate, // Now nullable
  ) async {
    if (startDate == null || endDate == null) {
      // If either date is null, we cannot check availability, return false or handle appropriately
      return false;
    }

    // Query rental requests where the car's pickup and return dates overlap with the requested dates
    final rentalRequests = await _firestore
        .collection('rentalRequests')
        .where('carId', isEqualTo: carId)
        .where('pickupDate', isLessThanOrEqualTo: endDate)
        .where('returnDate', isGreaterThanOrEqualTo: startDate)
        .get();

    // If any document is found, the car is not available
    if (rentalRequests.docs.isNotEmpty) {
      return false;
    }

    // If no overlapping reservation is found, the car is available
    return true;
  }

  @override
  Future<void> completeReturnProcess(String requestId) async {
    await _firestore.collection('rental_requests').doc(requestId).update({
      'returnstatus': 'completed',
      'actualReturnDate': DateTime
          .now(), // when the rental return process is marked as completed
    });
  }

  @override
  Future<void> updateRentalRequestStatus(
      String requestId, String status) async {
    await _firestore
        .collection('rental_requests')
        .doc(requestId)
        .update({'status': status});
  }
}
