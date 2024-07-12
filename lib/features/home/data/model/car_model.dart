import 'package:rentit/features/home/domain/entities/car_entity.dart';

class CarVehicleModel extends CarVehicle {
  CarVehicleModel({
    required super.carId,
    required super.make,
    required super.engine,
    required super.seatCapacity,
    required super.model,
    required super.body,
    required super.year,
    required super.color,
    required super.rentalPriceDay,
    required super.status,
    required super.imageUrls,
    required super.mainImageUrl,
  });

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
