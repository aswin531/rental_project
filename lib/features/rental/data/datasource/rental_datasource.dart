// rental_request_data_source.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rentit/features/rental/data/model/car_req.dart';
import 'package:rentit/features/rental/data/model/combined.dart';
import 'package:rentit/features/rental/data/model/request_form_model.dart';

abstract class RentalRequestDataSource {
  Future<void> createRentalRequest(RentalRequestModel request);
  Future<List<RentalRequestWithCarDetails>> getUserRentalRequests(
      String userId);
  Future<void> updateRentalRequestStatus(String requestId, String status);
  Future<void> updateCarAvailability(
      String carId, DateTime? startDate, DateTime? endDate, bool isAvailable);
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

    List<RentalRequestWithCarDetails> results = [];

    for (var doc in rentalRequestsQuerySnapshot.docs) {
      final rentalRequest = RentalRequestModel.fromJson(doc.data(), doc.id);

      // Fetch car details
      final carDoc = await FirebaseFirestore.instance
          .collection('cars')
          .doc(rentalRequest.carId)
          .get();
      final carData = carDoc.data();
      final car = CarModel.fromJson(carData!, rentalRequest.carId);
      results.add(
          RentalRequestWithCarDetails(rentalRequest: rentalRequest, car: car));
    }

    return results;
  }

  @override
  Future<void> updateCarAvailability(String carId, DateTime? startDate,
      DateTime? endDate, bool isAvailable) async {
    await _firestore.collection('cars').doc(carId).update({
      'isAvailable': isAvailable,
      'reservedFrom': startDate,
      'reservedUntil': endDate,
    });
  }

    @override
  Future<void> completeReturnProcess(String requestId) async {
    await _firestore.collection('rental_requests').doc(requestId).update({
      'status': 'completed',
      'actualReturnDate': DateTime.now(), // when the rental return process is marked as completed
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
