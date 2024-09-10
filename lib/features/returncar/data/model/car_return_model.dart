import 'package:rentit/features/returncar/domain/entity/car_return_entity.dart';

class CarReturnModel extends CarReturnEntity {
  CarReturnModel(
      super.returnId,
      super.carId,
      super.userId,
      super.returnDate,
      super.isDamaged,
      super.fuelLevel,
      super.mileage,
      super.comments,
      super.lateFee,
      super.totalCost);

  factory CarReturnModel.fromJson(Map<String, dynamic> json) {
    return CarReturnModel(
        json['returnId'],
        json['carId'],
        json['userId'],
        json['returnDate'],
        json['isDamaged'],
        json['fuelLevel'],
        json['mileage'],
        json['comments'],
        json['lateFee'],
        json['totalCost']);
  }

  Map<String, dynamic> toJson() {
    return {
      'returnId': returnId,
      'carId': carId,
      'userId': userId,
      'returnDate': returnDate,
      'isDamaged': isDamaged,
      'fuelLevel': fuelLevel,
      'mileage': mileage,
      'comments': comments,
      'lateFee': lateFee,
      'totalCost': totalCost,
    };
  }
}
