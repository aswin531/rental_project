import 'package:rentit/features/rental/data/model/request_form_model.dart';
import 'package:rentit/features/rental/domain/repository/rental_repo.dart';

class GetUserRentalRequests {
  final RentalRequestRepository repository;

  GetUserRentalRequests(this.repository);

  Future<List<RentalRequestModel>> call(String userId) {
    return repository.getUserRentalRequests(userId);
  }
}