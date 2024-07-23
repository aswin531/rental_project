import 'package:rentit/features/rental/data/model/request_form_model.dart';

abstract class RentalRequestRepository {
  Future<void> createRentalRequest(RentalRequestModel request);
  Future<List<RentalRequestModel>> getUserRentalRequests(String userId);
  Future<void> updateRentalRequestStatus(String requestId, String status);
}