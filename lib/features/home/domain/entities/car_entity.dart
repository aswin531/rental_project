class CarVehicle {
  final String carId;
  String make;
  String engine;
  int seatCapacity;
  String model;
  String body;
  int year;
  String color;
  double rentalPriceDay;
  bool status;
  String mainImageUrl;
  List<String> imageUrls;

  CarVehicle({
    required this.carId,
    required this.make,
    required this.engine,
    required this.seatCapacity,
    required this.model,
    required this.body,
    required this.year,
    required this.color,
    required this.rentalPriceDay,
    required this.status,
    required this.imageUrls,
    required this.mainImageUrl,
  });

  factory CarVehicle.fromFirestoreDocument(
      Map<String, dynamic> map, String id) {
    return CarVehicle(
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
