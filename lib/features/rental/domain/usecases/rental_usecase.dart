import 'package:rentit/features/rental/data/model/request_form_model.dart';
import 'package:rentit/features/rental/domain/entity/rental_entity.dart';
import 'package:rentit/features/rental/domain/repository/rental_repo.dart';

class CreateRentalRequest {
  final RentalRequestRepository repository;

  CreateRentalRequest(this.repository);

  Future<void> call(RentalRequest request) {
    final model = RentalRequestModel.fromEntity(request);
    return repository.createRentalRequest(model);
  }
}
