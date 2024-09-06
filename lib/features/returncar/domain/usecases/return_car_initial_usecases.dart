import 'package:rentit/features/returncar/domain/repository/return_car_repository.dart';

class ReturnCarInitialUsecases {
  final CarReturnRepository carReturnRepository;
  ReturnCarInitialUsecases(this.carReturnRepository);

  Future<void> call(String rentalId) async {
    return await carReturnRepository.carReturnInitial(rentalId);
  }
}

