import 'package:rentit/features/returncar/domain/entity/car_return_entity.dart';

abstract class CarReturnRepository {
  Future<void> carReturnInitial(String rentalId);
  Future<void> confirmCarReturn(CarReturnEntity carReturnEntity);
}

