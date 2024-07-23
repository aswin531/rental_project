// rental_request_data_source.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rentit/features/rental/data/model/request_form_model.dart';

abstract class RentalRequestDataSource {
  Future<void> createRentalRequest(RentalRequestModel request);
  Future<List<RentalRequestModel>> getUserRentalRequests(String userId);
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
  Future<List<RentalRequestModel>> getUserRentalRequests(String userId) async {
    final querySnapshot = await _firestore
        .collection('rental_requests')
        .where('userId', isEqualTo: userId)
        .get();
    return querySnapshot.docs
        .map((doc) => RentalRequestModel.fromJson(doc.data(), doc.id))
        .toList();
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
