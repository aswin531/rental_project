import 'package:rentit/features/home/domain/entities/car_entity.dart';

class CarVehicleModel extends CarVehicle {
  CarVehicleModel({
    required String carId,
    required String make,
    required String engine,
    required int seatCapacity,
    required String model,
    required String body,
    required int year,
    required String color,
    required double rentalPriceDay,
    required bool status,
    required List<String> imageUrls,
    required String mainImageUrl,
  }) : super(
          carId: carId,
          make: make,
          engine: engine,
          seatCapacity: seatCapacity,
          model: model,
          body: body,
          year: year,
          color: color,
          rentalPriceDay: rentalPriceDay,
          status: status,
          imageUrls: imageUrls,
          mainImageUrl: mainImageUrl,
        );

  factory CarVehicleModel.fromMap(Map<String, dynamic> map, String id) {
    return CarVehicleModel(
      carId: id,
      make: map["make"] ?? "",
      engine: map["engine"] ?? "",
      seatCapacity: map["seatCapacity"] ?? 0,
      model: map["model"] ?? "",
      body: map["body"] ?? "",
      year: map["year"] ?? 0,
      color: map["color"] ?? "",
      rentalPriceDay: (map["rentalPriceDay"] ?? 0).toDouble(),
      status: map["status"] ?? false,
      imageUrls: List<String>.from(map["imageUrls"] ?? []),
      mainImageUrl: map["mainImageUrl"] ?? "",
    );
  }
}
