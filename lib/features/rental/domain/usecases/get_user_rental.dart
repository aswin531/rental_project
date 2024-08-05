import 'package:rentit/features/rental/data/model/combined.dart';
import 'package:rentit/features/rental/domain/repository/rental_repo.dart';

class GetUserRentalRequests {
  final RentalRequestRepository repository;

  GetUserRentalRequests(this.repository);

  Future<List<RentalRequestWithCarDetails>> call(String userId) {
    return repository.getUserRentalRequests(userId);
  }
}