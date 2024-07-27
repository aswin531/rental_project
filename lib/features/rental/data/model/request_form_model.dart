// In lib/features/rental/data/models/rental_request_model.dart

import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entity/rental_entity.dart';

class RentalRequestModel extends RentalRequest {
  RentalRequestModel({
    String? id,
    required String carId,
    required String userId,
    required DateTime startDate,
    required DateTime endDate,
    required bool isPickup,
    required bool isDelivery,
    String? pickupTime,
    String? pickupArrival,
    String? deliveryTime,
    String? deliveryPlace,
    required String name,
    required String phone,
    required String address,
    required String licenseNumber,
    String? comment,
  }) : super(
          id: id,
          carId: carId,
          userId: userId,
          startDate: startDate,
          endDate: endDate,
          isPickup: isPickup,
          isDelivery: isDelivery,
          pickupTime: pickupTime,
          pickupArrival: pickupArrival,
          deliveryTime: deliveryTime,
          deliveryPlace: deliveryPlace,
          name: name,
          phone: phone,
          address: address,
          licenseNumber: licenseNumber,
          comment: comment,
        );

  factory RentalRequestModel.fromJson(Map<String, dynamic> json, String id) {
    return RentalRequestModel(
      id: id,
      carId: json['carId'] as String,
      userId: json['userId'] as String,
      startDate: (json['startDate'] as Timestamp).toDate(),
      endDate: (json['endDate'] as Timestamp).toDate(),
      isPickup: json['isPickup'] as bool,
      isDelivery: json['isDelivery'] as bool,
      pickupTime: json['pickupTime'] as String?,
      pickupArrival: json['pickupArrival'] as String?,
      deliveryTime: json['deliveryTime'] as String?,
      deliveryPlace: json['deliveryPlace'] as String?,
      name: json['name'] as String,
      phone: json['phone'] as String,
      address: json['address'] as String,
      licenseNumber: json['licenseNumber'] as String,
      comment: json['comment'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'carId': carId,
      'userId': userId,
      'startDate': Timestamp.fromDate(startDate),
      'endDate': Timestamp.fromDate(endDate),
      'isPickup': isPickup,
      'isDelivery': isDelivery,
      'pickupTime': pickupTime,
      'pickupArrival': pickupArrival,
      'deliveryTime': deliveryTime,
      'deliveryPlace': deliveryPlace,
      'name': name,
      'phone': phone,
      'address': address,
      'licenseNumber': licenseNumber,
      'comment': comment,
    };
  }

  // Convert entity to model
  factory RentalRequestModel.fromEntity(RentalRequest entity) {
    return RentalRequestModel(
      id: entity.id,
      carId: entity.carId,
      userId: entity.userId,
      startDate: entity.startDate,
      endDate: entity.endDate,
      isPickup: entity.isPickup,
      isDelivery: entity.isDelivery,
      pickupTime: entity.pickupTime,
      pickupArrival: entity.pickupArrival,
      deliveryTime: entity.deliveryTime,
      deliveryPlace: entity.deliveryPlace,
      name: entity.name,
      phone: entity.phone,
      address: entity.address,
      licenseNumber: entity.licenseNumber,
      comment: entity.comment,
    );
  }
}

//'maintenanceDate': maintenanceDate.toIso8601String(),
