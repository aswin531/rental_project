import 'package:rentit/features/rental/domain/repository/rental_repo.dart';

class UpdateRentalRequestStatus {
  final RentalRequestRepository repository;

  UpdateRentalRequestStatus(this.repository);

  Future<void> call(String requestId, String status) {
    return repository.updateRentalRequestStatus(requestId, status);
  }
}