import 'package:rentit/features/rental/domain/repository/rental_repo.dart';

class UpdateCarAvailabilityUsecase {
  final RentalRequestRepository rentalRequestRepository;

  UpdateCarAvailabilityUsecase(this.rentalRequestRepository);

  Future<void> call(
      String carId, DateTime? startDate, DateTime? endDate, bool isAvailable) {
    return rentalRequestRepository.updateCarAvailability(
        carId, startDate, endDate, isAvailable);
  }
}
