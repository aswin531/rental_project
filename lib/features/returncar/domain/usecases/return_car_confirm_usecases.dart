import 'package:rentit/features/returncar/domain/entity/car_return_entity.dart';
import 'package:rentit/features/returncar/domain/repository/return_car_repository.dart';

class ReturnCarConfirmUsecase {
  final CarReturnRepository carReturnRepository;
  ReturnCarConfirmUsecase(this.carReturnRepository);

  Future<void> call(CarReturnEntity carReturnEntity) async {
    return await carReturnRepository.confirmCarReturn(carReturnEntity);
  }
}
