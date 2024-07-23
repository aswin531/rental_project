class RentalRequestModel {
  final String userId;
  final String carId;
  final DateTime startDate;
  final DateTime endDate;

  RentalRequestModel({
    required this.userId,
    required this.carId,
    required this.startDate,
    required this.endDate,
  });

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'carId': carId,
      'startDate': startDate.toIso8601String(),
      'endDate': endDate.toIso8601String(),
    };
  }

  static RentalRequestModel fromJson(Map<String, dynamic> json, String id) {
    return RentalRequestModel(
      userId: json['userId'],
      carId: json['carId'],
      startDate: DateTime.parse(json['rentalDate']),
      endDate: DateTime.parse(json['rentalDate']),
    );
  }
}
