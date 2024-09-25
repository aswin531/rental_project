import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rentit/core/injection_container/dependency_injection.dart';
import 'package:rentit/features/returncar/data/model/car_return_model.dart';

abstract class ReturnCarDatasource {
  Future<void> carReturnInitiate(String userId);
  Future<void> carReturnConfirm(String userId, CarReturnModel carReturnModel);
}

class ReturnCarDataSourceImpl implements ReturnCarDatasource {

  ReturnCarDataSourceImpl();

  Future<String?> _findRentalRequestId(String userId) async {
    try {
      QuerySnapshot querySnapshot = await firebaseFirestore
          .collection("rental_requests")
          .where('userId', isEqualTo: userId)
          .where('status', isEqualTo: 'accepted')
          .limit(1)
          .get();
      if (querySnapshot.docs.isNotEmpty) {
        return querySnapshot.docs.first.id;
      } else {
        return null;
      }
    } catch (e) {
      throw Exception('Error finding rental request: $e');
    }
  }

  @override
  Future<void> carReturnInitiate(String userId) async {
    String? rentalId = await _findRentalRequestId(userId);
    if (rentalId == null) {
      throw Exception('No active rental request found for user $userId');
    }

    try {
      await firebaseFirestore
          .collection("rental_requests")
          .doc(rentalId)
          .update({
        'return_status': 'return_initiated',
        'return_initiated_at': DateTime.now().toIso8601String(),
      });
    } catch (e) {
      throw Exception('Failed to initiate car return: $e');
    }
  }

  @override
  Future<void> carReturnConfirm(String userId, CarReturnModel carReturnModel) async {
    String? rentalId = await _findRentalRequestId(userId);
    if (rentalId == null) {
      throw Exception('No active rental request found for user $userId');
    }

    try {
      await firebaseFirestore
          .collection("rental_requests")
          .doc(rentalId)
          .update({
        'return_status': 'returned',
        'return_details': carReturnModel.toJson(),
        'returned_at': DateTime.now().toIso8601String(),
      });
    } catch (e) {
      throw Exception('Failed to confirm car return: $e');
    }
  }
}