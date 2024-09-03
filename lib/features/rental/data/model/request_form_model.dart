import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../domain/entity/rental_entity.dart';

class RentalRequestModel extends RentalRequest {
  RentalRequestModel({
    super.id,
    required super.carId,
    required super.userId,
    required super.pickupDate,
    required super.returnDate,
    required super.pickupTime,
   required super.returnTime,
    required super.name,
    required super.phone,
    required super.address,
    required super.licenseNumber,
    required super.email,
    required super.createdAt,
    super.comments,
    required super.status,
    super.pickUpLocation,
    super.dropOffLocation,
    super.estimatedCost,
    //*************** */
  });

  factory RentalRequestModel.fromJson(Map<String, dynamic> json, String id) {
    return RentalRequestModel(
      id: id,
      carId: json['carId'] as String,
      userId: json['userId'] as String,
      pickupDate: (json['pickupDate'] ).toDate(),
      returnDate: (json['returnDate']).toDate(),
      pickupTime: (json['pickupTime'] as Timestamp).toDate(),
      returnTime: (json['returnTime'] as Timestamp).toDate(),
      name: json['name'] as String,
      phone: json['phone'] as String,
      address: json['address'] as String,
      licenseNumber: json['licenseNumber'] as String,
      email: json['email'] as String,
      comments: json['comments'] as String?,
      createdAt: (json['createdAt'] ).toDate(),
      status: RentalRequestStatus.values.firstWhere(
          (element) =>
              element.toString().split('.').last ==
              json[
                  'status'], //Constructs a string in the format "RentalRequestStatus.<status>"
          orElse: () => RentalRequestStatus.pending),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'carId': carId,
      'userId': userId,
      'pickupDate': Timestamp.fromDate(pickupDate),
      'returnDate': Timestamp.fromDate(returnDate),
      // ignore: unnecessary_null_comparison
      'pickupTime': pickupTime != null ? Timestamp.fromDate(pickupTime) : null,
      // ignore: unnecessary_null_comparison
      'returnTime': pickupTime != null ? Timestamp.fromDate(returnTime) : null,
      'name': name,
      'phone': phone,
      'address': address,
      'licenseNumber': licenseNumber,
      'email': email,
      'comments': comments,
      'createdAt': Timestamp.fromDate(createdAt),
      'status': status
          .toString()
          .split('.')
          .last,           //splitting status.toString() => RentalRequestStatus.<status>
      'pickUpLocation': pickUpLocation,
      'dropOffLocation': dropOffLocation,  
      'estimatedCost':estimatedCost,

          
    };
  }

  // Convert entity to model
  factory RentalRequestModel.fromEntity(RentalRequest entity) {
    return RentalRequestModel(
      id: entity.id,
      carId: entity.carId,
      userId: entity.userId,
      pickupDate: entity.pickupDate,
      returnDate: entity.returnDate,
      pickupTime: entity.pickupTime,
      returnTime: entity.returnTime,
      name: entity.name,
      phone: entity.phone,
      address: entity.address,
      licenseNumber: entity.licenseNumber,
      email: entity.email,
      comments: entity.comments,
      createdAt: entity.createdAt,
      status: entity.status,
      pickUpLocation: entity.pickUpLocation,
      dropOffLocation: entity.dropOffLocation,
      estimatedCost: entity.estimatedCost
    );
  }
}

Color getStatusColor(RentalRequestStatus status) {
  switch (status) {
    case RentalRequestStatus.pending:
      return const Color.fromARGB(255, 58, 110, 170);
    case RentalRequestStatus.accepted:
      return Colors.green;
    case RentalRequestStatus.rejected:
      return Colors.red;
    default:
      return Colors.black;
  }
}

//'maintenanceDate': maintenanceDate.toIso8601String(),
