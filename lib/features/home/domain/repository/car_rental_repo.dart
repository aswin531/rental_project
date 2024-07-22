import 'package:rentit/features/home/domain/entity/car_entity.dart';

abstract class CarRepository {
  Future<List<CarVehicleEntity>> getCars();
}