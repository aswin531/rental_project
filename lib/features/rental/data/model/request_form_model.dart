// In lib/features/rental/data/models/rental_request_model.dart

import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entity/rental_entity.dart';

class RentalRequestModel extends RentalRequest {
  RentalRequestModel({
    super.id,
    required super.carId,
    required super.userId,
    required super.startDate,
    required super.endDate,
    required super.isPickup,
    required super.isDelivery,
    super.pickupTime,
    super.pickupArrival,
    super.deliveryTime,
    super.deliveryPlace,
    required super.name,
    required super.phone,
    required super.address,
    required super.licenseNumber,
    required super.email,
    required super.createdAt,
    super.comments,
    required super.status,
  });

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
        email: json['email'] as String,
        comments: json['comments'] as String?,
        createdAt: json['createdAt'] as DateTime,
        status: RentalRequestStatus.values.firstWhere(
            (element) =>
                element.toString() ==
                'RentalRequestStatus.${json['status']}', //Constructs a string in the format "RentalRequestStatus.<status>"
            orElse: () => RentalRequestStatus.pending));
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
      'email': email,
      'comments': comments,
      'createdAt': createdAt,
      'status': status.toString().split('.').last, //splitting status.toString() => RentalRequestStatus.<status>
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
      email: entity.email,
      comments: entity.comments,
      createdAt: entity.createdAt,
      status: entity.status,
    );
  }
}

//'maintenanceDate': maintenanceDate.toIso8601String(),
