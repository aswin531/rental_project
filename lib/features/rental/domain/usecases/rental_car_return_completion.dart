import 'package:rentit/features/rental/domain/repository/rental_repo.dart';

class CompleteReturnProcessUsecase {
  final RentalRequestRepository rentalRequestRepository;

  CompleteReturnProcessUsecase(this.rentalRequestRepository);

  Future<void> call(String requestId) {
    return rentalRequestRepository.completeReturnProcess(requestId);
  }
}
