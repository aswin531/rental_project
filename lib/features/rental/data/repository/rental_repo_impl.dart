import 'package:rentit/features/rental/data/datasource/rental_datasource.dart';
import 'package:rentit/features/rental/data/model/request_form_model.dart';
import 'package:rentit/features/rental/domain/repository/rental_repo.dart';

class RentalRequestRepositoryImpl implements RentalRequestRepository {
  final RentalRequestDataSource dataSource;

  RentalRequestRepositoryImpl(this.dataSource);

  @override
  Future<void> createRentalRequest(RentalRequestModel request) {
    return dataSource.createRentalRequest(request);
  }

  @override
  Future<List<RentalRequestModel>> getUserRentalRequests(String userId) {
    return dataSource.getUserRentalRequests(userId);
  }

  @override
  Future<void> updateRentalRequestStatus(String requestId, String status) {
    return dataSource.updateRentalRequestStatus(requestId, status);
  }
}