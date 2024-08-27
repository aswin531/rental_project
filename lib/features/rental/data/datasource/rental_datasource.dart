// rental_request_data_source.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rentit/features/rental/data/model/car_req.dart';
import 'package:rentit/features/rental/data/model/combined.dart';
import 'package:rentit/features/rental/data/model/request_form_model.dart';

abstract class RentalRequestDataSource {
  Future<void> createRentalRequest(RentalRequestModel request);
  Future<List<RentalRequestWithCarDetails>> getUserRentalRequests(String userId);
  Future<void> updateRentalRequestStatus(String requestId, String status);
}

class FirebaseRentalRequestDataSource implements RentalRequestDataSource {
  final FirebaseFirestore _firestore;

  FirebaseRentalRequestDataSource(this._firestore);

  @override
  Future<void> createRentalRequest(RentalRequestModel request) async {
    await _firestore.collection('rental_requests').add(request.toJson());
  }

  @override
Future<List<RentalRequestWithCarDetails>> getUserRentalRequests(String userId) async {
  final rentalRequestsQuerySnapshot = await FirebaseFirestore.instance
      .collection('rental_requests')
      .where('userId', isEqualTo: userId)
      .get();

  List<RentalRequestWithCarDetails> results = [];

  for (var doc in rentalRequestsQuerySnapshot.docs) {
    final rentalRequest = RentalRequestModel.fromJson(doc.data(), doc.id);

    // Fetch car details
    final carDoc = await FirebaseFirestore.instance.collection('cars').doc(rentalRequest.carId).get();
    final carData = carDoc.data();
    final car = CarModel.fromJson(carData!, rentalRequest.carId);
    results.add(RentalRequestWithCarDetails(rentalRequest: rentalRequest, car: car));
  }

  return results;
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
