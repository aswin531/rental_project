import 'package:rentit/features/rental/domain/repository/rental_repo.dart';

class CompleteReturnProcessUsecase {
  final RentalRequestRepository rentalRequestRepository;

  CompleteReturnProcessUsecase(this.rentalRequestRepository);

  Future<void> call(String requestId) async {
   // final now = DateTime.now();
    // final isLate = now.isAfter(expectedReturnDate);
    // if (isLate) {
    //   final lateFee = calculateLateFee(expectedReturnDate, now);
    //   // Perform actions like charging the late fee or updating rental costs.
    // }
    // await rentalRequestRepository.completeReturnProcess(requestId);
  }

  double calculateLateFee(DateTime expected, DateTime actual) {
    final difference = actual.difference(expected).inHours;
    return difference * 10.0; // calculation: $10 per late.
  }
}
