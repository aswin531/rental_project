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
}
