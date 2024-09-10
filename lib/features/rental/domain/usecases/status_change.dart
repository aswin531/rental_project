import 'package:rentit/features/rental/domain/repository/rental_repo.dart';

class UpdateCarStatusUseCase {
  final RentalRequestRepository rentalRequestRepository;

  UpdateCarStatusUseCase(this.rentalRequestRepository);

  Future<void> call(String carId, String status) {
    return rentalRequestRepository.updateCarStatus(carId, status);
  }
}