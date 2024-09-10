import 'package:rentit/features/rental/domain/repository/rental_repo.dart';

class UpdateCarAvailabilityUsecase {
  final RentalRequestRepository rentalRequestRepository;

  UpdateCarAvailabilityUsecase(this.rentalRequestRepository);

  Future<bool> call(String carId, String? startDateString, String? endDateString) {
    DateTime? startDate = startDateString != null ? DateTime.parse(startDateString) : null;
    DateTime? endDate = endDateString != null ? DateTime.parse(endDateString) : null;

    return rentalRequestRepository.updateCarAvailability(
      carId,
      startDate,
      endDate,
    );
  }
}