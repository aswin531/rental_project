import 'package:rentit/features/rental/data/datasource/rental_datasource.dart';
import 'package:rentit/features/rental/data/model/combined.dart';
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
  Stream<List<RentalRequestWithCarDetails>> getUserRentalRequests(
      String userId) {
    return dataSource.getUserRentalRequests(userId);
  }

  @override
  Future<void> updateRentalRequestStatus(String requestId, String status) {
    return dataSource.updateRentalRequestStatus(requestId, status);
  }

  @override
  Future<bool> updateCarAvailability(
      String carId, DateTime? startDate, DateTime? endDate) {
    return dataSource.isCarAvailable(
        carId, startDate, endDate);
  }

  @override
  Future<void> completeReturnProcess(String requestId) {
    return dataSource.completeReturnProcess(requestId);
  }
  
  @override
  Future<void> updateCarStatus(String carId, String status) {
    throw UnimplementedError();
  }
}
