import 'package:rentit/features/rental/data/model/combined.dart';
import 'package:rentit/features/rental/data/model/request_form_model.dart';

abstract class RentalRequestRepository {
  Future<void> createRentalRequest(RentalRequestModel request);
  Future<List<RentalRequestWithCarDetails>> getUserRentalRequests(String userId);
  Future<void> updateRentalRequestStatus(String requestId, String status);
  Future<void> updateCarAvailability(String carId, DateTime? startDate, DateTime? endDate, bool isAvailable);
  Future<void> completeReturnProcess(String requestId);
}