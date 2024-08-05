// In lib/features/rental/domain/entity/rental_entity.dart

class RentalRequest {
  final String? id; // Added id field
  final String carId;
  final String userId;
  final DateTime startDate;
  final DateTime endDate;
  final bool isPickup;
  final bool isDelivery;
  final String? pickupTime;
  final String? pickupArrival;
  final String? deliveryTime;
  final String? deliveryPlace;
  final String name;
  final String phone;
  final String address;
  final String licenseNumber;
  final String? comments;
  final RentalRequestStatus status;
  final String email;
  final DateTime createdAt;

  RentalRequest(
      {this.id,
      required this.carId,
      required this.userId,
      required this.startDate,
      required this.endDate,
      required this.isPickup,
      required this.isDelivery,
      this.pickupTime,
      this.pickupArrival,
      this.deliveryTime,
      this.deliveryPlace,
      required this.name,
      required this.phone,
      required this.address,
      required this.licenseNumber,
      required this.email,
      required this.createdAt,
      this.comments,
      required this.status //this.status = false, // Default status is false (pending)
      });
}


enum RentalRequestStatus { pending, accepted, rejected }
