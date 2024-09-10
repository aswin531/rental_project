class RentalRequest {
  final String? id;
  final String carId;
  final String userId;
  final DateTime pickupDate;
  final DateTime returnDate;
  final DateTime pickupTime;
  final DateTime returnTime;
  final String name;
  final String phone;
  final String address;
  final String licenseNumber;
  final String? comments;
  final RentalRequestStatus status;
  final String email;
  final DateTime createdAt;
  final String? pickUpLocation;
  final String? dropOffLocation;
  final double? estimatedCost;
  DateTime? actualReturnDate;
  bool? isLate;

  RentalRequest(
      {this.id,
      required this.carId,
      required this.userId,
      required this.pickupDate,
      required this.returnDate,
      required this.pickupTime,
      required this.returnTime,
      required this.name,
      required this.phone,
      required this.address,
      required this.licenseNumber,
      required this.email,
      required this.createdAt,
      this.comments,
      required this.status, //this.status = false, // Default status is false (pending)
      this.pickUpLocation,
      this.dropOffLocation,
      this.estimatedCost,
      this.actualReturnDate,
      this.isLate});
}

enum RentalRequestStatus { pending, accepted, rejected }
