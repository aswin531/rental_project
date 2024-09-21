import 'package:flutter/material.dart';
import 'package:rentit/core/injection_container/dependency_injection.dart';
import 'package:rentit/features/rental/data/model/car_req.dart';
import 'package:rentit/features/rental/data/model/combined.dart';
import 'package:rentit/features/rental/data/model/request_form_model.dart';

abstract class RentalRequestDataSource {
  Future<void> createRentalRequest(RentalRequestModel request);
  Stream<List<RentalRequestWithCarDetails>> getUserRentalRequests(
      String userId);
  Future<void> updateRentalRequestStatus(String requestId, String status);
  Future<bool> isCarAvailable(
      String carId, DateTime? startDate, DateTime? endDate);
  Future<void> completeReturnProcess(String requestId);
}

class FirebaseRentalRequestDataSource implements RentalRequestDataSource {

  FirebaseRentalRequestDataSource();

  @override
  Future<void> createRentalRequest(RentalRequestModel request) async {
    await firebaseFirestore.collection('rental_requests').add(request.toJson());
  }

  @override
  Future<bool> isCarAvailable(
    String carId,
    DateTime? startDate, 
    DateTime? endDate,
  ) async {
    if (startDate == null || endDate == null) {
      // If either date is null, we cannot check availability, return false or handle appropriately
      return false;
    }

    // Query rental requests where the car's pickup and return dates overlap with the requested dates
    final rentalRequests = await firebaseFirestore
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
    await firebaseFirestore.collection('rental_requests').doc(requestId).update({
      'returnstatus': 'completed',
      'actualReturnDate': DateTime
          .now(), // when the rental return process is marked as completed
    });
  }

  @override
  Future<void> updateRentalRequestStatus(
      String requestId, String status) async {
    await firebaseFirestore
        .collection('rental_requests')
        .doc(requestId)
        .update({'status': status});
  }
  
  @override
  Stream<List<RentalRequestWithCarDetails>> getUserRentalRequests(String userId) {
     return firebaseFirestore
        .collection('rental_requests')
        .where('userId', isEqualTo: userId)
        .limit(10)
        .snapshots()
        .asyncMap((snapshot) async {
      List<RentalRequestWithCarDetails> results = [];
      for (var doc in snapshot.docs) {
        try {
          final rentalRequest = RentalRequestModel.fromJson(doc.data(), doc.id);
          debugPrint("CarID: ${rentalRequest.carId}, UserID: ${rentalRequest.userId}, DocumentId: ${doc.id}");

          final carDoc = await firebaseFirestore.collection('cars').doc(rentalRequest.carId).get();
          if (carDoc.exists) {
            final carData = carDoc.data();
            if (carData != null) {
              final car = CarModel.fromJson(carData, rentalRequest.carId);
              results.add(RentalRequestWithCarDetails(
                rentalRequest: rentalRequest,
                car: car,
              ));
            } else {
              debugPrint("Car data is null for carId: ${rentalRequest.carId}");
            }
          } else {
            debugPrint("No car found with carId: ${rentalRequest.carId}");
          }
        } catch (e) {
          debugPrint("Error fetching car details for request ${doc.id}: $e");
        }
      }
      results.sort((a, b) => b.rentalRequest.createdAt.compareTo(a.rentalRequest.createdAt));
      return results;
    });
  }
}
