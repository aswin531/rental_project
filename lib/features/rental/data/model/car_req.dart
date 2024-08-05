import 'package:flutter/material.dart';

class CarModel {
  final String make;
  final String engine;
  final int seatCapacity;
  final String model;
  final String body;
  final int year;
  final String color;
  final RangeValues rentalPriceRange;
  List<String> imageUrls;

  CarModel({
    required this.make,
    required this.engine,
    required this.seatCapacity,
    required this.model,
    required this.body,
    required this.year,
    required this.color,
    required this.rentalPriceRange,
    required this.imageUrls,
  });

  factory CarModel.fromJson(Map<String, dynamic> json, String id) {
    return CarModel(
      make: json["make"] ?? "Toyota",
      engine: json["engine"] ?? "Camry",
      seatCapacity: json["seatCapacity"] ?? 5,
      model: json["model"] ?? "Unknown Model",
       body: json["body"] ?? "Unknown Body",
       year: json["year"] ?? 2000,
        color: json["color"] ?? "Unknown Color",
      rentalPriceRange: json['rentalPriceRange'] != null
            ? RangeValues(
                json['rentalPriceRange']['start']?.toDouble() ?? 0.0,
                json['rentalPriceRange']['end']?.toDouble() ?? 0.0,
              )
            : const RangeValues(0.0, 0.0),
      imageUrls: List<String>.from(json["imageUrls"] ?? []),
    );
  }
}
