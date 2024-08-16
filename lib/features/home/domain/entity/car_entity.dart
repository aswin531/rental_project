import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CarVehicleEntity {
  String carId;
  String make;
  String engine;
  int seatCapacity;
  String model;
  String body;
  int year;
  String color;
  RangeValues rentalPriceRange;
  bool status;
  String mainImageUrl;
  List<String> imageUrls;

  CarVehicleEntity(
      {required this.carId,
      required this.make,
      required this.engine,
      required this.seatCapacity,
      required this.model,
      required this.body,
      required this.year,
      required this.color,
      required this.rentalPriceRange,
      required this.status,
      required this.imageUrls,
      required this.mainImageUrl});

  Map<String, dynamic> toFireStoreDocument() {
    return {
      "make": make,
      "engine": engine,
      "seatCapacity": seatCapacity,
      "model": model,
      "body": body,
      "year": year,
      "color": color,
      'rentalPriceRange': {
        'start': rentalPriceRange.start,
        'end': rentalPriceRange.end,
      },
      "status": status,
      "mainimageUrl": mainImageUrl,
      "imageUrls": imageUrls,
    };
  }

  factory CarVehicleEntity.fromSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;
    return CarVehicleEntity(
        carId: snapshot.id,
        make: data["make"] ?? "Toyota",
        engine: data["engine"] ?? "Camry",
        seatCapacity: data["seatCapacity"] ?? 5,
        model: data["model"] ?? "Unknown Model",
        body: data["body"] ?? "Unknown Body",
        year: data["year"] ?? 2000,
        color: data["color"] ?? "Unknown Color",
        rentalPriceRange: data['rentalPriceRange'] != null
            ? RangeValues(
                data['rentalPriceRange']['start']?.toDouble() ?? 0.0,
                data['rentalPriceRange']['end']?.toDouble() ?? 0.0,
              )
            : const RangeValues(0.0, 0.0),
        status: data["status"] ?? false,
        imageUrls: List<String>.from(data["imageUrls"] ?? []),
        mainImageUrl: data["mainImageUrl"] as String? ?? '');
  }
}
