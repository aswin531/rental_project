import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:rentit/features/returncar/data/model/car_return_model.dart';

abstract class ReturnCarDatasource {
  Future<void> carReturnInitiate(String userId);
  Future<void> carReturnConfirm(String userId, CarReturnModel carReturnModel);
}

class ReturnCarDataSourceImpl implements ReturnCarDatasource {
  final FirebaseFirestore firebaseFirestore;

  ReturnCarDataSourceImpl(this.firebaseFirestore);

  Future<String?> _findRentalRequestId(String userId) async {
    try {
      QuerySnapshot querySnapshot = await firebaseFirestore
          .collection("rental_requests")
          .where('userId', isEqualTo: userId)
          .where('status', isEqualTo: 'accepted')
          .limit(1)
          .get();
      debugPrint(querySnapshot.docChanges.length.toString());
      if (querySnapshot.docs.isNotEmpty) {
        return querySnapshot.docs.last.id;
      } else {
        debugPrint('No matching rental request found for user $userId');
        return null;
      }
    } catch (e) {
      debugPrint('Error finding rental request: $e');
      return null;
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
      debugPrint('Error initiating car return: $e');
      throw Exception('Failed to initiate car return');
    }
  }

  @override
  Future<void> carReturnConfirm(
      String userId, CarReturnModel carReturnModel) async {
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
      debugPrint('Error confirming car return: $e');
      throw Exception('Failed to confirm car return');
    }
  }
}
