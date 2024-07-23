import 'package:rentit/features/rental/domain/entity/rental_entity.dart';
import 'package:rentit/features/rental/domain/repository/rental_repo.dart';

class CreateRentalRequest {
  final RentalRequestRepository repository;

  CreateRentalRequest(this.repository);

  Future<void> call(RentalRequest request) {
    final model = request.toModel();
    return repository.createRentalRequest(model);
  }
}
