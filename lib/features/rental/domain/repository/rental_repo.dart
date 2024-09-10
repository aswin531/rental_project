import 'package:rentit/features/rental/data/model/combined.dart';
import 'package:rentit/features/rental/data/model/request_form_model.dart';

abstract class RentalRequestRepository {
  Future<void> createRentalRequest(RentalRequestModel request);
  Future<List<RentalRequestWithCarDetails>> getUserRentalRequests(String userId);
  Future<void> updateRentalRequestStatus(String requestId, String status);
  Future<bool> updateCarAvailability(String carId, DateTime? startDate, DateTime? endDate,);
  Future<void> completeReturnProcess(String requestId);
    Future<void> updateCarStatus(String carId, String status);

}