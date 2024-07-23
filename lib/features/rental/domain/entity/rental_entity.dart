import 'package:rentit/features/rental/data/model/request_form_model.dart';

class RentalRequest {
  final String userId;
  final String carId;
  final DateTime startDate;
  final DateTime endDate;

  RentalRequest({
    required this.userId,
    required this.carId,
    required this.startDate,
    required this.endDate,
  });

  RentalRequestModel toModel() {
    return RentalRequestModel(
      startDate: startDate,
      endDate: endDate,
      userId: userId,
      carId: carId,
    );
  }
}
